view: wvu_items {
  sql_table_name: Uploads.LOTS.WVU_ITEMS ;;

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
    hidden: yes
  }

  dimension: learning_outcome_id_set_1_ {
    type: string
    sql: ${TABLE}."LEARNING_OUTCOME_ID_SET_1_" ;;
    hidden: yes
  }

  dimension: learning_outcome_tag_set_1_ {
    type: string
    group_label: "WVU"
    label: "Learning Objective"
    sql: ${TABLE}."LEARNING_OUTCOME_TAG_SET_1_" ;;
    hidden: no
  }

  dimension: lo_tag_id_combined_set_1_ {
    group_label: "WVU"
    type: string
    sql: ${TABLE}."LO_TAG_ID_COMBINED_SET_1_" ;;
  }

  dimension: multiple_los_tag_id_list_all_ {
    group_label: "WVU"
    type: string
    sql: ${TABLE}."MULTIPLE_LOS_TAG_ID_LIST_ALL_" ;;
  }

  dimension: question_id {
    group_label: "WVU"
    label: "Question Name"
    type: string
    sql: ${TABLE}."QUESTION_ID" ;;
  }

  dimension: question_identifier {
    group_label: "WVU"
    type: number
    value_format_name: id
    sql: ${TABLE}."QUESTION_IDENTIFIER" ;;
  }

  measure: count {
    group_label: "WVU"
    type: count
    drill_fields: []
  }
}
