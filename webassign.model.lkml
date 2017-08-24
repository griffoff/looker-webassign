connection: "snowflake_webassign"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: dim_question {
  label: "Question Analysis"

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




}

explore: scores {}

explore: sectionaveragetaq {}

explore: studentattemptpercentages {}

explore: usersectionslessonsstatistics {}
