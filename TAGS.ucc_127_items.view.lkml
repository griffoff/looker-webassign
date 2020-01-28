view: ucc_127_items {
  sql_table_name: uploads.LOTS.UCC_127_ITEMS
    ;;

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
    hidden: yes
  }

  dimension_group: _fivetran_synced {
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
    sql: ${TABLE}."_FIVETRAN_SYNCED" ;;
    hidden: yes
  }

  dimension: _row {
    type: number
    sql: ${TABLE}."_ROW" ;;
    hidden:  yes
  }

  dimension: code {
    label: "Question Name - 127"
    group_label: "UCC"
    type: string
    sql: ${TABLE}."CODE" ;;
  }

  dimension: learning_outcome {
    label: "Learning Outcomes - 127"
    group_label: "UCC"
    type: string
    sql: ${TABLE}."LEARNING_OUTCOME" ;;
  }

  dimension: question_id {
    label: "Question ID - 127"
    group_label: "UCC"
    type: number
    sql: ${TABLE}."QUESTION_ID" ;;
    hidden: yes
  }

  dimension: topic {
    label: "Topics - 127"
    group_label: "UCC"
    type: string
    sql: ${TABLE}."TOPIC" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
