view: responses {
  sql_table_name: WA2ANALYTICS.RESPONSES ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: attemptnumber {
    type: number
    sql: ${TABLE}.ATTEMPTNUMBER ;;
  }

  dimension: boxnum {
    type: number
    sql: ${TABLE}.BOXNUM ;;
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

  dimension: iscorrect {
    type: number
    sql: ${TABLE}.ISCORRECT ;;
  }

  measure: numbercorrect {
    label: "# Correct"
    type: sum
    sql: ${TABLE}.ISCORRECT;;
  }

  measure: percentcorrect {
    label: "% Correct"
    type: number
    sql: ${numbercorrect} / ${count};;
    value_format_name: percent_1
  }

  dimension: is_last_attempt {
    type: yesno
    sql:
            row_number() over (partition by ${userid},${questionid},${boxnum}
                              order by ${attemptnumber} desc) = 1
         ;;
  }

  dimension: overridescore {
    type: number
    sql: ${TABLE}.OVERRIDESCORE ;;
  }

  dimension: pointsscored {
    type: number
    sql: ${TABLE}.POINTSSCORED ;;
  }

  dimension: questionid {
    type: number
    value_format_name: id
    sql: ${TABLE}.QUESTIONID ;;
  }

  dimension: sectionslessonsid {
    type: number
    value_format_name: id
    sql: ${TABLE}.SECTIONSLESSONSID ;;
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
