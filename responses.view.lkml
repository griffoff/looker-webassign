view: responses {
#  sql_table_name: TEST.PG_TEST_RESPONSES ;;
  view_label: "Responses"
 derived_table: {

  create_process: {
    sql_step:
      CREATE TRANSIENT TABLE IF NOT EXISTS looker_scratch.responses_deduped
      CLUSTER BY (question_id, boxnum)
      (
          id INT
          , deployment_id INT
          , user_id INT
          , question_id INT
          , boxnum INT
          , is_correct INT
          , logged TIMESTAMP_TZ
          , attempt_num INT
          , override_score NUMBER(27, 9)
          , points_scored NUMBER(27, 9)
          , total NUMBER(27, 9)
          , response STRING
          , ptr INT
          , seed STRING
          , def STRING
          , logloc INT
      )
      ;;

    sql_step:
        MERGE INTO looker_scratch.responses_deduped t
          USING (
                  SELECT MIN(r.id) AS id
                       , r.deployment_id
                       , r.user_id
                       , r.question_id
                       , r.boxnum
                       , r.is_correct
                       , MIN(r.logged) AS logged
                       , r.attempt_num
                       , r.override_score
                       , r.points_scored
                       , r.total
                       , r.response
                       , r.ptr
                       , r.seed
                       , r.def
                       , r.logloc
                  FROM prod.webassign.responses r
                  WHERE logged > (
                                   SELECT COALESCE(MAX(logged), '1970-01-10')
                                   FROM looker_scratch.responses_deduped
                                 )
                  GROUP BY r.deployment_id
                         , r.user_id
                         , r.question_id
                         , r.boxnum
                         , r.is_correct
                         , r.attempt_num
                         , r.override_score
                         , r.points_scored
                         , r.total
                         , r.response
                         , r.ptr
                         , r.seed
                         , r.def
                         , r.logloc
                  ORDER BY r.question_id, r.boxnum
                ) s ON (t.deployment_id, t.user_id, t.question_id, t.boxnum, t.attempt_num) = (s.deployment_id, s.user_id, s.question_id, s.boxnum, s.attempt_num)
          WHEN NOT MATCHED THEN INSERT (
            id
            ,deployment_id
            , user_id
            , question_id
            , boxnum
            , is_correct
            , logged
            , attempt_num
            , override_score
            , points_scored
            , total
            , response
            , ptr
            , SEED
            , def
            , logloc
            )
            VALUES (s.id
                   , s.deployment_id
                   , s.user_id
                   , s.question_id
                   , s.boxnum
                   , s.is_correct
                   , s.logged
                   , s.attempt_num
                   , s.override_score
                   , s.points_scored
                   , s.total
                   , s.response
                   , s.ptr
                   , s.SEED
                   , s.def
                   , s.logloc)
        ;;

    sql_step:
      ALTER TABLE looker_scratch.responses_deduped RECLUSTER
    ;;

    sql_step:
      CREATE OR REPLACE TRANSIENT TABLE ${SQL_TABLE_NAME}
      CLUSTER BY (logged)
      AS
      WITH r AS (
                  SELECT *
                       , datediff(SECOND, logged, logged) AS time_secs
                       , percent_rank() OVER (PARTITION BY question_id, boxnum ORDER BY time_secs) AS q_percentile
                  FROM looker_scratch.responses_deduped
                )
         , q AS (
                  SELECT question_id
                       , boxnum
                       --include up to 96% of the data for calculating stats, so as to exclude outliers
                       , avg(
                          CASE WHEN q_percentile <= 0.96 AND time_secs <= (60 * 15) THEN time_secs END) AS q_avg_excl_outliers
                       , median(
                          CASE WHEN q_percentile <= 0.96 AND time_secs <= (60 * 15) THEN time_secs END) AS q_median_excl_outliers
                       , max(CASE WHEN q_percentile <= 0.96 THEN time_secs END) AS q_max_excl_outliers
                       --stats for entire population
                       , avg(time_secs) AS q_avg
                       , median(time_secs) AS q_median
                       , max(time_secs) AS q_max
                  FROM r
                  GROUP BY 1, 2
                )
         , final_response AS (
                               SELECT r.user_id
                                    , r.deployment_id
                                    , r.question_id
                                    , r.boxnum
                                    , max(attempt_num) AS final_attempt_num
                                    , min(logged) AS first_attempt_start
                                    , max(logged) AS final_attempt_finish
                                    , sum(CASE
                                            WHEN r.time_secs > least(q_max_excl_outliers, 15 * 60) THEN NULL
                                            ELSE r.time_secs
                                          END) AS total_time_secs
                                    , avg(CASE
                                            WHEN r.time_secs > least(q_max_excl_outliers, 15 * 60) THEN NULL
                                            ELSE r.time_secs
                                          END) AS avg_time_secs
                                    --THIS FAILS AT THE MOMENT, BUT IS FASTER THAN THE WORKAROUND : USE ARRAY_TO_STRING(ARRAY_AGG())
                                    --  ,listagg(
                                    --         to_varchar(logged, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')
                                    --          ,'\n') within group (order by attempt_num)::string as all_attempt_starts
                                    , max(CASE WHEN attempt_num = 1 THEN is_correct ELSE 0 END) AS correct_attempt_1
                                    , max(CASE WHEN attempt_num <= 2 THEN is_correct ELSE 0 END) AS correct_attempt_in_2
                                    , max(CASE WHEN attempt_num <= 3 THEN is_correct ELSE 0 END) AS correct_attempt_in_3
                                    --  ,array_to_string(
                                    --    array_agg(to_varchar(logged, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')) within group (order by attempt_num)
                                    --    , '\n')
                                    , 'TO DO' AS all_attempt_starts
                                    --  ,array_to_string(array_agg(
                                    --      object_construct(
                                    --        'attempt', attempt_num
                                    --        ,'start', to_varchar(logged, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')
                                    --        ,'finish', to_varchar(logged, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')
                                    --        ,'points scored', points_scored
                                    --        ,'override', override_score
                                    --      )
                                    --    ) within group (order by attempt_num)
                                    --  ,'\n*********\n')
                                    , 'TO DO' AS all_attempts
                               FROM r
                                    INNER JOIN q ON (r.question_id, r.boxnum) = (q.question_id, q.boxnum)
                               GROUP BY 1, 2, 3, 4
                             )
      SELECT
           --r.logged::date as Submission_Date
        r.*
           , CASE
               WHEN r.time_secs <= least(q_max_excl_outliers, 15 * 60) THEN r.time_secs
               ELSE NULL
             END AS derived_time_secs --replace time with null (unknown) for outliers so that they don't affect the average
           , avg(derived_time_secs) OVER (PARTITION BY r.deployment_id, r.question_id, r.boxnum) AS section_avg_time_secs
           , avg(derived_time_secs) OVER (PARTITION BY r.question_id, r.boxnum) AS question_avg_time_secs
           , datediff(SECOND, first_attempt_start, final_attempt_finish) AS question_duration_secs
           , f.final_attempt_num IS NOT NULL AS final_attempt
           , f.first_attempt_start
           , f.final_attempt_finish
           , f.total_time_secs
           , f.avg_time_secs
           , f.all_attempt_starts
           , f.all_attempts
           , f.correct_attempt_1
           , f.correct_attempt_in_2
           , f.correct_attempt_in_3
      FROM r
             INNER JOIN q ON (r.question_id, r.boxnum) = (q.question_id, q.boxnum)
             LEFT JOIN final_response f ON (r.user_id, r.deployment_id, r.question_id, r.boxnum, r.attempt_num) =
                                           (f.user_id, f.deployment_id, f.question_id, f.boxnum, f.final_attempt_num)
      ORDER BY logged;
    ;;

  }

      datagroup_trigger: responses_datagroup
    }


    set: all {fields: [id, userid, attemptnumber, iscorrect]}

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.ID ;;
      hidden: no
    }

#     dimension: reverse_attemptnumber {
#       label: "Reverse Attempt Number"
#     }

  dimension: first_attempt_start {type: date_raw}
  dimension: final_attempt_finish {type: date_raw}

  dimension: all_attempt_starts {
    type: string
  }

  dimension: all_attempts {
    type: string
  }


  dimension: total_time_taken {
    description: "Total time taken for all attempts (sum of individual attempts time taken)"
    type:number
    sql:${TABLE}.total_time_secs / 3600 / 24;;
    value_format_name: duration_hms
  }
  measure: avg_question_time {
    description: "Avg time taken for a question"
    type: average
    sql:${total_time_taken};;
    value_format_name: duration_hms
  }

  dimension: avg_time_taken {
    description: "Avg time taken for an attempt at this question by this student"
    type:number
    sql:${TABLE}.avg_time_secs / 3600 / 24;;
    value_format_name: duration_hms
  }
  dimension: question_attempt_section_avg_time_taken {
    description: "Avg time taken for an attempt at this question for all students in this class)"
    type: number
    sql: ${TABLE}.section_avg_time_secs / 3600 / 24;;
    value_format_name: duration_hms
  }
  dimension: question_attempt_avg_time_taken {
    description: "Avg time taken for an attempt at this question by anyone who did it"
    type: number
    sql: ${TABLE}.question_avg_time_secs / 3600 / 24;;
    value_format_name: duration_hms
  }
  dimension: attempt_time {
    description: "Time taken for this attempt"
    type:number
    # remove any value over 15 minutes
    sql: ${TABLE}.derived_time_secs / 3600 / 24;;
    value_format_name: duration_hms
  }
  measure: total_attempt_time {
    description: "Total time taken for all attempts"
    type: sum
    sql:${attempt_time};;
    value_format_name: duration_hms
  }
  measure: avg_attempt_time {
    description: "Total time taken for all attempts"
    type: average
    sql:${attempt_time};;
    value_format_name: duration_hms
  }
  dimension: attempt_time_buckets {
    description: "Time taken for this attempt (buckets of 10 seconds)"
    type:tier
    style: relational
    sql:${attempt_time};;
    tiers: [0.000115741, 0.000231481, 0.000347222, 0.000462963, 0.000578704, 0.000694444, 0.000810185, 0.000925926, 0.00104167, 0.00115741, 0.00127315, 0.00138889]
    value_format_name: duration_hms
  }
  dimension: question_duration {
    description: "Time taken from the start of the first attempt to the end of the last attempt"
    type:number
    sql:${TABLE}.question_duration_secs / 3600 / 24;;
    value_format_name: duration_hms
  }

  measure: min_attempt_start {
    type: date_raw
    sql: min(${first_attempt_start}) ;;
  }
  measure: max_attempt_finish {
    type: date_raw
    sql: max(${final_attempt_finish}) ;;
  }

  dimension: final_attempt {
    type: yesno
    sql: ${TABLE}.final_attempt ;;
  }

  dimension: first_attempt {
    type: yesno
    sql: ${attemptnumber} = 1 ;;
  }

  dimension: attemptnumber {
    label: "Attempt Number"
    type: number
    sql: ${TABLE}.ATTEMPT_NUM ;;
  }

  measure: avg_attemptnumber {
    label: "Average Attempts"
    description: "Average number of attempts made per question"
    type: average
    sql: case when ${final_attempt} then ${TABLE}.ATTEMPT_NUM end ;;
    value_format_name: decimal_1
  }

  measure: max_attemptnumber {
    label: "Max Attempts"
    #description: "Maximum of attempts made by students on a particular question"
    description: "Maximum number of attempts made per question"
    type: max
    sql: ${TABLE}.ATTEMPT_NUM ;;
    value_format_name: decimal_0
  }
  dimension: boxnum {
    label: "Box Num"
    type: number
    sql: ${TABLE}.BOXNUM ;;
  }

  dimension_group: createdat {
    label: "Create"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.logged ;;
    hidden: yes

  }

  dimension: iscorrect {
    label: "Is Correct"
    type: yesno
    sql: ${TABLE}.IS_CORRECT = 1 ;;
  }

  measure: correctincorrectpoints {
    label: "Correct/Incorrect - No Bonus"
    type: average
    value_format_name: percent_1
    sql: ${TABLE}.IS_CORRECT ;;
  }

  measure: numberwrong {
    label: "# Wrong"
    type: sum
#       sql:SELECT COUNT(*) FROM ${responses.SQL_TABLE_NAME}
#       WHERE ${TABLE}.IS_CORRECT = 0 ;;
  sql: CASE WHEN not ${iscorrect} THEN 1 END ;;
  }

  measure: numbercorrect {
    label: "# Correct"
    type: sum
    sql: ${TABLE}.IS_CORRECT;;
    drill_fields: [dim_question.question_id,iscorrect,attemptnumber]
  }

  dimension: question_user_key {
    hidden: yes
    type: string
    sql: hash(${questionid}, ${boxnum}, ${userid}) ;;
  }

  measure: response_question_correct_count {
    label: "# Unique questions answered correctly"
    type: count_distinct
    sql: case when ${iscorrect} then ${question_user_key} end ;;
  }

  measure: response_question_answered_count {
    label: "# Unique questions answered correctly"
    type: count_distinct
    sql: ${question_user_key} ;;
  }

  measure: response_question_correct_attempt_1 {
    label: "# questions correct on the first attempt"
    type: sum
    value_format_name: decimal_0
    sql: case when ${TABLE}.correct_attempt_1 = 1 then ${question_user_key} end ;;
  }

  measure: response_question_correct_attempt_in_2 {
    label: "# questions correct within first 2 attempts"
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${TABLE}.correct_attempt_in_2 = 1 then ${question_user_key} end ;;
  }

  measure: response_question_correct_attempt_in_3 {
    label: "# questions correct within first 3 attempts"
    type: count_distinct
    value_format_name: decimal_0
    sql: case when ${TABLE}.correct_attempt_in_3 = 1 then ${question_user_key} end ;;
  }

  measure: percentcorrect {
    label: "% Correct"
    type: number
    sql: ${numbercorrect} / nullif(${response_question_count}, 0);;
    value_format_name: percent_1
    drill_fields: [all*]
    html:
    <div style="width:100%;">
    <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
    </div>;;
  }

#     dimension: is_last_attempt {
#       type: yesno
#       sql: ${reverse_attemptnumber} = 1 ;;
#     }

  dimension: overridescore {
    label: "Override Score"
    type: number
    sql: ${TABLE}.OVERRIDE_SCORE ;;
  }

  dimension: points_scored {
    label: "Points Scored"
    type: number
    sql: ${TABLE}.POINTS_SCORED ;;
    hidden: yes
  }

  dimension: questionid {
    label: "Question ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.QUESTION_ID ;;
  }

  dimension: deployment_id {
    label: "Deployment ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.DEPLOYMENT_ID ;;
  }

  dimension_group: updatedat {
    label: "Submission"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.logged;;
  }

  dimension: userid {
    label: "User ID"
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.USER_ID ;;
  }

  measure: user_count {
    label: "# Users"
    description: "# Unique users who have submitted a response"
    type: count_distinct
    sql: ${userid} ;;
  }

  measure: response_question_count {
    label: "# Questions"
    description: "# Unique questions answered by students"
    type: count_distinct
    sql: hash(${questionid}, ${boxnum}) ;;
  }

  measure: response_submission_count {
    label: "# Submissions"
    description: "# Assignments submitted"
    type: count_distinct
    sql: hash(${deployment_id}, ${userid}) ;;
  }

  measure: assignment_count {
    label: "# Assignments"
    description: "# Unique assignments taken by one or more student"
    type: count_distinct
    sql: ${deployment_id} ;;
  }

  measure: score {
    label: "Score"
    type: sum
    sql: case when ${final_attempt} then ${points_scored} end;;
  }

  measure: count {
    label: "# Takes"
    description: "Total count of takes by students "
    type: count
    drill_fields: [all*]
  }

  dimension: points_received {
    label: "Item - Points Scored"
    type: number
    sql: ${TABLE}.POINTS_SCORED ;;
    hidden: no
  }

  dimension: points_possible {
    label: "Item - Points Possible"
    type: number
    sql: ${TABLE}.TOTAL ;;
    hidden: no
  }

  measure: scorepercentage{
    label: "Item Score (%)"
    type: average
    value_format: "0\%"
    sql: 100.0 * ${responses.points_received} / NULLIF(${responses.points_possible}, 0) ;;
  }

  measure: response_part_count {
    label: "# Question Parts"
    description: "# of question parts answered by students"
    type: count_distinct
    sql: hash(${questionid}, ${boxnum},${attemptnumber},${id}) ;;
  }

}
