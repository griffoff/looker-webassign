view: responses_extended {
  extends: [responses]

  dimension: start_date {
    type: date_raw
    sql: ${createdat_raw};;
  }

  dimension: due_date {
    type: date_raw
    sql: ${dim_deployment.due_et_raw};;
  }

  measure: performance_trend {
    description: "Average score last two weeks vs average score prior two weeks"
    type: number
    sql:  avg(case when datediff(day, ${submission_date}, ${dim_section.recency_date}) <=14 then ${points_scored} end)
      - avg(case when datediff(day, ${submission_date}, ${dim_section.recency_date}) between 15 and 28 then ${points_scored} end);;
    value_format_name: percent_1
  }

  dimension: assignment_start_recency {
    description: "How many days before due date was the assignment started?
    - Higher is better."
    sql: datediff(days, ${start_date}, ${due_date}) ;;
    value_format_name: decimal_0
  }

  dimension: assignment_submission_recency {
    description: "How many days before due date was the assignment submitted?
    - Higher is better."
    sql: datediff(days, ${submission_date}, ${due_date}) ;;
    value_format_name: decimal_0
  }

  measure: average_assignment_start_recency {
    type: average
    sql: ${assignment_start_recency} ;;
    value_format_name: decimal_1
  }

  measure: class_average_score {
    type: number
    sql: sum(sum(${points_scored})) over () / sum(count(*)) over ()  ;;
    value_format_name: percent_1
  }

  measure: percent_overdue {
    label: "% late submissions"
    type: number
    sql: count(distinct case when ${assignment_submission_recency} < 0 then ${deployment_id} end) / count(distinct ${deployment_id}) ;;
    value_format_name: percent_1
  }

}
view: responses {
  #sql_table_name: WA2ANALYTICS.RESPONSES ;;
  view_label: "Responses"
  derived_table: {
    sql:
      select
        to_date("CREATED_AT") as Submission_Date,*
      from wa_app_activity.responses
      where to_date("CREATED_AT") > '2016-01-01' ;;

sql_trigger_value: select count(*) from wa_app_activity.RESPONSES ;;
    }

    set: all {fields: [id, userid, dim_question.code, iscorrect]}

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.ID ;;
      hidden: yes
    }

#     dimension: reverse_attemptnumber {
#       label: "Reverse Attempt Number"
#     }

    dimension: attemptnumber {
      label: "Attempt Number"
      type: number
      sql: ${TABLE}.ATTEMPT_NUM ;;
    }

  measure: avg_attemptnumber {
    label: "Average Attempts"
    description: "Average number of attempts made per question"
    type: average_distinct
    sql: ${TABLE}.ATTEMPT_NUM ;;
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
    type: number
    sql: ${TABLE}.IS_CORRECT ;;
  }

  measure: numberwrong {
    label: "# Wrong"
    type: sum
#       sql:SELECT COUNT(*) FROM ${responses.SQL_TABLE_NAME}
#       WHERE ${TABLE}.IS_CORRECT = 0 ;;
  sql: CASE WHEN ${iscorrect} = 0 THEN 1 END ;;
  }

  measure: numbercorrect {
    label: "# Correct"
    type: sum
    sql: ${TABLE}.IS_CORRECT;;
    drill_fields: [dim_question.question_id,iscorrect,attemptnumber]
  }

  measure: percentcorrect_noformatting {
    label: "% Correct (no formatting)"
    type: number
    sql: ${numbercorrect} / nullif(${count}, 0);;
    value_format_name: percent_1
    drill_fields: [all*]
  }

  measure: percentcorrect {
    label: "% Correct"
    type: number
    sql: ${numbercorrect} / nullif(${count}, 0);;
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

  dimension: submission_date {
    type: date_raw
    sql:  ${TABLE}.UPDATED_AT;;
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
    sql: ${submission_date};;
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
    sql: ${TABLE}.QUESTION_ID ;;
  }

  measure: scores {
    label: "Score"
    type: sum
    sql: ${TABLE}.POINTS_SCORED;;
  }

  measure: count {
    label: "# Takes"
    description: "Total count of takes by students "
    type: count
    drill_fields: [all*]
  }

  measure: average_score {
    label: "Average Score"
    type: average
    sql: ${TABLE}.POINTS_SCORED;;
    value_format_name: percent_1
  }

  measure: question_average_attempts_variance {
    type: number
    sql: average(average(${points_scored}) over (partition by ${questionid}, ${boxnum}) - average(${points_scored}) over (partition by ${userid}, ${questionid}, ${boxnum})) ;;
    value_format_name: decimal_1
  }

  measure: average_essay_score  {
    group_label: "Question Modes"
    type:  average
    sql: case when ${dim_question_mode.is_essay} then ${points_scored} end ;;
    value_format_name: percent_1
  }

  measure: average_multiple_choice_score  {
    group_label: "Question Modes"
    type:  average
    sql: case when ${dim_question_mode.is_multiple_choice} then ${points_scored} end ;;
    value_format_name: percent_1
  }

  measure: average_fill_in_the_blank_score  {
    group_label: "Question Modes"
    type:  average
    sql: case when ${dim_question_mode.is_fill_in_the_blank} then ${points_scored} end ;;
    value_format_name: percent_1
  }

  measure: average_algebraic_score  {
    group_label: "Question Modes"
    type:  average
    sql: case when ${dim_question_mode.is_algebraic} then ${points_scored} end ;;
    value_format_name: percent_1
  }

}
