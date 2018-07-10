view: gradebook {
  sql_table_name: WA_APP_V4NET.GRADEBOOK ;;

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._FIVETRAN_DELETED ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.COMMENT ;;
  }

  dimension: gbcolid {
    type: number
    value_format_name: id
    sql: ${TABLE}.GBCOLID ;;
  }

  dimension: outof_base {
    type: string
    sql: ${TABLE}.OUTOF ;;
  }

  dimension: override {
    type: string
    sql: ${TABLE}.OVERRIDE ;;
  }

  dimension: user {
    type: number
    sql: ${TABLE}."USER" ;;
  }

  dimension: value_base {
    type: string
    sql: ${TABLE}.VALUE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: value {
    type: sum
    sql: ${value_base};;
  }
  measure: outof {
    type: sum
    sql: ${outof_base};;
  }
  measure: score {
    type: number
    sql: ${value}/nullif(${outof},0) ;;
    value_format_name: percent_1
  }
}
