include: "student_insights.model.lkml"
include: "responses.view.lkml"

# explore: class_stats {}
# explore: assignment_stats {}
# explore: class_assignment_stats {}
# explore: student_assignment_stats {}
# explore: class_question_stats {}
# explore: student_question_stats {}
# explore: class_weekly_stats {}
# explore: student_weekly_stats {}
# explore: question_stats {}


view: class_stats {
  derived_table: {
    explore_source: sections {
      column: section_id {field: dim_section.section_id}
      derived_column: pk {sql: HASH(section_id);; }
      column: new_assignment_count {field: responses_final.new_assignment_count}
      column: assignment_duration {field:assignment_final.total_assignment_duration}
      column: assignment_submissions {field:responses.response_submission_count}
      column: assignment_time_on_task {field:responses.total_attempt_time}
      column: questions_correct {field:responses.response_question_correct_count}
      column: questions_answered {field:responses.response_question_answered_count}
      column: question_count {field:responses.response_question_count}
      derived_column: questions_available {sql: question_count * student_count;;}
      column: total_attempts {field:responses.count}
      column: start_recency {field:assignment_final.total_assignment_start_recency}
      column: submission_recency {field:assignment_final.total_assignment_submission_recency}
      column: total_assignments {field:dim_deployment.count}
      column: assignments_worked_on {field:responses.assignment_count}
      column: student_count {field:users.usercount}
      column: active_student_count {field:responses.user_count}
    }
    datagroup_trigger: responses_datagroup
  }


  dimension: pk {primary_key:yes hidden:yes}
  dimension: section_id {type: number hidden: no}
  measure: sum_assignment_duration {
    description: "elapsed time from start to finish (first and last response recorded)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_duration ;;
    value_format_name: duration_dhm
  }
  measure: sum_assignment_submissions {
    description: "total number of times this assignment as added to a section"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_submissions ;;
    value_format_name: decimal_0
  }
  measure: sum_assignment_time_on_task {
    description: "total time spent (sum of durations at the lowest (take) level)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_time_on_task ;;
    value_format_name: duration_hms
  }
  measure: average_question_time_on_task {
    description: "average time spent on the whole question"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_question_attempt_time_on_task {
    description: "average time spent on each take"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_total_attempts}, 0) ;;
    value_format_name: duration_hms
  }
  measure: sum_questions_correct {
    description: "number of questions answered correctly"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_correct ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_answered {
    description: "number of questions answered"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_answered ;;
    value_format_name: decimal_0
  }
  measure: sum_question_count {
    description: "number of questions available in the assignment"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.question_count ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_available {
    description: "number of times the questions were available (questions in assignment * students)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_available ;;
    value_format_name: decimal_0
  }
  measure: sum_total_attempts {
    description: "number of attempts made"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_attempts ;;
    value_format_name: decimal_0
  }
  measure: sum_start_recency {
    description: "how many days before due date was it started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.start_recency ;;
    value_format_name: decimal_0
  }
  measure: sum_submission_recency {
    description: "how many days before due date was it finished"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.submission_recency ;;
    value_format_name: decimal_0
  }
  measure: sum_total_assignments {
    description: "total number of assignments available to be started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_assignments ;;
    value_format_name: decimal_0
  }
  measure: sum_assignments_worked_on {
    description: "total number of assignments with one or more response"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignments_worked_on ;;
    value_format_name: decimal_0
  }
  measure: sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.student_count ;;
    value_format_name: decimal_0
  }
  measure: sum_active_student_count {
    description: "number of students with activity in the given context (i.e. students on the roster who logged in, students who took an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.active_student_count ;;
    value_format_name: decimal_0
  }
  measure: percent_correct_attempted {
    description: "% of questions answered correctly of those attempted"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_answered {
    description: "% of questions answered"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_answered} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_correct {
    description: "% of questions correct"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_students_active {
    description: "% of students who did this"
    group_label: "Calculations"
    type: number
    sql: ${sum_active_student_count} / NULLIF(${sum_student_count}, 0) ;;
    value_format_name: percent_1
  }
  measure: average_assignment_time_on_task {
    description: "average time spent on an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_assignment_duration {
    description: "average length of time to complete an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_duration} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_dhm
  }
  measure: average_start_recency {
    description: "how many days before due date was it started"
    group_label: "Calculations"
    type: number
    sql: ${sum_start_recency} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: decimal_1
  }
  measure: average_submission_recency {
    description: "how many days before due date was it finished"
    group_label: "Calculations"
    type: number
    sql: ${sum_submission_recency} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: decimal_1
  }
}
view: assignment_stats {
  derived_table: {
    explore_source: sections {
      column: assignment_id {field: dim_assignment.assignment_id}
      derived_column: pk {sql: HASH(assignment_id);; }
      column: new_assignment_count {field: responses_final.new_assignment_count}
      column: assignment_duration {field:assignment_final.total_assignment_duration}
      column: assignment_submissions {field:responses.response_submission_count}
      column: assignment_time_on_task {field:responses.total_attempt_time}
      column: questions_correct {field:responses.response_question_correct_count}
      column: questions_answered {field:responses.response_question_answered_count}
      column: question_count {field:responses.response_question_count}
      derived_column: questions_available {sql: question_count * student_count;;}
      column: total_attempts {field:responses.count}
      column: start_recency {field:assignment_final.total_assignment_start_recency}
      column: submission_recency {field:assignment_final.total_assignment_submission_recency}
      column: total_assignments {field:dim_deployment.count}
      column: assignments_worked_on {field:responses.assignment_count}
      column: student_count {field:users.usercount}
      column: active_student_count {field:responses.user_count}
    }
    datagroup_trigger: responses_datagroup
  }


  dimension: pk {primary_key:yes hidden:yes}
  dimension: assignment_id {type: number hidden: no}
  measure: sum_assignment_duration {
    description: "elapsed time from start to finish (first and last response recorded)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_duration ;;
    value_format_name: duration_dhm
  }
  measure: sum_assignment_submissions {
    description: "total number of times this assignment as added to a section"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_submissions ;;
    value_format_name: decimal_0
  }
  measure: sum_assignment_time_on_task {
    description: "total time spent (sum of durations at the lowest (take) level)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_time_on_task ;;
    value_format_name: duration_hms
  }
  measure: average_question_time_on_task {
    description: "average time spent on the whole question"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_question_attempt_time_on_task {
    description: "average time spent on each take"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_total_attempts}, 0) ;;
    value_format_name: duration_hms
  }
  measure: sum_questions_correct {
    description: "number of questions answered correctly"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_correct ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_answered {
    description: "number of questions answered"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_answered ;;
    value_format_name: decimal_0
  }
  measure: sum_question_count {
    description: "number of questions available in the assignment"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.question_count ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_available {
    description: "number of times the questions were available (questions in assignment * students)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_available ;;
    value_format_name: decimal_0
  }
  measure: sum_total_attempts {
    description: "number of attempts made"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_attempts ;;
    value_format_name: decimal_0
  }
  measure: average_attempts_per_question {
    description: "number of attempts per question"
    group_label: "Calculations"
    type: number
    sql: ${sum_total_attempts} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: decimal_1
  }
  measure: sum_start_recency {
    description: "how many days before due date was it started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.start_recency ;;
    value_format_name: decimal_0
  }
  measure: sum_submission_recency {
    description: "how many days before due date was it finished"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.submission_recency ;;
    value_format_name: decimal_0
  }
  measure: sum_total_assignments {
    description: "total number of assignments available to be started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_assignments ;;
    value_format_name: decimal_0
  }
  measure: sum_assignments_worked_on {
    description: "total number of assignments with one or more response"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignments_worked_on ;;
    value_format_name: decimal_0
  }
  measure: sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.student_count ;;
    value_format_name: decimal_0
  }
  measure: sum_active_student_count {
    description: "number of students with activity in the given context (i.e. students on the roster who logged in, students who took an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.active_student_count ;;
    value_format_name: decimal_0
  }
  measure: percent_correct_attempted {
    description: "% of questions answered correctly of those attempted"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_answered {
    description: "% of questions answered"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_answered} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_correct {
    description: "% of questions correct"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_students_active {
    description: "% of students who did this"
    group_label: "Calculations"
    type: number
    sql: ${sum_active_student_count} / NULLIF(${sum_student_count}, 0) ;;
    value_format_name: percent_1
  }
  measure: average_assignment_time_on_task {
    description: "average time spent on an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_assignment_duration {
    description: "average length of time to complete an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_duration} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_dhm
  }
  measure: average_start_recency {
    description: "how many days before due date was it started"
    group_label: "Calculations"
    type: number
    sql: ${sum_start_recency} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: decimal_1
  }
  measure: average_submission_recency {
    description: "how many days before due date was it finished"
    group_label: "Calculations"
    type: number
    sql: ${sum_submission_recency} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: decimal_1
  }
}
view: class_assignment_stats {
  derived_table: {
    explore_source: sections {
      column: section_id {field: dim_section.section_id}
      column: assignment_id {field: dim_assignment.assignment_id}
      derived_column: pk {sql: HASH(section_id,'|',assignment_id);; }
      column: new_assignment_count {field: responses_final.new_assignment_count}
      column: assignment_duration {field:assignment_final.total_assignment_duration}
      column: assignment_submissions {field:responses.response_submission_count}
      column: assignment_time_on_task {field:responses.total_attempt_time}
      column: questions_correct {field:responses.response_question_correct_count}
      column: questions_answered {field:responses.response_question_answered_count}
      column: question_count {field:responses.response_question_count}
      derived_column: questions_available {sql: question_count * student_count;;}
      column: total_attempts {field:responses.count}
      column: start_recency {field:assignment_final.total_assignment_start_recency}
      column: submission_recency {field:assignment_final.total_assignment_submission_recency}
      column: total_assignments {field:dim_deployment.count}
      column: assignments_worked_on {field:responses.assignment_count}
      column: student_count {field:users.usercount}
      column: active_student_count {field:responses.user_count}
    }
    datagroup_trigger: responses_datagroup
  }


  dimension: pk {primary_key:yes hidden:yes}
  dimension: section_id {type: number hidden: no}
  dimension: assignment_id {type: number hidden: no}
  measure: sum_assignment_duration {
    description: "elapsed time from start to finish (first and last response recorded)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_duration ;;
    value_format_name: duration_dhm
  }
  measure: sum_assignment_submissions {
    description: "total number of times this assignment as added to a section"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_submissions ;;
    value_format_name: decimal_0
  }
  measure: sum_assignment_time_on_task {
    description: "total time spent (sum of durations at the lowest (take) level)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_time_on_task ;;
    value_format_name: duration_hms
  }
  measure: average_question_time_on_task {
    description: "average time spent on the whole question"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_question_attempt_time_on_task {
    description: "average time spent on each take"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_total_attempts}, 0) ;;
    value_format_name: duration_hms
  }
  measure: sum_questions_correct {
    description: "number of questions answered correctly"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_correct ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_answered {
    description: "number of questions answered"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_answered ;;
    value_format_name: decimal_0
  }
  measure: sum_question_count {
    description: "number of questions available in the assignment"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.question_count ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_available {
    description: "number of times the questions were available (questions in assignment * students)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_available ;;
    value_format_name: decimal_0
  }
  measure: sum_total_attempts {
    description: "number of attempts made"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_attempts ;;
    value_format_name: decimal_0
  }
  measure: average_attempts_per_question {
    description: "number of attempts per question"
    group_label: "Calculations"
    type: number
    sql: ${sum_total_attempts} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: decimal_1
  }
  measure: sum_start_recency {
    description: "how many days before due date was it started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.start_recency ;;
    value_format_name: decimal_0
  }
  measure: sum_submission_recency {
    description: "how many days before due date was it finished"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.submission_recency ;;
    value_format_name: decimal_0
  }
  measure: sum_total_assignments {
    description: "total number of assignments available to be started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_assignments ;;
    value_format_name: decimal_0
  }
  measure: sum_assignments_worked_on {
    description: "total number of assignments with one or more response"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignments_worked_on ;;
    value_format_name: decimal_0
  }
  measure: sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.student_count ;;
    value_format_name: decimal_0
  }
  measure: sum_active_student_count {
    description: "number of students with activity in the given context (i.e. students on the roster who logged in, students who took an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.active_student_count ;;
    value_format_name: decimal_0
  }
  measure: percent_correct_attempted {
    description: "% of questions answered correctly of those attempted"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_answered {
    description: "% of questions answered"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_answered} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_correct {
    description: "% of questions correct"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_students_active {
    description: "% of students who did this"
    group_label: "Calculations"
    type: number
    sql: ${sum_active_student_count} / NULLIF(${sum_student_count}, 0) ;;
    value_format_name: percent_1
  }
  measure: average_assignment_time_on_task {
    description: "average time spent on an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_assignment_duration {
    description: "average length of time to complete an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_duration} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_dhm
  }
  measure: average_start_recency {
    description: "how many days before due date was it started"
    group_label: "Calculations"
    type: number
    sql: ${sum_start_recency} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: decimal_1
  }
  measure: average_submission_recency {
    description: "how many days before due date was it finished"
    group_label: "Calculations"
    type: number
    sql: ${sum_submission_recency} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: decimal_1
  }
}
view: student_assignment_stats {
  derived_table: {
    explore_source: sections {
      column: section_id {field: dim_section.section_id}
      column: assignment_id {field: dim_assignment.assignment_id}
      column: user_id {field: users.user_id}
      derived_column: pk {sql: HASH(section_id,'|',assignment_id,'|',user_id);; }
      column: new_assignment_count {field: responses_final.new_assignment_count}
      column: assignment_duration {field:assignment_final.total_assignment_duration}
      column: assignment_submissions {field:responses.response_submission_count}
      column: assignment_time_on_task {field:responses.total_attempt_time}
      column: questions_correct {field:responses.response_question_correct_count}
      column: questions_answered {field:responses.response_question_answered_count}
      column: question_count {field:responses.response_question_count}
      derived_column: questions_available {sql: question_count * student_count;;}
      column: total_attempts {field:responses.count}
      column: start_recency {field:assignment_final.total_assignment_start_recency}
      column: submission_recency {field:assignment_final.total_assignment_submission_recency}
      column: total_assignments {field:dim_deployment.count}
      column: assignments_worked_on {field:responses.assignment_count}
      column: student_count {field:users.usercount}
      column: active_student_count {field:responses.user_count}
    }
    datagroup_trigger: responses_datagroup
  }


  dimension: pk {primary_key:yes hidden:yes}
  dimension: section_id {type: number hidden: no}
  dimension: assignment_id {type: number hidden: no}
  dimension: user_id {type: number hidden: no}
  measure: sum_assignment_duration {
    description: "elapsed time from start to finish (first and last response recorded)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_duration ;;
    value_format_name: duration_dhm
  }
  measure: sum_assignment_submissions {
    description: "total number of times this assignment as added to a section"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_submissions ;;
    value_format_name: decimal_0
  }
  measure: sum_assignment_time_on_task {
    description: "total time spent (sum of durations at the lowest (take) level)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_time_on_task ;;
    value_format_name: duration_hms
  }
  measure: average_question_time_on_task {
    description: "average time spent on the whole question"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_question_attempt_time_on_task {
    description: "average time spent on each take"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_total_attempts}, 0) ;;
    value_format_name: duration_hms
  }
  measure: sum_questions_correct {
    description: "number of questions answered correctly"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_correct ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_answered {
    description: "number of questions answered"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_answered ;;
    value_format_name: decimal_0
  }
  measure: sum_question_count {
    description: "number of questions available in the assignment"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.question_count ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_available {
    description: "number of times the questions were available (questions in assignment * students)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_available ;;
    value_format_name: decimal_0
  }
  measure: sum_total_attempts {
    description: "number of attempts made"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_attempts ;;
    value_format_name: decimal_0
  }
  measure: average_attempts_per_question {
    description: "number of attempts per question"
    group_label: "Calculations"
    type: number
    sql: ${sum_total_attempts} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: decimal_1
  }
  measure: sum_start_recency {
    description: "how many days before due date was it started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.start_recency ;;
    value_format_name: decimal_0
  }
  measure: sum_submission_recency {
    description: "how many days before due date was it finished"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.submission_recency ;;
    value_format_name: decimal_0
  }
  measure: sum_total_assignments {
    description: "total number of assignments available to be started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_assignments ;;
    value_format_name: decimal_0
  }
  measure: sum_assignments_worked_on {
    description: "total number of assignments with one or more response"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignments_worked_on ;;
    value_format_name: decimal_0
  }
  measure: sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.student_count ;;
    value_format_name: decimal_0
  }
  measure: sum_active_student_count {
    description: "number of students with activity in the given context (i.e. students on the roster who logged in, students who took an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.active_student_count ;;
    value_format_name: decimal_0
  }
  measure: percent_correct_attempted {
    description: "% of questions answered correctly of those attempted"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_answered {
    description: "% of questions answered"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_answered} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_correct {
    description: "% of questions correct"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: average_assignment_time_on_task {
    description: "average time spent on an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_assignment_duration {
    description: "average length of time to complete an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_duration} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_dhm
  }
  measure: average_start_recency {
    description: "how many days before due date was it started"
    group_label: "Calculations"
    type: number
    sql: ${sum_start_recency} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: decimal_1
  }
  measure: average_submission_recency {
    description: "how many days before due date was it finished"
    group_label: "Calculations"
    type: number
    sql: ${sum_submission_recency} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: decimal_1
  }
}
view: question_stats {
  derived_table: {
    explore_source: sections {
      column: question_id {field: dim_question.question_id}
      derived_column: pk {sql: HASH(question_id);; }
      column: new_assignment_count {field: responses_final.new_assignment_count}
      column: assignment_time_on_task {field:responses.total_attempt_time}
      column: questions_correct {field:responses.response_question_correct_count}
      column: questions_answered {field:responses.response_question_answered_count}
      column: question_count {field:responses.response_question_count}
      derived_column: questions_available {sql: question_count * student_count;;}
      column: total_attempts {field:responses.count}
      column: total_assignments {field:dim_deployment.count}
      column: assignments_worked_on {field:responses.assignment_count}
      column: student_count {field:users.usercount}
      column: active_student_count {field:responses.user_count}
    }
    datagroup_trigger: responses_datagroup
  }


  dimension: pk {primary_key:yes hidden:yes}
  dimension: question_id {type: number hidden: no}
  measure: sum_assignment_time_on_task {
    description: "total time spent (sum of durations at the lowest (take) level)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_time_on_task ;;
    value_format_name: duration_hms
  }
  measure: average_question_time_on_task {
    description: "average time spent on the whole question"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_question_attempt_time_on_task {
    description: "average time spent on each take"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_total_attempts}, 0) ;;
    value_format_name: duration_hms
  }
  measure: sum_questions_correct {
    description: "number of questions answered correctly"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_correct ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_answered {
    description: "number of questions answered"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_answered ;;
    value_format_name: decimal_0
  }
  measure: sum_question_count {
    description: "number of questions available in the assignment"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.question_count ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_available {
    description: "number of times the questions were available (questions in assignment * students)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_available ;;
    value_format_name: decimal_0
  }
  measure: sum_total_attempts {
    description: "number of attempts made"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_attempts ;;
    value_format_name: decimal_0
  }
  measure: average_attempts_per_question {
    description: "number of attempts per question"
    group_label: "Calculations"
    type: number
    sql: ${sum_total_attempts} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: decimal_1
  }
  measure: sum_total_assignments {
    description: "total number of assignments available to be started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_assignments ;;
    value_format_name: decimal_0
  }
  measure: sum_assignments_worked_on {
    description: "total number of assignments with one or more response"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignments_worked_on ;;
    value_format_name: decimal_0
  }
  measure: sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.student_count ;;
    value_format_name: decimal_0
  }
  measure: sum_active_student_count {
    description: "number of students with activity in the given context (i.e. students on the roster who logged in, students who took an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.active_student_count ;;
    value_format_name: decimal_0
  }
  measure: percent_correct_attempted {
    description: "% of questions answered correctly of those attempted"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_answered {
    description: "% of questions answered"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_answered} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_students_active {
    description: "% of students who did this"
    group_label: "Calculations"
    type: number
    sql: ${sum_active_student_count} / NULLIF(${sum_student_count}, 0) ;;
    value_format_name: percent_1
  }
}
view: class_question_stats {
  derived_table: {
    explore_source: sections {
      column: section_id {field: dim_section.section_id}
      column: question_id {field: dim_question.question_id}
      derived_column: pk {sql: HASH(section_id,'|',question_id);; }
      column: new_assignment_count {field: responses_final.new_assignment_count}
      column: assignment_time_on_task {field:responses.total_attempt_time}
      column: questions_correct {field:responses.response_question_correct_count}
      column: questions_answered {field:responses.response_question_answered_count}
      column: question_count {field:responses.response_question_count}
      derived_column: questions_available {sql: question_count * student_count;;}
      column: total_attempts {field:responses.count}
      column: total_assignments {field:dim_deployment.count}
      column: assignments_worked_on {field:responses.assignment_count}
      column: student_count {field:users.usercount}
      column: active_student_count {field:responses.user_count}
    }
    datagroup_trigger: responses_datagroup
  }


  dimension: pk {primary_key:yes hidden:yes}
  dimension: section_id {type: number hidden: no}
  dimension: question_id {type: number hidden: no}
  measure: sum_assignment_time_on_task {
    description: "total time spent (sum of durations at the lowest (take) level)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_time_on_task ;;
    value_format_name: duration_hms
  }
  measure: average_question_time_on_task {
    description: "average time spent on the whole question"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_question_attempt_time_on_task {
    description: "average time spent on each take"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_total_attempts}, 0) ;;
    value_format_name: duration_hms
  }
  measure: sum_questions_correct {
    description: "number of questions answered correctly"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_correct ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_answered {
    description: "number of questions answered"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_answered ;;
    value_format_name: decimal_0
  }
  measure: sum_question_count {
    description: "number of questions available in the assignment"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.question_count ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_available {
    description: "number of times the questions were available (questions in assignment * students)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_available ;;
    value_format_name: decimal_0
  }
  measure: sum_total_attempts {
    description: "number of attempts made"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_attempts ;;
    value_format_name: decimal_0
  }
  measure: average_attempts_per_question {
    description: "number of attempts per question"
    group_label: "Calculations"
    type: number
    sql: ${sum_total_attempts} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: decimal_1
  }
  measure: sum_total_assignments {
    description: "total number of assignments available to be started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_assignments ;;
    value_format_name: decimal_0
  }
  measure: sum_assignments_worked_on {
    description: "total number of assignments with one or more response"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignments_worked_on ;;
    value_format_name: decimal_0
  }
  measure: sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.student_count ;;
    value_format_name: decimal_0
  }
  measure: sum_active_student_count {
    description: "number of students with activity in the given context (i.e. students on the roster who logged in, students who took an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.active_student_count ;;
    value_format_name: decimal_0
  }
  measure: percent_correct_attempted {
    description: "% of questions answered correctly of those attempted"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_answered {
    description: "% of questions answered"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_answered} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_correct {
    description: "% of questions correct"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_students_active {
    description: "% of students who did this"
    group_label: "Calculations"
    type: number
    sql: ${sum_active_student_count} / NULLIF(${sum_student_count}, 0) ;;
    value_format_name: percent_1
  }
}
view: student_question_stats {
  derived_table: {
    explore_source: sections {
      column: section_id {field: dim_section.section_id}
      column: question_id {field: dim_question.question_id}
      column: user_id {field: users.user_id}
      derived_column: pk {sql: HASH(section_id,'|',question_id,'|',user_id);; }
      column: new_assignment_count {field: responses_final.new_assignment_count}
      column: assignment_time_on_task {field:responses.total_attempt_time}
      column: questions_correct {field:responses.response_question_correct_count}
      column: questions_answered {field:responses.response_question_answered_count}
      column: question_count {field:responses.response_question_count}
      derived_column: questions_available {sql: question_count * student_count;;}
      column: total_attempts {field:responses.count}
      column: total_assignments {field:dim_deployment.count}
      column: student_count {field:users.usercount}
      column: active_student_count {field:responses.user_count}
    }
    datagroup_trigger: responses_datagroup
  }


  dimension: pk {primary_key:yes hidden:yes}
  dimension: section_id {type: number hidden: no}
  dimension: question_id {type: number hidden: no}
  dimension: user_id {type: number hidden: no}
  measure: sum_assignment_time_on_task {
    description: "total time spent (sum of durations at the lowest (take) level)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_time_on_task ;;
    value_format_name: duration_hms
  }
  measure: average_question_time_on_task {
    description: "average time spent on the whole question"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_question_attempt_time_on_task {
    description: "average time spent on each take"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_total_attempts}, 0) ;;
    value_format_name: duration_hms
  }
  measure: sum_questions_correct {
    description: "number of questions answered correctly"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_correct ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_answered {
    description: "number of questions answered"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_answered ;;
    value_format_name: decimal_0
  }
  measure: sum_question_count {
    description: "number of questions available in the assignment"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.question_count ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_available {
    description: "number of times the questions were available (questions in assignment * students)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_available ;;
    value_format_name: decimal_0
  }
  measure: sum_total_attempts {
    description: "number of attempts made"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_attempts ;;
    value_format_name: decimal_0
  }
  measure: average_attempts_per_question {
    description: "number of attempts per question"
    group_label: "Calculations"
    type: number
    sql: ${sum_total_attempts} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: decimal_1
  }
  measure: sum_total_assignments {
    description: "total number of assignments available to be started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_assignments ;;
    value_format_name: decimal_0
  }
  measure: sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.student_count ;;
    value_format_name: decimal_0
  }
  measure: sum_active_student_count {
    description: "number of students with activity in the given context (i.e. students on the roster who logged in, students who took an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.active_student_count ;;
    value_format_name: decimal_0
  }
  measure: percent_correct_attempted {
    description: "% of questions answered correctly of those attempted"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_answered {
    description: "% of questions answered"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_answered} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
}
view: class_weekly_stats {
  derived_table: {
    explore_source: sections {
      column: section_id {field: dim_section.section_id}
      column: relative_week {field: dim_deployment.relative_week}
      derived_column: pk {sql: HASH(section_id,'|',relative_week);; }
      column: new_assignment_count {field: responses_final.new_assignment_count}
      column: assignment_duration {field:assignment_final.total_assignment_duration}
      column: assignment_submissions {field:responses.response_submission_count}
      column: assignment_time_on_task {field:responses.total_attempt_time}
      column: questions_correct {field:responses.response_question_correct_count}
      column: questions_answered {field:responses.response_question_answered_count}
      column: question_count {field:responses.response_question_count}
      derived_column: questions_available {sql: question_count * student_count;;}
      column: total_attempts {field:responses.count}
      column: total_assignments {field:dim_deployment.count}
      column: assignments_worked_on {field:responses.assignment_count}
      derived_column: total_assignments_to_date {sql: SUM(total_assignments) OVER (PARTITION BY section_id ORDER BY relative_week ROWS UNBOUNDED PRECEDING );;}
      derived_column: assignments_worked_on_to_date {sql: SUM(new_assignment_count) OVER (PARTITION BY section_id ORDER BY relative_week ROWS UNBOUNDED PRECEDING );;}
      column: student_count {field:users.usercount}
      column: active_student_count {field:responses.user_count}
    }
    datagroup_trigger: responses_datagroup
  }


  dimension: pk {primary_key:yes hidden:yes}
  dimension: section_id {type: number hidden: no}
  dimension: relative_week {type: number hidden: no}
  measure: sum_assignment_duration {
    description: "elapsed time from start to finish (first and last response recorded)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_duration ;;
    value_format_name: duration_dhm
  }
  measure: sum_assignment_submissions {
    description: "total number of times this assignment as added to a section"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_submissions ;;
    value_format_name: decimal_0
  }
  measure: sum_assignment_time_on_task {
    description: "total time spent (sum of durations at the lowest (take) level)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_time_on_task ;;
    value_format_name: duration_hms
  }
  measure: average_question_time_on_task {
    description: "average time spent on the whole question"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_question_attempt_time_on_task {
    description: "average time spent on each take"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_total_attempts}, 0) ;;
    value_format_name: duration_hms
  }
  measure: sum_questions_correct {
    description: "number of questions answered correctly"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_correct ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_answered {
    description: "number of questions answered"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_answered ;;
    value_format_name: decimal_0
  }
  measure: sum_question_count {
    description: "number of questions available in the assignment"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.question_count ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_available {
    description: "number of times the questions were available (questions in assignment * students)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_available ;;
    value_format_name: decimal_0
  }
  measure: sum_total_attempts {
    description: "number of attempts made"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_attempts ;;
    value_format_name: decimal_0
  }
  measure: average_attempts_per_question {
    description: "number of attempts per question"
    group_label: "Calculations"
    type: number
    sql: ${sum_total_attempts} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: decimal_1
  }
  measure: sum_total_assignments {
    description: "total number of assignments available to be started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_assignments ;;
    value_format_name: decimal_0
  }
  measure: sum_assignments_worked_on {
    description: "total number of assignments with one or more response"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignments_worked_on ;;
    value_format_name: decimal_0
  }
  measure: max_total_assignments_to_date {
    description: ""
    group_label: "Raw Metrics"
    type: max
    sql: ${TABLE}.total_assignments_to_date ;;
    value_format_name: decimal_1
  }
  measure: max_assignments_worked_on_to_date {
    description: ""
    group_label: "Raw Metrics"
    type: max
    sql: ${TABLE}.assignments_worked_on_to_date ;;
    value_format_name: decimal_1
  }
  measure: sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.student_count ;;
    value_format_name: decimal_0
  }
  measure: sum_active_student_count {
    description: "number of students with activity in the given context (i.e. students on the roster who logged in, students who took an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.active_student_count ;;
    value_format_name: decimal_0
  }
  measure: percent_correct_attempted {
    description: "% of questions answered correctly of those attempted"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_answered {
    description: "% of questions answered"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_answered} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_correct {
    description: "% of questions correct"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_students_active {
    description: "% of students who did this"
    group_label: "Calculations"
    type: number
    sql: ${sum_active_student_count} / NULLIF(${sum_student_count}, 0) ;;
    value_format_name: percent_1
  }
  measure: average_assignment_time_on_task {
    description: "average time spent on an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_assignment_duration {
    description: "average length of time to complete an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_duration} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_dhm
  }
}
view: student_weekly_stats {
  derived_table: {
    explore_source: sections {
      column: section_id {field: dim_section.section_id}
      column: user_id {field: users.user_id}
      column: relative_week {field: responses_final.relative_week}
      derived_column: pk {sql: HASH(section_id,'|',user_id,'|',relative_week);; }
      column: new_assignment_count {field: responses_final.new_assignment_count}
      column: assignment_duration {field:assignment_final.total_assignment_duration}
      column: assignment_submissions {field:responses.response_submission_count}
      column: assignment_time_on_task {field:responses.total_attempt_time}
      column: questions_correct {field:responses.response_question_correct_count}
      column: questions_answered {field:responses.response_question_answered_count}
      column: question_count {field:responses.response_question_count}
      derived_column: questions_available {sql: question_count * student_count;;}
      column: total_attempts {field:responses.count}
      column: total_assignments {field:dim_deployment.count}
      column: assignments_worked_on {field:responses.assignment_count}
      derived_column: total_assignments_to_date {sql: SUM(total_assignments) OVER (PARTITION BY section_id, user_id ORDER BY relative_week ROWS UNBOUNDED PRECEDING );;}
      derived_column: assignments_worked_on_to_date {sql: SUM(new_assignment_count) OVER (PARTITION BY section_id, user_id ORDER BY relative_week ROWS UNBOUNDED PRECEDING );;}
      column: student_count {field:users.usercount}
      column: active_student_count {field:responses.user_count}
    }
    datagroup_trigger: responses_datagroup
  }


  dimension: pk {primary_key:yes hidden:yes}
  dimension: section_id {type: number hidden: no}
  dimension: user_id {type: number hidden: no}
  dimension: relative_week {type: number hidden: no}
  measure: sum_assignment_duration {
    description: "elapsed time from start to finish (first and last response recorded)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_duration ;;
    value_format_name: duration_dhm
  }
  measure: sum_assignment_submissions {
    description: "total number of times this assignment as added to a section"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_submissions ;;
    value_format_name: decimal_0
  }
  measure: sum_assignment_time_on_task {
    description: "total time spent (sum of durations at the lowest (take) level)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignment_time_on_task ;;
    value_format_name: duration_hms
  }
  measure: average_question_time_on_task {
    description: "average time spent on the whole question"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_question_attempt_time_on_task {
    description: "average time spent on each take"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_total_attempts}, 0) ;;
    value_format_name: duration_hms
  }
  measure: sum_questions_correct {
    description: "number of questions answered correctly"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_correct ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_answered {
    description: "number of questions answered"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_answered ;;
    value_format_name: decimal_0
  }
  measure: sum_question_count {
    description: "number of questions available in the assignment"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.question_count ;;
    value_format_name: decimal_0
  }
  measure: sum_questions_available {
    description: "number of times the questions were available (questions in assignment * students)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.questions_available ;;
    value_format_name: decimal_0
  }
  measure: sum_total_attempts {
    description: "number of attempts made"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_attempts ;;
    value_format_name: decimal_0
  }
  measure: average_attempts_per_question {
    description: "number of attempts per question"
    group_label: "Calculations"
    type: number
    sql: ${sum_total_attempts} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: decimal_1
  }
  measure: sum_total_assignments {
    description: "total number of assignments available to be started"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.total_assignments ;;
    value_format_name: decimal_0
  }
  measure: sum_assignments_worked_on {
    description: "total number of assignments with one or more response"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.assignments_worked_on ;;
    value_format_name: decimal_0
  }
  measure: max_total_assignments_to_date {
    description: ""
    group_label: "Raw Metrics"
    type: max
    sql: ${TABLE}.total_assignments_to_date ;;
    value_format_name: decimal_1
  }
  measure: max_assignments_worked_on_to_date {
    description: ""
    group_label: "Raw Metrics"
    type: max
    sql: ${TABLE}.assignments_worked_on_to_date ;;
    value_format_name: decimal_1
  }
  measure: sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.student_count ;;
    value_format_name: decimal_0
  }
  measure: sum_active_student_count {
    description: "number of students with activity in the given context (i.e. students on the roster who logged in, students who took an assignment, etc.)"
    group_label: "Raw Metrics"
    type: sum
    sql: ${TABLE}.active_student_count ;;
    value_format_name: decimal_0
  }
  measure: percent_correct_attempted {
    description: "% of questions answered correctly of those attempted"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_answered}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_answered {
    description: "% of questions answered"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_answered} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: percent_correct {
    description: "% of questions correct"
    group_label: "Calculations"
    type: number
    sql: ${sum_questions_correct} / NULLIF(${sum_questions_available}, 0) ;;
    value_format_name: percent_1
  }
  measure: average_assignment_time_on_task {
    description: "average time spent on an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_time_on_task} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_hms
  }
  measure: average_assignment_duration {
    description: "average length of time to complete an assignment"
    group_label: "Calculations"
    type: number
    sql: ${sum_assignment_duration} / NULLIF(${sum_assignment_submissions}, 0) ;;
    value_format_name: duration_dhm
  }
}
