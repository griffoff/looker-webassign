view: units_objectives {
  sql_table_name: LO_METADATA.UNITS_OBJECTIVES ;;

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

  dimension: parent_cgi {
    type: string
    sql: ${TABLE}."PARENT_CGI" ;;
  }

  dimension: parent_description {
    type: string
    sql: ${TABLE}."PARENT_DESCRIPTION" ;;
  }

  dimension: parent_ordinal {
    type: string
    sql: ${TABLE}."PARENT_ORDINAL" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
