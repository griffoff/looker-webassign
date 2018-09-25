view: datascience_student_aggregates {
  sql_table_name: datascience.student_aggregates ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: section_id {
    type: number
    sql: ${TABLE}."SECTION_ID" ;;
  }

  dimension: relative_week {
    type: number
    sql: ${TABLE}."RELATIVE_WEEK" ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: relative_assignments_worked_on_to_date {
    type: number
    sql: ${TABLE}."RELATIVE_ASSIGNMENTS_WORKED_ON_TO_DATE" ;;
  }

  dimension: relative_questions_correct_to_date {
    type: number
    sql: ${TABLE}."RELATIVE_QUESTIONS_CORRECT_TO_DATE" ;;
  }

  dimension: relative_questions_correct_attempt_1_to_date {
    type: number
    sql: ${TABLE}."RELATIVE_QUESTIONS_CORRECT_ATTEMPT_1_TO_DATE" ;;
  }

  dimension: relative_assignment_time_on_task_secs_to_date {
    type: number
    sql: ${TABLE}."RELATIVE_ASSIGNMENT_TIME_ON_TASK_SECS_TO_DATE" ;;
  }

  dimension: rel_avg_q_tot {
    type: number
    sql: ${TABLE}."REL_AVG_Q_TOT" ;;
  }

  dimension: rel_avg_q_tot_todate {
    type: number
    sql: ${TABLE}."REL_AVG_Q_TOT_TODATE" ;;
  }

  dimension: relative_assignment_duration {
    type: number
    sql: ${TABLE}."RELATIVE_ASSIGNMENT_DURATION" ;;
  }

  dimension: rel_avg_att_q {
    type: number
    sql: ${TABLE}."REL_AVG_ATT_Q" ;;
  }

  dimension: rel_avg_att_q_to_date {
    type: number
    sql: ${TABLE}."REL_AVG_ATT_Q_TO_DATE" ;;
  }

  dimension: ta_td {
    type: number
    sql: ${TABLE}."TA_TD" ;;
  }

  dimension: missed {
    type: number
    sql: ${TABLE}."MISSED" ;;
  }

  dimension: missed_td {
    type: number
    sql: ${TABLE}."MISSED_TD" ;;
  }

  dimension: late_sub {
    type: number
    sql: ${TABLE}."LATE_SUB" ;;
  }

  dimension: late_sub_td {
    type: number
    sql: ${TABLE}."LATE_SUB_TD" ;;
  }

  dimension: final_score {
    type: number
    sql: ${TABLE}."FINAL_SCORE" ;;
  }

  dimension: percent_correct {
    type: number
    sql: ${TABLE}."PERCENT_CORRECT" ;;
  }

  dimension: rel_percent_correct {
    type: number
    sql: ${TABLE}."REL_PERCENT_CORRECT" ;;
  }

  dimension: rel_percent_correct_to_date {
    type: number
    sql: ${TABLE}."REL_PERCENT_CORRECT_TO_DATE" ;;
  }

  dimension: class_avg_assignments_worked_on_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_ASSIGNMENTS_WORKED_ON_TO_DATE" ;;
  }

  dimension: class_avg_questions_correct_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_QUESTIONS_CORRECT_TO_DATE" ;;
  }

  dimension: class_avg_questions_correct_attempt_1_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_QUESTIONS_CORRECT_ATTEMPT_1_TO_DATE" ;;
  }

  dimension: class_avg_assignment_time_on_task_secs {
    type: number
    sql: ${TABLE}."CLASS_AVG_ASSIGNMENT_TIME_ON_TASK_SECS" ;;
  }

  dimension: class_avg_assignment_time_on_task_secs_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_ASSIGNMENT_TIME_ON_TASK_SECS_TO_DATE" ;;
  }

  dimension: class_avg_assignment_duration_secs {
    type: number
    sql: ${TABLE}."CLASS_AVG_ASSIGNMENT_DURATION_SECS" ;;
  }

  dimension: class_avg_attempted_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_ATTEMPTED_TO_DATE" ;;
  }

  dimension: class_avg_attempts_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_ATTEMPTS_TO_DATE" ;;
  }

  dimension: class_avg_assignments_missed {
    type: number
    sql: ${TABLE}."CLASS_AVG_ASSIGNMENTS_MISSED" ;;
  }

  dimension: class_avg_assignments_missed_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_ASSIGNMENTS_MISSED_TO_DATE" ;;
  }

  dimension: class_avg_late_submissions {
    type: number
    sql: ${TABLE}."CLASS_AVG_LATE_SUBMISSIONS" ;;
  }

  dimension: class_avg_late_submissions_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_LATE_SUBMISSIONS_TO_DATE" ;;
  }

  dimension: class_avg_attempts_per_question_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_ATTEMPTS_PER_QUESTION_TO_DATE" ;;
  }

  dimension: class_avg_attempts_per_question {
    type: number
    sql: ${TABLE}."CLASS_AVG_ATTEMPTS_PER_QUESTION" ;;
  }

  dimension: class_avg_percent_correct {
    type: number
    sql: ${TABLE}."CLASS_AVG_PERCENT_CORRECT" ;;
  }

  dimension: class_avg_percent_correct_to_date {
    type: number
    sql: ${TABLE}."CLASS_AVG_PERCENT_CORRECT_TO_DATE" ;;
  }

  dimension: set_type {
    type: string
    sql: ${TABLE}."SET_TYPE" ;;
  }

  dimension: dropped {
    type: string
    sql: ${TABLE}."DROPPED" ;;
  }

  dimension: assignments_due {
    type: number
    sql: ${TABLE}."ASSIGNMENTS_DUE" ;;
  }

  dimension: assignments_worked_on {
    type: number
    sql: ${TABLE}."ASSIGNMENTS_WORKED_ON" ;;
  }

  dimension: assignments_missed {
    type: number
    sql: ${TABLE}."ASSIGNMENTS_MISSED" ;;
  }

  dimension: late_submissions {
    type: number
    sql: ${TABLE}."LATE_SUBMISSIONS" ;;
  }

  dimension: assignments_due_to_date {
    type: number
    sql: ${TABLE}."ASSIGNMENTS_DUE_TO_DATE" ;;
  }

  dimension: assignments_worked_on_to_date {
    type: number
    sql: ${TABLE}."ASSIGNMENTS_WORKED_ON_TO_DATE" ;;
  }

  dimension: assignments_missed_to_date {
    type: number
    sql: ${TABLE}."ASSIGNMENTS_MISSED_TO_DATE" ;;
  }

  dimension: percent_worked_on_to_date {
    type: number
    sql: ${TABLE}."PERCENT_WORKED_ON_TO_DATE" ;;
  }

  dimension: late_submissions_to_date {
    type: number
    sql: ${TABLE}."LATE_SUBMISSIONS_TO_DATE" ;;
  }

  dimension: submission_days_late_to_date_per_assignment {
    type: number
    sql: ${TABLE}."SUBMISSION_DAYS_LATE_TO_DATE_PER_ASSIGNMENT" ;;
  }

  dimension: questions_total_attempted {
    type: number
    sql: ${TABLE}."QUESTIONS_TOTAL_ATTEMPTED" ;;
  }

  dimension: questions_total_attempted_to_date {
    type: number
    sql: ${TABLE}."QUESTIONS_TOTAL_ATTEMPTED_TO_DATE" ;;
  }

  dimension: questions_total_attempts {
    type: number
    sql: ${TABLE}."QUESTIONS_TOTAL_ATTEMPTS" ;;
  }

  dimension: questions_total_attempts_to_date {
    type: number
    sql: ${TABLE}."QUESTIONS_TOTAL_ATTEMPTS_TO_DATE" ;;
  }

  dimension: questions_correct {
    type: number
    sql: ${TABLE}."QUESTIONS_CORRECT" ;;
  }

  dimension: questions_correct_to_date {
    type: number
    sql: ${TABLE}."QUESTIONS_CORRECT_TO_DATE" ;;
  }

  dimension: questions_correct_attempt_1 {
    type: number
    sql: ${TABLE}."QUESTIONS_CORRECT_ATTEMPT_1" ;;
  }

  dimension: questions_correct_attempt_1_to_date {
    type: number
    sql: ${TABLE}."QUESTIONS_CORRECT_ATTEMPT_1_TO_DATE" ;;
  }

  dimension: assignment_time_on_task_secs {
    type: number
    sql: ${TABLE}."ASSIGNMENT_TIME_ON_TASK_SECS" ;;
  }

  dimension: assignment_time_on_task_secs_to_date {
    type: number
    sql: ${TABLE}."ASSIGNMENT_TIME_ON_TASK_SECS_TO_DATE" ;;
  }

  dimension: assignment_duration_secs {
    type: number
    sql: ${TABLE}."ASSIGNMENT_DURATION_SECS" ;;
  }

  dimension: assignment_duration_secs_to_date {
    type: number
    sql: ${TABLE}."ASSIGNMENT_DURATION_SECS_TO_DATE" ;;
  }

  set: detail {
    fields: [
      section_id,
      relative_week,
      user_id,
      relative_assignments_worked_on_to_date,
      relative_questions_correct_to_date,
      relative_questions_correct_attempt_1_to_date,
      relative_assignment_time_on_task_secs_to_date,
      rel_avg_q_tot,
      rel_avg_q_tot_todate,
      relative_assignment_duration,
      rel_avg_att_q,
      rel_avg_att_q_to_date,
      ta_td,
      missed,
      missed_td,
      late_sub,
      late_sub_td,
      final_score,
      percent_correct,
      rel_percent_correct,
      rel_percent_correct_to_date,
      class_avg_assignments_worked_on_to_date,
      class_avg_questions_correct_to_date,
      class_avg_questions_correct_attempt_1_to_date,
      class_avg_assignment_time_on_task_secs,
      class_avg_assignment_time_on_task_secs_to_date,
      class_avg_assignment_duration_secs,
      class_avg_attempted_to_date,
      class_avg_attempts_to_date,
      class_avg_assignments_missed,
      class_avg_assignments_missed_to_date,
      class_avg_late_submissions,
      class_avg_late_submissions_to_date,
      class_avg_attempts_per_question_to_date,
      class_avg_attempts_per_question,
      class_avg_percent_correct,
      class_avg_percent_correct_to_date,
      set_type,
      dropped,
      assignments_due,
      assignments_worked_on,
      assignments_missed,
      late_submissions,
      assignments_due_to_date,
      assignments_worked_on_to_date,
      assignments_missed_to_date,
      percent_worked_on_to_date,
      late_submissions_to_date,
      submission_days_late_to_date_per_assignment,
      questions_total_attempted,
      questions_total_attempted_to_date,
      questions_total_attempts,
      questions_total_attempts_to_date,
      questions_correct,
      questions_correct_to_date,
      questions_correct_attempt_1,
      questions_correct_attempt_1_to_date,
      assignment_time_on_task_secs,
      assignment_time_on_task_secs_to_date,
      assignment_duration_secs,
      assignment_duration_secs_to_date
    ]
  }
}
