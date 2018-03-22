view: dim_payment_method {
  sql_table_name: FT_OLAP_REGISTRATION_REPORTS.DIM_PAYMENT_METHOD ;;

  dimension: dim_payment_method_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DIM_PAYMENT_METHOD_ID ;;
  }

  dimension: category {
    description: "Groups payment methods into 3 categories: Revenue, No Revenue, and Other"
    type: string
    sql: ${TABLE}.CATEGORY ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: redemption_model {
    type: yesno
    sql: ${TABLE}.REDEMPTION_MODEL ;;
  }

  measure: count {
    type: count
    drill_fields: [dim_payment_method_id]
  }
}
