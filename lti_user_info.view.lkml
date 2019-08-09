view: lti_users_wa_user {
  sql_table_name: WA_APP_V4NET.LTI_USERS_WA_USER ;;

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

  dimension: client_applications_id {
    type: number
    sql: ${TABLE}."CLIENT_APPLICATIONS_ID" ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: lti_user_id {
    label: "LMS User ID"
    description: "Use with Client Applications ID filter"
    type: string
    sql: ${TABLE}."LTI_USER_ID" ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}."UPDATED_AT" ;;
  }

  dimension: wa_user_id {
    type: number
    sql: ${TABLE}."WA_USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
