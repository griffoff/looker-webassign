# <<<<<<< HEAD
# =======
# view: responses_extended {
#   extends: [responses]
#
#   dimension: start_date {
#     type: date_raw
#     sql: ${createdat_raw};;
#   }
#
#   dimension: due_date {
#     type: date_raw
#     sql: ${dim_deployment.due_et_raw};;
#   }
#
#   dimension: course_start_date {
#     type: date_raw
#     sql: ${dim_section.start_date_raw} ;;
#     hidden: yes
#   }
#
#   dimension: weeks_relative_to_course_start {
#     type: number
#     sql: datediff(week, ${course_start_date}, ${createdat_raw})  ;;
#     value_format: "0 \w\e\e\k\s"
#   }
#
#   dimension: recency_date {
#     description: "A reference date for recency measures.
#     Get the earliest date of:
#      -  current date (for in progress courses)
#      -  course end date
#     "
#     # -  latest recorded response in the current context (for point in time reports)  "
#         # need to think about if/how this is possible
#     type: date_raw
#     hidden: yes
#     # need to think about if/how this is possible
#     #sql: least(${dim_section.recency_date}, max(${createdat_raw}) over ()) ;;
#     sql: ${dim_section.recency_date} ;;
#   }
#
#   measure: performance_trend {
#     description: "Average score last two weeks vs average score prior two weeks"
#     type: number
#     sql:  nvl(avg(case when datediff(day, ${submission_date}, ${recency_date}) <=14 then ${points_scored} end),0)
#       - nvl(avg(case when datediff(day, ${submission_date}, ${recency_date}) between 15 and 28 then ${points_scored} end),0);;
#     value_format_name: percent_1
#   }
#
#   dimension: assignment_start_recency {
#     description: "How many days before due date was the assignment started?
#     - Higher is better."
#     sql: datediff(days, ${start_date}, ${due_date}) ;;
#     value_format_name: decimal_0
#   }
#
#   dimension: assignment_submission_recency {
#     description: "How many days before due date was the assignment submitted?
#     - Higher is better."
#     sql: datediff(days, ${submission_date}, ${due_date}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: average_assignment_start_recency {
#     type: average
#     sql: ${assignment_start_recency} ;;
#     value_format_name: decimal_1
#   }
#
#   measure: class_average_score {
#     type: number
#     sql: sum(sum(${points_scored})) over () / sum(count(*)) over ()  ;;
#     value_format_name: percent_1
#   }
#
#   measure: percent_overdue {
#     label: "% late submissions"
#     type: number
#     sql: count(distinct case when ${assignment_submission_recency} < 0 then ${deployment_id} end) / count(distinct ${deployment_id}) ;;
#     value_format_name: percent_1
#   }
#
# }
# >>>>>>> branch 'master' of git@github.com:griffoff/looker-webassign.git
view: responses {
  #sql_table_name: WA2ANALYTICS.RESPONSES ;;
  view_label: "Responses"
  derived_table: {
#     sql:
#       select
#         to_date("CREATED_AT") as Submission_Date,*
#       from wa_app_activity.responses
#       where to_date("CREATED_AT") > '2016-01-01' ;;
    sql:
       with r as (
            select
              *
              ,datediff(second, created_at, updated_at) as time_secs
              ,percent_rank() over (partition by question_id, boxnum order by time_secs) as q_percentile
            from wa_app_activity.RESPONSES
            where CREATED_AT >= '2017-01-01'
        )
      ,q as (
          select
                question_id
                ,boxnum
                --include up to 96% of the data for calculating stats, so as to exclude outliers
                ,avg(case when q_percentile <= 0.96 then time_secs end) as q_avg_excl_outliers
                ,median(case when q_percentile <= 0.96 then time_secs end) as q_median_excl_outliers
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
                ,min(created_at) as first_attempt_start
                ,max(updated_at) as final_attempt_finish
                ,sum(case when r.time_secs > q_max_excl_outliers then null else r.time_secs end) as total_time_secs
                ,avg(case when r.time_secs > q_max_excl_outliers then null else r.time_secs end) as avg_time_secs
              --THIS FAILS AT THE MOMENT, BUT IS FASTER THAN THE WORKAROUND : USE ARRAY_TO_STRING(ARRAY_AGG())
              --  ,listagg(
              --         to_varchar(created_at, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')
              --          ,'\n') within group (order by attempt_num)::string as all_attempt_starts
                ,array_to_string(
                  array_agg(to_varchar(created_at, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')) within group (order by attempt_num)
                  , '\n') as all_attempt_starts
                ,array_to_string(array_agg(
                    object_construct(
                      'attempt', attempt_num
                      ,'start', to_varchar(created_at, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')
                      ,'finish', to_varchar(updated_at, 'YYYY-MM-DD HH24:mi:ss (TZHTZM)')
                      ,'points scored', points_scored
                      ,'override', override_score
                    )
                  ) within group (order by attempt_num)
                ,'\n*********\n')
                as all_attempts
            from r
            inner join q on (r.question_id, r.boxnum) = (q.question_id, q.boxnum)
            group by 1, 2, 3, 4
        )
        select
            --r.created_at::date as Submission_Date
            r.*
            ,case when r.time_secs > q_max_excl_outliers then null else r.time_secs end as derived_time_secs --replace time with null (unknown) for outliers so that they don't affect the average
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
        from r
        inner join q on (r.question_id, r.boxnum) = (q.question_id, q.boxnum)
        left join final_response f on (r.user_id, r.deployment_id, r.question_id, r.boxnum, r.attempt_num) = (f.user_id, f.deployment_id, f.question_id, f.boxnum, f.final_attempt_num)

      ;;

      #sql_trigger_value: select count(*) from wa_app_activity.RESPONSES ;;
      datagroup_trigger: responses_datagroup
    }

    set: all {fields: [id, userid, attemptnumber, iscorrect]}

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.ID ;;
      hidden: yes
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
    sql:${TABLE}.derived_time_secs / 3600 / 24;;
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
    sql: ${TABLE}.CREATED_AT ;;
    hidden: yes

  }

  dimension: iscorrect {
    label: "Is Correct"
    type: yesno
    sql: ${TABLE}.IS_CORRECT = 1 ;;
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
    sql: ${TABLE}.UPDATED_AT;;
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

}
