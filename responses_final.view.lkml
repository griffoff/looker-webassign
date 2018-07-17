view: responses_final {
  derived_table: {
    explore_source: responses {
      column: questionid {}
      column: userid {}
      column: boxnum {}
      column: attempts {field:responses.attemptnumber}
      # these are useful for looking at details of the attempts
      # but they slow down the generation of the PDT
      column: all_attempt_starts {}
      column: all_attempts {}
      #
      column: overridescore {}
      column: deployment_id {}
      column: iscorrect {}
      column: final_score {field:responses.points_scored}
      column: question_start {field:responses.first_attempt_start}
      column: question_finish {field:responses.final_attempt_finish}
      column: question_duration {}
      column: question_attempt_avg_time_taken {}
      column: question_attempt_section_avg_time_taken {}
      column: question_time_taken {field:responses.total_time_taken}
      column: attempt_time {}
      column: attempt_avg_time_taken {field:responses.avg_time_taken}
      column: qdiff_avg_attempts {field: dim_question.qdiff_avg_attempts}
      column: qdiff_pct_correct_attempt_1 {field:dim_question.qdiff_pct_correct_attempt_1}
      column: taq_avg_time_secs {field:dim_question.taq_avg_time_secs}
      filters: {
        field: responses.final_attempt
        value: "Yes"
      }
    }
    datagroup_trigger: responses_datagroup
  }

  set: details {fields: [questionid, boxnum, question_start, attempts, iscorrect, final_score, qdiff_avg_attempts]}

  dimension: deployment_id {
    hidden: yes
    type: number
  }
  dimension: userid {
    hidden: yes
    type: number
  }
  dimension: questionid {
#     hidden: yes
    type: number
  }
  dimension: boxnum {
#     hidden: yes
    type: number
  }

  dimension: pk {
    hidden: yes
    primary_key: yes
    sql: hash(${deployment_id}, '||', ${userid}, '||', ${questionid}, '||', ${boxnum}) ;;
  }

  # these are useful for looking at details of the attempts
  # but they slow down the generation of the PDT
  dimension: all_attempt_starts {type: string}
  dimension: all_attempts {type: string}
  #

  dimension: attempts {
    label: "# Attempts"
    type: number
  }
  dimension: overridescore {
    label: "Override Score"
    type: number
  }

  dimension: question_start {type: date_raw}
  dimension: question_finish {type: date_raw}

  dimension: final_score {type: number}
  dimension: iscorrect {type: number sql: decode(${TABLE}.iscorrect, 'Yes', 1);;}

  dimension: qdiff_avg_attempts {type: number value_format_name: decimal_1}
  dimension: qdiff_pct_correct_attempt_1 {type: number sql: ${TABLE}.qdiff_pct_correct_attempt_1 / 100 ;; value_format_name: percent_1}
  dimension: taq_avg_time {
    type: number
    sql: ${TABLE}.taq_avg_time_secs / 3600 / 24 ;;
    value_format_name: duration_hms
  }

  dimension: question_attempt_avg_time_taken {type: number value_format_name: duration_hms}
  dimension: question_attempt_section_avg_time_taken {type: number value_format_name: duration_hms}
  dimension: attempt_avg_time_taken {type: number value_format_name: duration_hms}
  dimension: attempt_time {type: number value_format_name: duration_hms}
  dimension: question_duration {type: number value_format_name: duration_hms}
  dimension: question_time_taken {type: number value_format_name: duration_hms}

  measure: avg_attempt_time_vs_section {
    type: average
    sql: (${attempt_avg_time_taken} / ${question_attempt_section_avg_time_taken}) - 1;;
    value_format_name: percent_1
  }

  measure: avg_attempt_time_vs_all {
    type: average
    sql: (${attempt_avg_time_taken} / ${question_attempt_avg_time_taken}) - 1;;
    value_format_name: percent_1
  }

  measure: number_correct  {
    type:sum
    sql:${iscorrect};;
  }

  dimension: course_start_date {
    type: date_raw
    sql: ${dim_section.start_date_raw} ;;
    hidden: yes
  }

  dimension: weeks_relative_to_course_start {
    type: number
    sql: datediff(week, ${course_start_date}, ${question_start})  ;;
    value_format: "0 \w\e\e\k\s"
  }

  dimension: recency_date {
    description: "A reference date for recency measures.
    Get the earliest date of:
    -  current date (for in progress courses)
    -  course end date
    "
    # -  latest recorded response in the current context (for point in time reports)  "
    # need to think about if/how this is possible
    type: date_raw
    hidden: yes
    # need to think about if/how this is possible
    #sql: least(${dim_section.recency_date}, max(${createdat_raw}) over ()) ;;
    sql: ${dim_section.recency_date} ;;
  }

  measure: average_score {
    label: "Average Score"
    type: average
    sql: ${final_score};;
    value_format_name: percent_1
    drill_fields: [details*]
  }
  measure: average_attempts {
    label: "Average Attempts"
    type: average
    sql: ${attempts};;
    value_format_name: decimal_1
  }

  measure: attempts_list {
    type: string
    sql: array_agg(${attempts}) within group (order by ${question_start}) ;;
    drill_fields: [details*]
  }

  measure: scores_list {
    type: string
    sql: array_agg(${final_score}) within group (order by ${question_start}) ;;
    drill_fields: [details*]
  }

  measure: avg_time_taken  {
    type: average
    sql: ${question_time_taken} ;;
#     value_format_name: duration_hms
    value_format: "hh:mm:ss"
  }

  measure: performance_trend {
    description: "Average score last two weeks vs average score prior two weeks"
    type: number
    sql:  avg(case when datediff(day, ${question_finish}, ${recency_date}) <=14 then ${final_score} end)
      - avg(case when datediff(day, ${question_finish}, ${recency_date}) between 15 and 28 then ${final_score} end);;
    value_format_name: percent_1
  }

  measure: cohort_average_score {
    type: number
    sql: sum(sum(${final_score})) over () / sum(count(*)) over ()  ;;
    value_format_name: percent_1
  }

  measure: count {
    label: "# Questions"
    type: count
  }

  measure: percent_correct {
    label: "% Correct"
    type: number
    sql: ${number_correct} / nullif(${count}, 0);;
    value_format_name: percent_1
  }

  measure: question_average_attempts_variance {
    type: average
    sql: ${qdiff_avg_attempts} - ${attempts} ;;
    value_format_name: decimal_1
  }

  measure: average_essay_score  {
    group_label: "Question Modes"
    type:  average
    sql: case when ${dim_question_mode.is_essay} then ${final_score} end ;;
    value_format_name: percent_1
  }

  measure: average_multiple_choice_score  {
    group_label: "Question Modes"
    type:  average
    sql: case when ${dim_question_mode.is_multiple_choice} then ${final_score} end ;;
    value_format_name: percent_1
  }

  measure: average_fill_in_the_blank_score  {
    group_label: "Question Modes"
    type:  average
    sql: case when ${dim_question_mode.is_fill_in_the_blank} then ${final_score} end ;;
    value_format_name: percent_1
  }

  measure: average_algebraic_score  {
    group_label: "Question Modes"
    type:  average
    sql: case when ${dim_question_mode.is_algebraic} then ${final_score} end ;;
    value_format_name: percent_1
  }


}
