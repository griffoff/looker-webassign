view: ucc_items {
  sql_table_name: Uploads.LOTS.UCC_ITEMS ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
    hidden: yes
  }

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

  dimension: chapter {
    group_label: "UCC"
    type: number
    sql: ${TABLE}."CHAPTER" ;;
    hidden: yes
  }

  dimension: code {
    label: "Question Name - 119"
    group_label: "UCC"
    type: string
    sql: ${TABLE}."CODE" ;;
  }

  dimension: comment {
    group_label: "UCC"
    type: string
    sql: ${TABLE}."COMMENT" ;;
    hidden: yes
  }

  dimension: discipline {
    group_label: "UCC"
    type: string
    sql: ${TABLE}."DISCIPLINE" ;;
    hidden: yes
  }

  dimension: first_saved_on {
    group_label: "UCC"
    type: string
    sql: ${TABLE}."FIRST_SAVED_ON" ;;
    hidden: yes
  }

  dimension: in_cp_ {
    group_label: "UCC"
    type: string
    sql: ${TABLE}."IN_CP_" ;;
    hidden: yes
  }

  dimension: in_psp_ {
    group_label: "UCC"
    type: string
    sql: ${TABLE}."IN_PSP_" ;;
    hidden: yes
  }

  dimension: last_saved_on {
    group_label: "UCC"
    type: string
    sql: ${TABLE}."LAST_SAVED_ON" ;;
    hidden: yes
  }

  dimension: lo_set_1 {
    label: "Learning Outcomes - 119"
    group_label: "UCC"
    type: string
    sql: ${TABLE}."LO_SET_1" ;;
  }

  dimension: lo_set_2 {
    label: "Topics - 119"
    group_label: "UCC"
    type: string
    sql: ${TABLE}."LO_SET_2" ;;
  }

  dimension: subdiscipline {
    group_label: "UCC"
    type: string
    sql: ${TABLE}."SUBDISCIPLINE" ;;
    hidden: yes
  }

  dimension: textbook {
    group_label: "UCC"
    type: number
    sql: ${TABLE}."TEXTBOOK" ;;
    hidden: yes
  }

  measure: count {
    group_label: "UCC"
    type: count
    drill_fields: [id]
  }
}
