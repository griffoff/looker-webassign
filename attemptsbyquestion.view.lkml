view: attemptsbyquestion {
  label:"Question - Attempts"
  sql_table_name: WA2ANALYTICS.ATTEMPTSBYQUESTION ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: attemptnum {
    label: "Attempt Number"
    description: "The attempt number"
    type: number
    sql: ${TABLE}.ATTEMPTNUM ;;
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

  dimension: percentcorrect {
    label: "Percent Correct"
    type: number
    sql: ${TABLE}.PERCENTCORRECT ;;
  }

  dimension: questionid {
    label: "Question ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.QUESTIONID ;;
  }

  dimension: sectionid {
    label: "Section ID"
    description:"For link to course/section which should link to instition"
    type: number
    value_format_name: id
    sql: ${TABLE}.SECTIONID ;;
  }

  dimension: sectionslessonid {
    label: "Sections Lession ID"
    description: "Need to confirm what this is"
    type: number
    value_format_name: id
    sql: ${TABLE}.SECTIONSLESSONID ;;
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

  measure: count {
    type: count
    drill_fields: [id]
  }
}
