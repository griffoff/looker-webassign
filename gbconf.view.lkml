view: gbconf {
  sql_table_name: WA_APP_V4NET.GBCONF ;;

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._FIVETRAN_DELETED ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: section {
    type: number
    sql: ${TABLE}.SECTION ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.STATE ;;
  }

  dimension: which {
    type: string
    sql: ${TABLE}.WHICH ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
