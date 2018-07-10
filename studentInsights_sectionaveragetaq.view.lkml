view: sectionaveragetaq {
  view_label: "Average Time"
  sql_table_name: WA2ANALYTICS.SECTIONAVERAGETAQ ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: averagetaqms {
    label: "Average Time (ms)"
    type: number
    sql: ${TABLE}.AVERAGETAQMS ;;
  }

  dimension_group: createdat {
    label: "Created"
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

  dimension: questionid {
    label: "Question ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.QUESTIONID ;;
  }

  dimension: sectionid {
    label: "Section ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.SECTIONID ;;
  }

  dimension: sectionslessonid {
    label: "Section Lesson ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.SECTIONSLESSONID ;;
  }

  dimension_group: updatedat {
    label: "Update"
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

  measure: count {
    type: count
    drill_fields: [id]
  }
}
