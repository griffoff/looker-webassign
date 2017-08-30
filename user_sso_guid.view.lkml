view: user_sso_guid {
  label: "User - SSO"
  sql_table_name: WA2ANALYTICS.USER_SSO_GUID ;;

  dimension: active {
    label: "Is Active (yes/no)"
    type: yesno
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension_group: created {
    label: "Date created"
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
    label: "Last Login/Session"
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
    label: "SSO GUID"
    type: string
    sql: ${TABLE}.SSO_GUID ;;
  }

  dimension: userid {
    label: "User ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.USERID ;;
  }

  dimension: email {
    label: "Email address"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: school_id  {
    label: "School ID"
    type: number
    sql: ${TABLE}.schoolid ;;
  }

  dimension: faculty {
    label: "Is Faculty (Yes/No)"
    type: yesno
    sql: ${TABLE}.faculty ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
