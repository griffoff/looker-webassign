view: sectionslessons {
  view_label: "Section's Lessons (Assignments)"
  #same as deployment
  #which is an assignment given to a specific class
  sql_table_name: WA2ANALYTICS.SECTIONSLESSONS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
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

  dimension_group: duedate {
    label: "Due"
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
    sql: ${TABLE}.DUEDATE ;;
  }

  dimension: lessonid {
    label: "Lesson ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.LESSONID ;;
  }

  dimension: lessonname {
    label: "Lesson Name"
    type: string
    sql: ${TABLE}.LESSONNAME ;;
  }

  dimension: scoreadjustment {
    label: "Score Adjustment"
    type: number
    sql: ${TABLE}.SCOREADJUSTMENT ;;
  }

  dimension: sectionid {
    label: "Section ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.SECTIONID ;;
  }

  dimension: showscoreafterdue {
    label: "Show Score After Due"
    type: yesno
    sql: ${TABLE}.SHOWSCOREAFTERDUE ;;
  }

  dimension: showscorebeforedue {
    label: "Show Score Before Due"
    type: yesno
    sql: ${TABLE}.SHOWSCOREBEFOREDUE ;;
  }

  dimension_group: startdate {
    label: "Start"
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
    sql: ${TABLE}.STARTDATE ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  dimension_group: updatedat {
    label: "Updated"
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
    drill_fields: [id, lessonname]
  }
}
