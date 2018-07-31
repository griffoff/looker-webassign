view: datascience_raw {
  derived_table: {
    explore_source: student_metrics {
      column: textbook_code { field: dim_textbook.code }
      column: section_id { field:dim_section.section_id}
      column: sso_guid { field: users.sso_guid }
      column: relative_week { field: class_weekly_stats.relative_week }
      derived_column: pk { sql: hash(section_id || '|' || sso_guid || '|' || relative_week);; }
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
      column: class_weekly_stats_max_assignments_worked_on_to_date { field: class_weekly_stats.max_assignments_worked_on_to_date }
      column: student_weekly_stats_max_total_assignments_to_date { field: student_weekly_stats.max_total_assignments_to_date }
      column: class_weekly_stats_max_total_assignments_to_date { field: class_weekly_stats.max_total_assignments_to_date }
      column: class_weekly_stats_average_submission_recency { field: class_weekly_stats.average_submission_recency }
      column: student_weekly_stats_student_weekly_stats_average_submission_recency { field: student_weekly_stats.average_submission_recency }
      column: class_weekly_stats_sum_late_submissions { field: class_weekly_stats.sum_late_submissions }
      column: student_weekly_stats_sum_late_submissions { field: student_weekly_stats.sum_late_submissions }
      column: class_weekly_stats_sum_missed_assignments { field: class_weekly_stats.sum_missed_assignments }
      column: student_weekly_stats_sum_missed_assignments { field: student_weekly_stats.sum_missed_assignments }
       filters: {
         field: dim_textbook.code
         value: "SCalcET8"
       }
    }
    datagroup_trigger: responses_datagroup
  }
  dimension: pk {primary_key:yes hidden:yes}
  dimension: textbook_code {}
  dimension: section_id {}
  dimension: sso_guid {}
  dimension: relative_week {
    type: number
  }
  dimension: class_weekly_stats_sum_student_count {
    description: "number of students with potential to have activity in the given context (i.e. students on the roster, total students who could have answered a question on an assignment, etc.)"
    value_format_name: decimal_1
    type: number
  }
  dimension: student_weekly_stats_average_assignment_duration {
    description: "average length of time to complete an assignment"
    value_format_name: duration_dhm
    type: number
  }
  dimension: class_weekly_stats_average_assignment_duration {
    description: "average length of time to complete an assignment"
    value_format_name: duration_dhm
    type: number
  }
  dimension: student_weekly_stats_percent_correct {
    description: "% of questions correct for this student"
    value_format_name: percent_1
    type: number
  }
  dimension: class_weekly_stats_percent_correct {
    description: "% of questions correct for this class"
    value_format_name: percent_1
    type: number
  }
  dimension: student_weekly_stats_average_attempts_per_question {
    description: "average number of attempts per question for this student"
    value_format_name: decimal_1
    type: number
  }
  dimension: class_weekly_stats_average_attempts_per_question {
    description: "average number of attempts per question for this class"
    value_format_name: decimal_1
    type: number
  }
  dimension: student_weekly_stats_average_question_time_on_task {
    description: "average time spent on the whole question by the student"
    value_format_name: duration_hms
    type: number
  }
  dimension: class_weekly_stats_average_question_time_on_task {
    description: "average time spent on the whole question by the class"
    value_format_name: duration_hms
    type: number
  }
  dimension: student_weekly_stats_max_assignments_worked_on_to_date {
    description: "total assignments this student has worked on up to and including this week"
    value_format_name: decimal_1
    type: number
  }
  dimension: student_weekly_stats_max_total_assignments_to_date {
    description: "total assignments that were available for this student to work on up to and including this week"
    value_format_name: decimal_1
    type: number
  }
  dimension: class_weekly_stats_max_assignments_worked_on_to_date {
    description: "total assignments this class has worked on up to and including this week"
    value_format_name: decimal_1
    type: number
  }
  dimension: class_weekly_stats_max_total_assignments_to_date {
    description: "total assignments that were available for this class to work on up to and including this week"
    value_format_name: decimal_1
    type: number
  }
  dimension: class_weekly_stats_average_submission_recency {
    description: "avg missed assignments per student"
    value_format_name: decimal_1
    type: number
  }
  dimension: student_weekly_stats_average_submission_recency {
    description: "avg missed assignments per student"
    value_format_name: decimal_1
    type: number
  }
  dimension: class_weekly_stats_sum_late_submissions {
    description: "number of assignments submitted late"
    value_format_name: decimal_0
    type: number
  }
  dimension: student_weekly_stats_sum_late_submissions {
    description: "number of assignments submitted late"
    value_format_name: decimal_0
    type: number
  }
  dimension: class_weekly_stats_sum_missed_assignments {
    description: "number of assignments with no response"
    value_format_name: decimal_0
    type: number
  }
  dimension: student_weekly_stats_sum_missed_assignments {
    description: "number of assignments with no response"
    value_format_name: decimal_0
    type: number
  }
}
