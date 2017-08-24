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
}


explore: dim_question_test {
  from:  dim_question
  label: "Robert Test Question Analysis"
}
