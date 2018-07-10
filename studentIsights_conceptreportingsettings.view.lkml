view: conceptreportingsettings {
  sql_table_name: WA2ANALYTICS.CONCEPTREPORTINGSETTINGS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension_group: createdat {
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
    sql: ${TABLE}.CREATEDAT ;;
  }

  dimension: flaggedquestionthreshold {
    type: number
    sql: ${TABLE}.FLAGGEDQUESTIONTHRESHOLD ;;
  }

  dimension: lessontype {
    type: string
    sql: ${TABLE}.LESSONTYPE ;;
  }

  dimension: riskstatusattemptnumber {
    type: number
    sql: ${TABLE}.RISKSTATUSATTEMPTNUMBER ;;
  }

  dimension: riskstatusred {
    type: number
    sql: ${TABLE}.RISKSTATUSRED ;;
  }

  dimension: riskstatusyellow {
    type: number
    sql: ${TABLE}.RISKSTATUSYELLOW ;;
  }

  dimension_group: updatedat {
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
    sql: ${TABLE}.UPDATEDAT ;;
  }

  dimension: userid {
    type: number
    value_format_name: id
    sql: ${TABLE}.USERID ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
