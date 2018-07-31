view: assessment_assets {
  sql_table_name: LO_METADATA.ASSESSMENT_ASSETS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
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
  }

  dimension: _row {
    type: number
    sql: ${TABLE}."_ROW" ;;
  }

  dimension: chapter {
    type: string
    sql: ${TABLE}."CHAPTER" ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}."COMMENT" ;;
  }

  dimension: difficulty_level_ {
    type: string
    sql: ${TABLE}."DIFFICULTY_LEVEL_" ;;
  }

  dimension: discipline {
    type: string
    sql: ${TABLE}."DISCIPLINE" ;;
  }

  dimension: enhanced_feedback_ {
    type: string
    sql: ${TABLE}."ENHANCED_FEEDBACK_" ;;
  }

  dimension: first_saved_on {
    type: string
    sql: ${TABLE}."FIRST_SAVED_ON" ;;
  }

  dimension: in_cp_ {
    type: string
    sql: ${TABLE}."IN_CP_" ;;
  }

  dimension: in_psp_ {
    type: string
    sql: ${TABLE}."IN_PSP_" ;;
  }

  dimension: last_saved_on {
    type: string
    sql: ${TABLE}."LAST_SAVED_ON" ;;
  }

  dimension: lo_1 {
    type: string
    sql: ${TABLE}."LO_1" ;;
  }

  dimension: lo_2 {
    type: string
    sql: ${TABLE}."LO_2" ;;
  }

  dimension: lo_3 {
    type: string
    sql: ${TABLE}."LO_3" ;;
  }

  dimension: lo_4 {
    type: string
    sql: ${TABLE}."LO_4" ;;
  }

  dimension: mi_ {
    type: string
    sql: ${TABLE}."MI_" ;;
  }

  dimension: mode {
    type: string
    sql: ${TABLE}."MODE" ;;
  }

  dimension: publisher {
    type: string
    sql: ${TABLE}."PUBLISHER" ;;
  }

  dimension: revisit_y_n_ {
    type: string
    sql: ${TABLE}."REVISIT_Y_N_" ;;
  }

  dimension: section {
    type: string
    sql: ${TABLE}."SECTION" ;;
  }

  dimension: solution_ {
    type: string
    sql: ${TABLE}."SOLUTION_" ;;
  }

  dimension: sub_topic {
    type: string
    sql: ${TABLE}."SUB_TOPIC" ;;
  }

  dimension: subdiscipline {
    type: string
    sql: ${TABLE}."SUBDISCIPLINE" ;;
  }

  dimension: textbook {
    type: number
    sql: ${TABLE}."TEXTBOOK" ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}."TITLE" ;;
  }

  dimension: topic {
    type: string
    sql: ${TABLE}."TOPIC" ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}."TYPE" ;;
  }

  dimension: usage {
    type: string
    sql: ${TABLE}."USAGE" ;;
  }

  dimension: watch_it_ {
    type: string
    sql: ${TABLE}."WATCH_IT_" ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
