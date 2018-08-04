view: gradebook {
  sql_table_name: WA_APP_V4NET.GRADEBOOK ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: hash(${user}, '|', ${gbcolid}) ;;
  }

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
    sql: abs(try_cast(${TABLE}.OUTOF as numeric)) ;;
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
    type: number
    sql: abs(try_cast(coalesce(${override}, ${TABLE}.VALUE) AS numeric)) ;;
  }

  dimension: value_converted {
    hidden: no
    type: number
    sql: IFF(${value_base}>${outof_base},${outof_base},${value_base}) ;;
  }

  dimension: outof_base_null {
    type: string
    sql: nullif(${outof_base}, 0) ;;
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

  measure: average_score {
    type: number
    sql: sum(${value_converted})/sum(${outof_base_null}) ;;
    value_format_name: percent_1
  }


}
