include: "webassign.model.lkml"

view: assignment_final {
  derived_table: {
    explore_source: responses {
      column: userid {}
      column: deployment_id {}
      column: total_score {field:responses.score}
      column: assignment_start {field:responses.min_attempt_start}
      column: assignment_finish {field:responses.max_attempt_finish}
      derived_column: assignment_duration { sql: datediff(second, assignment_start, assignment_finish) / 3600 / 24;;}
      column: total_questions {field: responses.response_question_count}
      column: total_correct {field:responses.numbercorrect}
      column: due_date {field: dim_deployment.due_et_raw}
      column: available_date {field: dim_deployment.begins_et_raw}
      column: course_start_date {field: dim_section.start_date_raw}
      filters: {
        field: responses.final_attempt
        value: "yes"
      }
      sort: {field:userid}
      sort: {field:deployment_id}
    }
    datagroup_trigger: responses_datagroup
  }

  dimension: weeks_relative_to_course_start {
    type: number
    sql: datediff(week, ${TABLE}.course_start_date, ${assignment_start})  ;;
    value_format: "0 \w\e\e\k\s"
  }

  dimension: pk {
    primary_key: yes
    sql: hash(${deployment_id}, '||', ${userid}) ;;
    hidden: yes
  }

  dimension: userid {hidden: yes}
  dimension: deployment_id {hidden: yes}

  dimension: due_date {type: date_raw}
  dimension: available_date {type: date_raw}
  dimension: assignment_start {type: date_raw}
  dimension: assignment_finish {type: date_raw}
  dimension: assignment_duration {type: number}

  measure: average_assignment_duration {
    type: average
    sql: ${assignment_duration}  ;;
    value_format_name: duration_hms
  }

  measure: total_assignment_duration {
    hidden: yes
    type: sum
    sql: ${assignment_duration}  ;;
    value_format_name: duration_hms
  }

  dimension: assignment_start_recency {
    description: "How long before due date was the assignment started?
    - Higher is better."
    sql: datediff(hour, ${assignment_start}, ${due_date}) / 24 ;;
    value_format_name: decimal_1
  }

  dimension: assignment_submission_recency {
    description: "How many days before due date was the assignment submitted?
    - Higher is better."
    sql: datediff(hour, ${assignment_finish}, ${due_date}) / 24;;
    value_format_name: decimal_1
  }

  measure: average_assignment_start_recency {
    type: average
    sql: ${assignment_start_recency} ;;
    value_format_name: decimal_1
  }

  measure: average_assignment_submission_recency {
    type: average
    sql: ${assignment_submission_recency} ;;
    value_format_name: decimal_1
  }

  measure: total_assignment_start_recency {
    type: sum
    sql: ${assignment_start_recency} ;;
    value_format_name: decimal_1
  }

  measure: total_assignment_submission_recency {
    type: sum
    sql: ${assignment_submission_recency} ;;
    value_format_name: decimal_1
  }


  measure: late_submissions {
    type: number
    sql: count(case when ${assignment_submission_recency} < 0 then 1 end) ;;
  }

  measure: missed_assignments {
    type: number
    sql: count(case when ${assignment_submission_recency} is null then 1 end) ;;
  }

  measure: started_after_due {
    type: number
    sql: count(case when ${assignment_start} > ${due_date} then 1 end) ;;
  }

  measure: count {
    label: "# Assignments"
    type: count
  }

  measure: percent_overdue {
    label: "% Late Submissions"
    type: number
    sql:  ${late_submissions} / ${count} ;;
    value_format_name: percent_1
  }

  measure: average_total_score {
    type:average
    sql: ${TABLE}.total_score ;;
    value_format_name:percent_1}
  #get category at run-time as the category in the PDT is from a view that starts from responses
  #i.e. there will be no category for assignments that have no responses
  dimension: category {sql:${dim_assignment.category};;}

  dimension: total_questions {type:number hidden: yes}
  dimension: total_correct {type:number hidden: yes}

  measure: sum_total_questions {
    label: "Total Questions Answered"
    type: sum
    sql: ${total_questions} ;;
  }

  measure: sum_total_correct {
    label: "Total Questions Answered Correctly"
    type: sum
    sql: ${total_correct} ;;
  }

  dimension: is_homework {
    hidden: yes
    type: yesno
    sql:  ${category} ilike '%homework%' or ${category} ilike '%required%';;
  }
  dimension: is_quiz {
    hidden: yes
    type: yesno
    sql:  ${category} ilike '%quiz%' or ${category} ilike '%practice%';;
  }
  dimension: is_exam {
    hidden: yes
    type: yesno
    sql:  ${category} ilike '%exam%' or ${category} ilike '%final%' or ${category} ilike '%test%' or ${category} ilike '%midterm%' ;;
  }
  dimension: is_labwork {
    hidden: yes
    type: yesno
    sql:  ${category} ilike '%lab%' or ${category} ilike '%project%';;
  }
  dimension: is_presence {
    hidden: yes
    type: yesno
    sql:  ${category} ilike '%attendance%' or ${category} ilike '%in_class%' or ${category} ilike '%participation%';;
  }
  dimension: is_bonus {
    hidden: yes
    type: yesno
    sql:  ${category} ilike '%bonus%';;
  }
  dimension: is_other {
    hidden: yes
    type: yesno
    sql:  ${category} is null or not (${is_bonus} or ${is_homework} or ${is_exam} or ${is_labwork} or ${is_presence} or ${is_quiz});;
  }

  measure: percent_correct_overall {
    group_label: "% Correct"
    label: "% Correct - Overall"
    type: number
    sql:sum(${total_correct})
      / sum(${total_questions});;
    value_format_name: percent_1
  }

  measure: percent_correct_homework {
    group_label: "% Correct"
    label: "% Correct - Homework"
    type: number
    sql:sum(case when ${is_homework} then ${total_correct} end)
      / sum(case when ${is_homework} then ${total_questions} end);;
    value_format_name: percent_1
  }

  measure: percent_correct_quiz {
    group_label: "% Correct"
    label: "% Correct - Quiz"
    type: number
    sql:sum(case when ${is_quiz} then ${total_correct} end)
      / sum(case when ${is_quiz} then ${total_questions} end);;
    value_format_name: percent_1
  }

  measure: percent_correct_exam {
    group_label: "% Correct"
    label: "% Correct - Exam"
    type: number
    sql:sum(case when ${is_exam} then ${total_correct} end)
      / sum(case when ${is_exam} then ${total_questions} end);;
    value_format_name: percent_1
  }

  measure: percent_correct_labwork {
    group_label: "% Correct"
    label: "% Correct - Lab work"
    type: number
    sql:sum(case when ${is_labwork} then ${total_correct} end)
      / sum(case when ${is_labwork} then ${total_questions} end);;
    value_format_name: percent_1
  }

  measure: percent_correct_presence {
    group_label: "% Correct"
    label: "% Correct - Presence"
    type: number
    sql:sum(case when ${is_presence} then ${total_correct} end)
      / sum(case when ${is_presence} then ${total_questions} end);;
    value_format_name: percent_1
  }

  measure: percent_correct_bonus{
    group_label: "% Correct"
    label: "% Correct - Bonus"
    type: number
    sql:sum(case when ${is_bonus} then ${total_correct} end)
      / sum(case when ${is_bonus} then ${total_questions} end);;
    value_format_name: percent_1
  }

  measure: percent_correct_other{
    group_label: "% Correct"
    label: "% Correct - Other"
    type: number
    sql:sum(case when ${is_other} then ${total_correct} end)
      / sum(case when ${is_other} then ${total_questions} end);;
    value_format_name: percent_1
  }

}
