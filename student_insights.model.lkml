include: "*.view.lkml"         # include all views in this project

include: "webassign.dims.model.lkml"

explore: gradebook {
  join: gbcolumns {
    view_label: "Gradebook - Columns"
    sql_on: ${gradebook.gbcolid} = ${gbcolumns.gbcolid} ;;
    relationship: many_to_one
  }
  join: categories {
    view_label: "Gradebook - Categories"
    fields: [name, category]
    sql_on: ${gbcolumns.category_id} = ${categories.id} ;;
    relationship: many_to_one
  }
}

explore: sections_students {
  #extension: required
  from: dim_section
  view_name: dim_section

# get list of students on course
  join: roster {
    fields: [roster.dropped]
    from: roster_extended
    sql_on: ${dim_section.section_id} = ${roster.section} ;;
    relationship: one_to_many
  }

  # get user details
  join: users {
#     fields: [users.user_id, users.sso_guid, login_recency, users.usercount]
    from: users_extended
    sql_on: ${roster.user} = ${users.id} ;;
    relationship: many_to_one
  }

  join: gradebook_final {
    sql_on: ${dim_section.section_id} = ${gradebook_final.section_id}
        and ${users.user_id} = ${gradebook_final.user_id};;
    relationship: one_to_one
  }

}

explore: sections_students_assignments {
  extends: [sections_students, dim_textbook, dim_question]
  extension: required
  from: dim_section
  view_name: dim_section

#   join: section_weeks {
#     sql_on: ${dim_section.section_id} = ${section_weeks.section_id} ;;
#   }

  # get list of assignments on course
  join: dim_deployment {
    fields: [dim_deployment.due_et_raw, dim_deployment.count, dim_deployment.relative_week]
    view_label: "Assignment"
    sql_on: ${dim_section.section_id} = ${dim_deployment.section_id}
        --and ${dim_deployment.has_response}
    ;;
    #--      and ${section_weeks.relative_week} = ${dim_deployment.relative_week}
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

  join: dim_textbook {
    sql_on: ${dim_section.dim_textbook_id} = ${dim_textbook.dim_textbook_id} ;;
    relationship: many_to_one
  }

}

explore: sections {
  from: dim_section
  view_name: dim_section
  extends: [sections_students_assignments]

#   join: dim_section {
#     sql_on:  ${datascience_course_filter.section_id} = ${dim_section.section_id} ;;
#     relationship: one_to_one
#     type: inner
#   }

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

}
