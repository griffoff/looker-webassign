view: dim_isbn {
  sql_table_name: FT_OLAP_REGISTRATION_REPORTS.DIM_ISBN ;;

  dimension: dim_isbn_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DIM_ISBN_ID ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._FIVETRAN_DELETED ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: date_from {
    type: string
    sql: ${TABLE}.DATE_FROM ;;
  }

  dimension: date_to {
    type: string
    sql: ${TABLE}.DATE_TO ;;
  }

  dimension: isbn {
    type: string
    sql: ${TABLE}.ISBN ;;
  }

  dimension: last_update {
    type: string
    sql: ${TABLE}.LAST_UPDATE ;;
  }

  dimension: record_created {
    type: string
    sql: ${TABLE}.RECORD_CREATED ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.VERSION ;;
  }

  measure: count {
    type: count
    drill_fields: [dim_isbn_id]
  }
}
