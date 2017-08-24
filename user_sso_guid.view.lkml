view: user_sso_guid {
  sql_table_name: WA2ANALYTICS.USER_SSO_GUID ;;

  dimension: active {
    type: yesno
    sql: ${TABLE}.ACTIVE ;;
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
    sql: ${TABLE}.CREATED ;;
  }

  dimension_group: last_login {
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
    sql: ${TABLE}.LAST_LOGIN ;;
  }

  dimension: sso_guid {
    type: string
    sql: ${TABLE}.SSO_GUID ;;
  }

  dimension: userid {
    type: number
    value_format_name: id
    sql: ${TABLE}.USERID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
