view: gbcolumns {
  sql_table_name: WA_APP_V4NET.GBCOLUMNS ;;

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
    type: string
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: col {
    type: string
    sql: ${TABLE}.COL ;;
  }

  dimension: gbcolid {
    type: number
    value_format_name: id
    sql: ${TABLE}.GBCOLID ;;
  }

  dimension: object {
    type: number
    sql: ${TABLE}.OBJECT ;;
  }

  dimension: possible {
    type: string
    sql: ${TABLE}.POSSIBLE ;;
  }

  dimension: section {
    type: number
    sql: ${TABLE}.SECTION ;;
  }

  dimension: sheet {
    type: number
    sql: ${TABLE}.SHEET ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
