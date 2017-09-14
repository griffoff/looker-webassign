view: attemptsbyquestion {
  view_label:"Question - Attempts"
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
    description: "Should be assignments - Need to confirm what this is"
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

  measure: question_count {
    label: "Number of questions (distinct)"
    description: "Distinct quesiton count"
    type: count_distinct
    sql: ${questionid} ;;
    drill_fields: [questionid]
  }

  measure: total_attempts{
    label: "Total attempts"
    description: "Sum of all attempts"
    type: sum
    sql: ${attemptnum} ;;
  }

  measure: Assignment_count{
    label:"Number of Assignments (distinct)"
    description: "distint assignment count"
    type: count_distinct
    sql: ${sectionslessonid} ;;
  }

  measure: section_count {
    label: "Number of course sections (distinct)"
    description: "Distinct count of course sections"
    type: count_distinct
    sql: ${sectionid} ;;
  }

  measure: sectionlesson_count {
    label: "Number of Assignments (sectionlessons - distinct)"
    description: "Distinct count of sectionlesson IDs (assignments)"
    type: count_distinct
    sql: ${sectionslessonid};;
  }
}
