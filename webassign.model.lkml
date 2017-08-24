connection: "snowflake_webassign"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: attemptsbyquestion {

}

explore: attemptsbyquestionbox {}

explore: classstatistics {}

explore: conceptreportingsettings {}

explore: lessonscores {}

explore: responses {
  label: "Response Analysis"
  join: dim_question {
    sql_on: ${responses.questionid} = ${dim_question.questionid} ;;
    relationship: many_to_one
  }
}

explore: scores {}

explore: sectionaveragetaq {}

explore: studentattemptpercentages {}

explore: usersectionslessonsstatistics {}
