view: users {
  label: "Users"
  sql_table_name: WA_APP_V4NET.USERS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._FIVETRAN_DELETED ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: active {
    type: yesno
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: created {
    type: string
    sql: ${TABLE}.CREATED ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: fullname {
    type: string
    sql: ${TABLE}.FULLNAME ;;
  }

  dimension: last_login {
    type: string
    sql: ${TABLE}.LAST_LOGIN ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: school {
    type: number
    sql: ${TABLE}.SCHOOL ;;
  }

  dimension: ssn {
    type: string
    sql: ${TABLE}.SSN ;;
  }

  dimension: sso_guid {
    type: string
    sql: ${TABLE}.SSO_GUID ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.USERNAME ;;
  }

  measure: count {
    type: count
    drill_fields: [id, username, fullname, firstname, lastname]
  }
}
