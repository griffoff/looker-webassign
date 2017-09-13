connection: "snowflake_webassign"

# include all the views
include: "*.view"

# include dims model
include: "webassign.dims.model.lkml"

# include all the dashboards
include: "*.dashboard"

case_sensitive: no

explore: dim_question {
  label: "Question Analysis"
  extends: [dim_textbook]

  join: responses {
    sql_on: ${dim_question.questionid} = ${responses.questionid};;
    relationship: one_to_many
  }

  join: dim_textbook {
    sql_on: ${dim_question.dim_textbook_id} = ${dim_textbook.dim_textbook_id} ;;
    relationship: many_to_one
  }

  join: user_sso_guid {
    sql_on: ${responses.userid} = ${user_sso_guid.userid} ;;
    relationship: many_to_one
  }

  join: sectionslessons {
    sql_on: ${responses.sectionslessonsid} = ${sectionslessons.id} ;;
    relationship: many_to_one
  }

#   join: dim_faculty {
#     sql_on: ${sectionslessons.sectionid} = dim_falc ;;
#   }

  join: sectionaveragetaq {
    sql_on: ${responses.sectionslessonsid} = ${sectionaveragetaq.sectionslessonid} ;;
    relationship: many_to_one
  }
  join: lessonscores{
    sql_on:  ${lessonscores.lessonid} = ${sectionslessons.lessonid}
       and ${lessonscores.userid} = ${responses.userid};;
    relationship: many_to_one
  }

  join: classstatistics {
    sql_on:  ${sectionslessons.sectionid} = ${classstatistics.sectionid} ;;
    relationship:  one_to_one
  }

  join: attemptsbyquestion {
    sql_on: ${attemptsbyquestion.questionid} = ${dim_question.dim_question_id} ;;
    relationship: many_to_many
  }

  join: attemptsbyquestionbox {
    sql_on: ${attemptsbyquestionbox.questionid} = ${dim_question.dim_question_id} ;;
    relationship: many_to_many
  }


}
explore: fact_registration {
  from:  fact_registration

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
  }
}

explore: dim_question_test {
  from:  dim_question
  label: "Robert Test Question Analysis"
}
