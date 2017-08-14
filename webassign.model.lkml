connection: "snowflake_webassign"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: attemptsbyquestion {}

explore: attemptsbyquestionbox {}

explore: classstatistics {}

explore: conceptreportingsettings {}

explore: lessonscores {}

explore: responses {}

explore: scores {}

explore: sectionaveragetaq {}

explore: studentattemptpercentages {}

explore: usersectionslessonsstatistics {}
