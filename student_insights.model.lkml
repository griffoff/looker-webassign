include: "*.view.lkml"         # include all views in this project

include: "webassign.dims.model.lkml"

explore: sections {
  extends: [dim_question]
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
    fields: [users.sso_guid, login_recency]
    from: users_extended
    sql_on: ${roster.user} = ${users.id} ;;
    relationship: many_to_one
  }

  # get list of assignments on course
  join: dim_deployment {
    fields: [dim_deployment.due_et_raw]
    view_label: "Assignment"
    sql_on: ${dim_section.section_id} = ${dim_deployment.section_id};;
    relationship: one_to_many
  }

  join: dim_assignment {
    view_label: "Assignment"
    sql_on: ${dim_deployment.dim_assignment_id} = ${dim_assignment.dim_assignment_id};;
    relationship: many_to_one
  }

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
      and ${dim_deployment.deployment_id} = ${responses_final.deployment_id} ;;
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

  # additional question info
  join: dim_question {
    view_label: "Question"
    sql_on: ${responses_final.questionid} = ${dim_question.question_id} ;;
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
    sql_on: ${responses.userid} = ${gradebook.user}
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
