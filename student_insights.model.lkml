include: "*.view.lkml"         # include all views in this project

include: "webassign.dims.model.lkml"

explore: datascience_raw {
}

explore: sections_students_assignments {
  extends: [dim_question]
  extension: required
  from: dim_section
  view_name: dim_section
  sql_always_where: ${dim_textbook.code} in ('SCalcET8', 'SCalc8')--, 'SCalcET7', 'SCalc7')
                  --and ${dim_section.start_date_raw} >= dateadd(month, -6, current_timestamp())
                  ;;

  # get list of students on course
  join: roster {
    fields: [roster.dropped]
    from: roster_extended
    sql_on: ${dim_section.section_id} = ${roster.section} ;;
    relationship: one_to_many
  }

  # get user details
  join: users {
    fields: [users.user_id, users.sso_guid, login_recency, users.usercount]
    from: users_extended
    sql_on: ${roster.user} = ${users.id} ;;
    relationship: many_to_one
  }

  # get list of assignments on course
  join: dim_deployment {
    fields: [dim_deployment.due_et_raw, dim_deployment.count, dim_deployment.relative_week]
    view_label: "Assignment"
    sql_on: ${dim_section.section_id} = ${dim_deployment.section_id};;
    relationship: one_to_many
  }

  join: dim_assignment {
    view_label: "Assignment"
    sql_on: ${dim_deployment.dim_assignment_id} = ${dim_assignment.dim_assignment_id};;
    relationship: many_to_one
  }

  # get list of questions on this assignment
  join: assignment_questions {
    sql_on: ${dim_assignment.assignment_id} = ${assignment_questions.assignment_id};;
    relationship: one_to_many
  }
  # additional question info
  join: dim_question {
    view_label: "Question"
    sql_on: ${assignment_questions.question_id} = ${dim_question.question_id} ;;
    relationship: many_to_one
  }

# get gradebook data
  join: gbcolumns {
    view_label: "Gradebook"
    fields: []
    sql_on: ${dim_section.section_id} = ${gbcolumns.section} ;;
    relationship: many_to_one
  }
  join: gradebook {
    view_label: "Gradebook"
    sql_on: ${users.user_id} = ${gradebook.user}
      and  ${gbcolumns.gbcolid} = ${gradebook.gbcolid};;
    relationship: many_to_one
  }
  join: categories {
    fields: []
    view_label: "Gradebook"
    sql_on: ${gbcolumns.col} = ${categories.id} ;;
    relationship: many_to_one
  }

}

explore: student_metrics {
  from: datascience_course_filter
  view_name: datascience_course_filter
  extends: [sections_students_assignments]

  join: dim_section {
    sql_on:  ${datascience_course_filter.section_id} = ${dim_section.section_id} ;;
    relationship: one_to_one
    type: inner
  }

  join: class_weekly_stats {
    sql_on: ${dim_section.section_id} = ${class_weekly_stats.section_id} ;;
    relationship: one_to_many
  }

  #join: class_assignment_stats {}

  join: student_weekly_stats {
    sql_on: ${dim_section.section_id} = ${student_weekly_stats.section_id}
          and ${users.user_id} = ${student_weekly_stats.user_id}
          and ${class_weekly_stats.relative_week} = ${student_weekly_stats.relative_week} ;;
    relationship: one_to_one
  }
}

explore: sections {
  extends: [sections_students_assignments]

  # get student results - assignment level
  join: assignment_final {
    view_label: "Result Summary - Assignment"
    sql_on: ${roster.user} = ${assignment_final.userid}
      and ${dim_deployment.deployment_id} = ${assignment_final.deployment_id} ;;
    relationship: one_to_many
  }

  # get student results - question level - final attempt
  join: responses_final {
    view_label: "Result Summary - Question"
    sql_on: ${roster.user} = ${responses_final.userid}
      and ${dim_deployment.deployment_id} = ${responses_final.deployment_id}
      and ${dim_question.question_id} = ${responses_final.questionid}
      and ${assignment_questions.box_num} = ${responses_final.boxnum};;
    relationship: one_to_many
  }

  # get student results - question level - all attempts
  join: responses {
    view_label: "Result Summary - All Attempts"
    sql_on: ${responses_final.userid} = ${responses.userid}
      and ${responses_final.deployment_id} = ${responses.deployment_id}
      and ${responses_final.questionid} = ${responses.questionid}
      and ${responses_final.boxnum} = ${responses.boxnum};;
    relationship: one_to_many
  }



#   # get gradebook data
#   join: gbcolumns {
#     view_label: "Gradebook"
#     fields: []
#     sql_on: ${dim_section.section_id} = ${gbcolumns.section} ;;
#     relationship: many_to_one
#   }
#   join: gradebook {
#     view_label: "Gradebook"
#     sql_on: ${responses.userid} = ${gradebook.user}
#       and  ${gbcolumns.gbcolid} = ${gradebook.gbcolid};;
#     relationship: many_to_one
#   }
#   join: categories {
#     fields: []
#     view_label: "Gradebook"
#     sql_on: ${gbcolumns.col} = ${categories.id} ;;
#     relationship: many_to_one
#   }

}
