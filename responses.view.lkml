view: responses {
#  sql_table_name: TEST.PG_TEST_RESPONSES ;;
  view_label: "Responses"
 derived_table: {
    sql:
       with r as (
            select
              *
              ,datediff(second, logged, logged) as time_secs
              ,percent_rank() over (partition by question_id, boxnum order by time_secs) as q_percentile
            from PROD.WEBASSIGN.RESPONSES
        )
      ,q as (
          select
                question_id
                ,boxnum
                --include up to 96% of the data for calculating stats, so as to exclude outliers
                ,avg(case when q_percentile <= 0.96 and time_secs <= (60 * 15) then time_secs end) as q_avg_excl_outliers
                ,median(case when q_percentile <= 0.96 and time_secs <= (60 * 15)  then time_secs end) as q_median_excl_outliers
                ,max(case when q_percentile <= 0.96 then time_secs end) as q_max_excl_outliers
                --stats for entire population
                ,avg(time_secs) as q_avg
                ,median(time_secs) as q_median
                ,max(time_secs) as q_max
          from r
          group by 1, 2
        )
      ,final_response as (
            select
                r.user_id, r.deployment_id, r.question_id, r.boxnum
                ,max(attempt_num) as final_attempt_num
                ,min(logged) as first_attempt_start
                ,max(logged) as final_attempt_finish
                ,sum(case when r.time_secs > least(q_max_excl_outliers, 15 * 60) then null else r.time_secs end) as total_time_secs
                ,avg(case when r.time_secs > least(q_max_excl_outliers, 15 * 60) then null else r.time_secs end) as avg_time_secs
              --THIS FAILS AT THE MOMENT, BUT IS FASTER THAN THE WORKAROUND : USE ARRAY_TO_STRING(ARRAY_AGG())
              --  ,listagg(
              --         to_varchar(logged, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')
              --          ,'\n') within group (order by attempt_num)::string as all_attempt_starts
                ,max(case when attempt_num = 1 then is_correct else 0 end) as correct_attempt_1
                ,max(case when attempt_num <= 2 then is_correct else 0 end) as correct_attempt_in_2
                ,max(case when attempt_num <= 3 then is_correct else 0 end) as correct_attempt_in_3
              --  ,array_to_string(
              --    array_agg(to_varchar(logged, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')) within group (order by attempt_num)
              --    , '\n')
              ,'TO DO' as all_attempt_starts
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
              ,'TO DO'  as all_attempts
            from r
            inner join q on (r.question_id, r.boxnum) = (q.question_id, q.boxnum)
            group by 1, 2, 3, 4
        )
        select
            --r.logged::date as Submission_Date
            r.*
            ,case when r.time_secs <= least(q_max_excl_outliers, 15 * 60) then r.time_secs else null end as derived_time_secs --replace time with null (unknown) for outliers so that they don't affect the average
            ,avg(derived_time_secs) over (partition by r.deployment_id, r.question_id, r.boxnum) as section_avg_time_secs
            ,avg(derived_time_secs) over (partition by r.question_id, r.boxnum) as question_avg_time_secs
            ,datediff(second, first_attempt_start, final_attempt_finish) as question_duration_secs
            ,f.final_attempt_num is not null as final_attempt
            ,f.first_attempt_start
            ,f.final_attempt_finish
            ,f.total_time_secs
            ,f.avg_time_secs
            ,f.all_attempt_starts
            ,f.all_attempts
            ,f.correct_attempt_1
            ,f.correct_attempt_in_2
            ,f.correct_attempt_in_3
        from r
        inner join q on (r.question_id, r.boxnum) = (q.question_id, q.boxnum)
        left join final_response f on (r.user_id, r.deployment_id, r.question_id, r.boxnum, r.attempt_num) = (f.user_id, f.deployment_id, f.question_id, f.boxnum, f.final_attempt_num)

      ;;

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
