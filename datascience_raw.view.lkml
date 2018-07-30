view: datascience_raw {
  derived_table: {
    explore_source: student_metrics {
      column: section_id { field:dim_section.section_id}
      column: sso_guid { field: users.sso_guid }
      column: relative_week { field: class_weekly_stats.relative_week }
      column: class_weekly_stats_sum_student_count { field: class_weekly_stats.sum_student_count }
      column: class_weekly_stats_average_assignment_duration { field: class_weekly_stats.average_assignment_duration }
      column: student_weekly_stats_average_assignment_duration { field: student_weekly_stats.average_assignment_duration }
      column: class_weekly_stats_percent_correct { field: class_weekly_stats.percent_correct }
      column: student_weekly_stats_percent_correct { field: student_weekly_stats.percent_correct }
      column: class_weekly_stats_average_attempts_per_question { field: class_weekly_stats.average_attempts_per_question }
      column: student_weekly_stats_average_attempts_per_question { field: student_weekly_stats.average_attempts_per_question }
      column: class_weekly_stats_average_question_time_on_task { field: class_weekly_stats.average_question_time_on_task }
      column: student_weekly_stats_average_question_time_on_task { field: student_weekly_stats.average_question_time_on_task }
      column: student_weekly_stats_max_assignments_worked_on_to_date { field: student_weekly_stats.max_assignments_worked_on_to_date }
      column: student_weekly_stats_max_total_assignments_to_date { field: student_weekly_stats.max_total_assignments_to_date }
      column: class_weekly_stats_max_assignments_worked_on_to_date { field: class_weekly_stats.max_assignments_worked_on_to_date }
      column: class_weekly_stats_max_total_assignments_to_date { field: class_weekly_stats.max_total_assignments_to_date }
#       filters: {
#         field: class_weekly_stats.section_id
#         value: "690010"
#       }
    }
    datagroup_trigger: responses_datagroup
  }
  dimension: section_id {}
  dimension: sso_guid {}
  dimension: relative_week {
    type: number
  }
  dimension: class_weekly_stats_sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    value_format: "#,##0"
    type: number
  }
  dimension: student_weekly_stats_average_assignment_duration {
    description: "average length of time to complete an assignment"
    value_format: "d \d\a\y\s hh:mm"
    type: number
  }
  dimension: class_weekly_stats_average_assignment_duration {
    description: "average length of time to complete an assignment"
    value_format: "d \d\a\y\s hh:mm"
    type: number
  }
  dimension: student_weekly_stats_percent_correct {
    description: "% of questions correct"
    value_format: "#,##0.0%"
    type: number
  }
  dimension: class_weekly_stats_percent_correct {
    description: "% of questions correct"
    value_format: "#,##0.0%"
    type: number
  }
  dimension: student_weekly_stats_average_attempts_per_question {
    description: "number of attempts per question"
    value_format: "#,##0.0"
    type: number
  }
  dimension: class_weekly_stats_average_attempts_per_question {
    description: "number of attempts per question"
    value_format: "#,##0.0"
    type: number
  }
  dimension: student_weekly_stats_average_question_time_on_task {
    description: "average time spent on the whole question"
    value_format: "hh:mm:ss"
    type: number
  }
  dimension: class_weekly_stats_average_question_time_on_task {
    description: "average time spent on the whole question"
    value_format: "hh:mm:ss"
    type: number
  }
  dimension: student_weekly_stats_max_assignments_worked_on_to_date {
    description: ""
    value_format: "#,##0.0"
    type: number
  }
  dimension: student_weekly_stats_max_total_assignments_to_date {
    description: ""
    value_format: "#,##0.0"
    type: number
  }
  dimension: class_weekly_stats_max_assignments_worked_on_to_date {
    description: ""
    value_format: "#,##0.0"
    type: number
  }
  dimension: class_weekly_stats_max_total_assignments_to_date {
    description: ""
    value_format: "#,##0.0"
    type: number
  }
}
