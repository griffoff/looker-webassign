view: classstatistics {
  sql_table_name: WA2ANALYTICS.CLASSSTATISTICS ;;

  dimension: firstquartile {
    type: number
    sql: ${TABLE}.FIRSTQUARTILE ;;
  }

  dimension: maximum {
    type: number
    sql: ${TABLE}.MAXIMUM ;;
  }

  dimension: minimum {
    type: number
    sql: ${TABLE}.MINIMUM ;;
  }

  dimension: secondquartile {
    type: number
    sql: ${TABLE}.SECONDQUARTILE ;;
  }

  dimension: sectionid {
    type: number
    value_format_name: id
    sql: ${TABLE}.SECTIONID ;;
  }

  dimension: thirdquartile {
    type: number
    sql: ${TABLE}.THIRDQUARTILE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
