view: lessonscores {
  view_label: "Lesson Scores"
  sql_table_name: WA2ANALYTICS.LESSONSCORES ;;

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

  dimension: lessonid {
    type: string
    sql: ${TABLE}.LESSONID ;;
  }

  dimension: questionsasked {
    label: "Questions Asked"
    type: number
    sql: ${TABLE}.QUESTIONSASKED ;;
  }

  dimension: questionscorrect {
    label: "Questions Correct"
    type: number
    sql: ${TABLE}.QUESTIONSCORRECT ;;
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
    type: string
    sql: ${TABLE}.USERID ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
