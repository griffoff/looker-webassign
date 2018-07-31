view: course_objectives {
  sql_table_name: LO_METADATA.COURSE_OBJECTIVES ;;

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

  dimension: cgi {
    type: string
    sql: ${TABLE}."CGI" ;;
  }

  dimension: objective {
    type: string
    sql: ${TABLE}."OBJECTIVE" ;;
  }

  dimension: ordinal {
    type: string
    sql: ${TABLE}."ORDINAL" ;;
  }

  dimension: textbook_author {
    type: string
    sql: ${TABLE}."TEXTBOOK_AUTHOR" ;;
  }

  dimension: textbook_edition {
    type: number
    sql: ${TABLE}."TEXTBOOK_EDITION" ;;
  }

  dimension: textbook_id {
    type: number
    sql: ${TABLE}."TEXTBOOK_ID" ;;
  }

  dimension: textbook_name {
    type: string
    sql: ${TABLE}."TEXTBOOK_NAME" ;;
  }

  measure: count {
    type: count
    drill_fields: [textbook_name]
  }
}
