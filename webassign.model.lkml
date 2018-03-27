#connection: "snowflake_webassign"

# include all the views
include: "*.view"

# include dims model
include: "webassign.dims.model.lkml"

# include all the dashboards
include: "*.dashboard"

case_sensitive: no

explore: responses {
  label: "Sudent Take Analysis"
  from: responses

  join: dim_question {
    sql_on: ${responses.questionid} = ${dim_question.question_id} ;;
    relationship: many_to_one
  }
  join: dim_question_mode {
    sql_on: ${dim_question.dim_question_id} = ${dim_question_mode.dim_question_mode_id};;
    relationship: one_to_many
  }

  join: dim_textbook {
    sql_on: ${dim_question.dim_textbook_id} = ${dim_textbook.dim_textbook_id} ;;
    relationship: many_to_one
  }

  join: dim_deployment {
    sql_on: ${responses.deployment_id} = ${dim_deployment.deployment_id};;
    relationship: many_to_one
  }

  join: dim_section {
    sql_on: ${dim_deployment.section_id} = ${dim_section.section_id};;
    relationship: many_to_one
  }

  join: roster {
    sql_on: ${roster.section} = ${dim_deployment.section_id}
    and ${roster.user} = ${responses.userid};;
    relationship: many_to_one
  }

  join: users {
    sql_on: ${responses.userid} = ${users.id} ;;
    relationship: many_to_one
  }

#  join: dim_school {
#     sql_on: ${dim_school.school_id} = ${user_sso_guid.school_id} ;;
#     relationship: many_to_one
#  }

}
explore: fact_registration {
  label: "Activations"

  join: dim_axscode {
    sql_on: ${fact_registration.dim_axscode_id} = ${dim_axscode.axscode_id} ;;
    relationship: many_to_one
  }

  join: dim_faculty {
    sql_on: ${fact_registration.course_instructor_id} = ${dim_faculty.userid} ;;
    relationship: many_to_one
  }

  join: dim_payment_method {
    sql_on: ${fact_registration.dim_payment_method_id} = ${dim_payment_method.dim_payment_method_id} ;;
    relationship: many_to_one
  }

  join: dim_section {
    sql_on: ${fact_registration.dim_section_id} = ${dim_section.dim_section_id} ;;
    relationship: many_to_one
  }

  join: dim_school {
    sql_on: ${fact_registration.dim_school_id} = ${dim_school.dim_school_id} ;;
    relationship: many_to_one
  }

  join: dim_textbook {
    sql_on: ${fact_registration.dim_textbook_id} = ${dim_textbook.dim_textbook_id} ;;
    relationship: many_to_one
  }

  join: dim_time {
    sql_on: ${fact_registration.dim_time_id} = ${dim_time.dim_time_id} ;;
    relationship: many_to_one
    type: inner
  }
}
explore: responsesseedsample {
  from:  responsesseedsample

  join: responses {
    sql_on: ${responsesseedsample.sectionslessonsid} = ${responses.deployment_id}
          and ${responsesseedsample.userid} = ${responses.userid}
          and ${responsesseedsample.questionid} = ${responses.questionid}
          and ${responsesseedsample.boxnum} = ${responses.boxnum}
          and ${responsesseedsample.attemptnumber} = ${responses.attemptnumber};;
    relationship: one_to_one
  }
  join: sectionslessons {
    sql_on: ${responses.deployment_id} = ${sectionslessons.id} ;;
    relationship: many_to_one
  }
  join: dim_question {
    sql_on: ${dim_question.dim_question_id} = ${responses.questionid};;
    relationship: one_to_many
    type: inner
  }
  join: dim_question_mode {
    sql_on: ${dim_question.dim_question_id} = ${dim_question_mode.dim_question_mode_id};;
    relationship: one_to_many
  }

}

explore: questionstext {
  from:  questionstext

  join: dim_question {
    sql_on: ${dim_question.dim_question_id} = ${questionstext.questionid};;
    relationship: one_to_one
    type: left_outer
  }
  join: dim_textbook {
    sql_on: ${dim_question.dim_textbook_id} = ${dim_textbook.dim_textbook_id} ;;
    relationship: many_to_one
  }
}

explore: footprints {
  label: "Testing footprints"
}
