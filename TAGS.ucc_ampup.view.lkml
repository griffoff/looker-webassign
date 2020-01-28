view: ucc_ampup {
  sql_table_name: uploads.LOTS.UCC_AMPUP ;;

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

  dimension: amp_up {
    label: "AMP UP - 119"
    group_label: "UCC"
    type: string
    sql: ${TABLE}."AMP_UP" ;;
  }

  dimension: lms_user_id {
    hidden: yes
    group_label: "UCC"
    type: string
    sql: ${TABLE}."LMS_USER_ID" ;;
  }

  dimension: web_assign_id {
    hidden: yes
    group_label: "UCC"
    type: number
    sql: ${TABLE}."WEB_ASSIGN_ID" ;;
  }

}
