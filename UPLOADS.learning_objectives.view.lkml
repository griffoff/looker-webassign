view: learning_objectives {
  sql_table_name: LO_METADATA.LEARNING_OBJECTIVES ;;

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."_FIVETRAN_SYNCED" ;;
  }

  dimension: _row {
    type: number
    sql: ${TABLE}."_ROW" ;;
  }

  dimension: bloom_s_level {
    type: string
    sql: ${TABLE}."BLOOM_S_LEVEL" ;;
  }

  dimension: cgi {
    type: string
    sql: ${TABLE}."CGI" ;;
  }

  dimension: comments {
    type: string
    sql: ${TABLE}."COMMENTS" ;;
  }

  dimension: development_date {
    type: string
    sql: ${TABLE}."DEVELOPMENT_DATE" ;;
  }

  dimension: development_team {
    type: string
    sql: ${TABLE}."DEVELOPMENT_TEAM" ;;
  }

  dimension: objective {
    type: string
    sql: ${TABLE}."OBJECTIVE" ;;
  }

  dimension: ordinal {
    type: string
    sql: ${TABLE}."ORDINAL" ;;
  }

  dimension: parent_cgi {
    type: string
    sql: ${TABLE}."PARENT_CGI" ;;
  }

  dimension: parent_description {
    type: string
    sql: ${TABLE}."PARENT_DESCRIPTION" ;;
  }

  dimension: parent_objective {
    type: string
    sql: ${TABLE}."PARENT_OBJECTIVE" ;;
  }

  dimension: prereq_1 {
    type: string
    sql: ${TABLE}."PREREQ_1" ;;
  }

  dimension: prereq_2 {
    type: string
    sql: ${TABLE}."PREREQ_2" ;;
  }

  dimension: prereq_3 {
    type: string
    sql: ${TABLE}."PREREQ_3" ;;
  }

  dimension: prereq_4 {
    type: string
    sql: ${TABLE}."PREREQ_4" ;;
  }

  dimension: vendor {
    type: string
    sql: ${TABLE}."VENDOR" ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}."VERSION" ;;
  }

  dimension: version_date {
    type: string
    sql: ${TABLE}."VERSION_DATE" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
