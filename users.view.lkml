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
    hidden: yes
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
    hidden: yes
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

  measure: usercount {
    type: count
    drill_fields: [id, username, fullname, firstname, lastname]
  }

#   measure: user_count {
#     label: "# Distinct Users"
#     description: "# distint users who have accessed an item from a section"
#     type: count_distinct
#     sql: array_construct(${usercount},${dim_deployment.section_id}) ;;
#   }

  measure: percent_activation {
    label: "% of Activations (used / exposed)"
    description: "
    No. of people / Total Roster in this context
    i.e.
    no. of people who accessed vs no. of people who were exposed to this item
    "
    type: number
    sql: COALESCE(${usercount} / NULLIF(${dim_section.roster_sum}, 0.0),0) ;;
    value_format_name: percent_1
    html:
      <div style="width:100%;">
        <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
      </div>
    ;;

  }


}
