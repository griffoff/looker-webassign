view: dim_assignment_feedback {
  sql_table_name: FT_OLAP_REGISTRATION_REPORTS.DIM_ASSIGNMENT_FEEDBACK ;;

  dimension: dim_assignment_feedback_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DIM_ASSIGNMENT_FEEDBACK_ID ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._FIVETRAN_DELETED ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: after_attempts_used {
    type: string
    sql: ${TABLE}.AFTER_ATTEMPTS_USED ;;
  }

  dimension: box_score {
    type: string
    sql: ${TABLE}.BOX_SCORE ;;
  }

  dimension: detailed_score {
    type: string
    sql: ${TABLE}.DETAILED_SCORE ;;
  }

  dimension: hashcode {
    type: number
    sql: ${TABLE}.HASHCODE ;;
  }

  dimension: help {
    type: string
    sql: ${TABLE}.HELP ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}.KEY ;;
  }

  dimension: last_only {
    type: string
    sql: ${TABLE}.LAST_ONLY ;;
  }

  dimension: mark {
    type: string
    sql: ${TABLE}.MARK ;;
  }

  dimension: nothing {
    type: string
    sql: ${TABLE}.NOTHING ;;
  }

  dimension: practice {
    type: string
    sql: ${TABLE}.PRACTICE ;;
  }

  dimension: publish {
    type: string
    sql: ${TABLE}.PUBLISH ;;
  }

  dimension: remarks {
    type: string
    sql: ${TABLE}.REMARKS ;;
  }

  dimension: response {
    type: string
    sql: ${TABLE}.RESPONSE ;;
  }

  dimension: save_work {
    type: string
    sql: ${TABLE}.SAVE_WORK ;;
  }

  dimension: score {
    type: string
    sql: ${TABLE}.SCORE ;;
  }

  dimension: solution {
    type: string
    sql: ${TABLE}.SOLUTION ;;
  }

  measure: count {
    type: count
    drill_fields: [dim_assignment_feedback_id]
  }
}
