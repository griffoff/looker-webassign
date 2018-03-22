view: footprints {
  sql_table_name: WA_APP_ACTIVITY.FOOTPRINTS ;;

  dimension: id {
    label: "Footprints ID"
    description: "test id"
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._FIVETRAN_DELETED ;;
    hidden: yes
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
    hidden: yes
  }

  dimension: action {
    type: string
    sql: ${TABLE}.ACTION ;;
  }

  dimension: action_test {
    type: string
    sql: CASE when "%login%" THEN 'login events' else 'NA' end ;;
  }

  dimension: sso_guid {
    type: string
    sql: ${TABLE}.SSO_GUID ;;
  }

  dimension: step {
    type: date_time
    sql: ${TABLE}.STEP ;;
  }

  dimension_group: datevalue {
    type: time
    timeframes: [
      date,
      month,
      month_name,
      year,
      day_of_week,
      day_of_year
      #quarter_of_year,
#       fiscal_year,
#       fiscal_quarter,
#       fiscal_quarter_of_year,
#       fiscal_month_num
    ]
    convert_tz: no
    sql: ${TABLE}.STEP ;;
    label: "Time of Activity"
    hidden: no
  }

  dimension: user {
    type: number
    sql: ${TABLE}."USER" ;;
  }

  measure: count {
    label: "No of Clicks"
    type: count
    drill_fields: [id]
  }
}
