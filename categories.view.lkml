view: categories {
  sql_table_name: WA_APP_V4NET.CATEGORIES ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."ID"::string ;;
  }

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

  dimension: characteristics {
    type: string
    sql: ${TABLE}."CHARACTERISTICS" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: user {
    type: number
    sql: ${TABLE}."USER" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
