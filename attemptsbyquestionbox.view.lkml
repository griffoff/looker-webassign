view: attemptsbyquestionbox {
  sql_table_name: WA2ANALYTICS.ATTEMPTSBYQUESTIONBOX ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: attemptnumber {
    label: "Attempt Number"
    type: number
    sql: ${TABLE}.ATTEMPTNUMBER ;;
  }

  dimension: avgpercentcorrect {
    label: "Avg. Percent Correct"
    type: number
    sql: ${TABLE}.AVGPERCENTCORRECT ;;
  }

  dimension: boxnumber {
    label: "Box (Part) Number"
    description: "A 'box' references a part of a multi-part question.  The 'a' and 'b' of questions 5a and 5b"
    type: number
    sql: ${TABLE}.BOXNUMBER ;;
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
    description: "Need to figure out what this is"
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
