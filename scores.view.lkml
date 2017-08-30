view: scores {
  view_label: "Scores"
  sql_table_name: WA2ANALYTICS.SCORES ;;

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

  dimension: deploymentid {
    type: number
    value_format_name: id
    sql: ${TABLE}.DEPLOYMENTID ;;
  }

  dimension: isdownloaded {
    type: number
    sql: ${TABLE}.ISDOWNLOADED ;;
  }

  dimension: isexcused {
    type: number
    sql: ${TABLE}.ISEXCUSED ;;
  }

  dimension: issubmitted {
    type: number
    sql: ${TABLE}.ISSUBMITTED ;;
  }

  dimension: logid {
    type: number
    value_format_name: id
    sql: ${TABLE}.LOGID ;;
  }

  dimension: logloc {
    type: number
    sql: ${TABLE}.LOGLOC ;;
  }

  dimension: pointsavailable {
    type: number
    sql: ${TABLE}.POINTSAVAILABLE ;;
  }

  dimension: pointsscored {
    type: number
    sql: ${TABLE}.POINTSSCORED ;;
  }

  dimension: scoreadjustment {
    type: number
    sql: ${TABLE}.SCOREADJUSTMENT ;;
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
