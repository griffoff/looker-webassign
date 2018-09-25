connection: "snowflake_webassign"

include: "/core/common.lkml"
include: "*.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project

datagroup: responses_datagroup {
  sql_trigger: select count(*) from wa_app_activity.RESPONSES ;;
}

datagroup: responses_dependencies_datagroup {
  sql_trigger: select count(*) from wa_app_activity.RESPONSES ;;
  #not supported yet
  #sql_trigger: select count(*) from ${responses.SQL_TABLE_NAME} ;;
  max_cache_age: "24 hours"
}

datagroup: stats_datagroup {
  sql_trigger: select count(*) from wa_app_activity.RESPONSES ;;
  #sql_trigger: select count(*) from ${class_weekly_stats.SQL_TABLE_NAME} ;;
  #max_cache_age: "24 hours"
}

datagroup: gradebook_datagroup {
  sql_trigger: select count(*) from wa_app_activity.RESPONSES ;;
  #sql_trigger: select count(*) from ${gradebook.SQL_TABLE_NAME} ;;
  #max_cache_age: "24 hours"
}

explore: dim_textbook {
  extension: required
  join: dim_discipline {
    sql_on: ${dim_textbook.dim_discipline_id} = ${dim_discipline.dim_discipline_id} ;;
    relationship: many_to_one
  }
}

explore: dim_deployment {
  extension: required

  join: dim_section {
    sql_on: ${dim_deployment.section_id} = ${dim_section.section_id};;
    relationship: many_to_one
  }

  join: dim_assignment {
    #sql_on: ${dim_deployment.dim_assignment_id} = ${dim_assignment.dim_assignment_id};;
    sql_on: ${dim_deployment.assignment_id} = ${dim_assignment.assignment_id};;
    relationship: many_to_one
  }
}

explore: dim_question {
  extends: [dim_textbook]
  extension: required

  join: dim_question_mode {
    sql_on: ${dim_question.dim_question_mode_id} = ${dim_question_mode.dim_question_mode_id};;
    relationship: one_to_many
  }

  join: dim_faculty {
    sql_on: ${dim_faculty.dim_faculty_id} = ${dim_question.dim_faculty_id_author} ;;
    relationship: one_to_many
  }

  join: dim_textbook {
    sql_on: ${dim_question.dim_textbook_id} = ${dim_textbook.dim_textbook_id} ;;
    relationship: many_to_one
  }
}

explore: user_sso_guid {
#   from: user_sso_guid
  extension: required
  join: fact_registration{
    sql_on: ${user_sso_guid.userid} = ${fact_registration.user_id}} ;;
    relationship: one_to_many
  }
}
# explore: dim_faculty {
#   extension: required
#   join: dim_school {
#     sql_on: ${dim_faculty.dim_school_id}=${dim_school.school_id} ;;
#     relationship: many_to_one
#   }
# }
