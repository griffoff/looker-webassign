view: gbsettings {
  sql_table_name: WA_APP_V4NET.GBSETTINGS ;;

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

  dimension: average {
    type: string
    sql: ${TABLE}.AVERAGE ;;
  }

  dimension: calculation {
    type: string
    sql: ${TABLE}.CALCULATION ;;
  }

  dimension: chart {
    type: string
    sql: ${TABLE}.CHART ;;
  }

  dimension: defaultweight {
    type: string
    sql: ${TABLE}.DEFAULTWEIGHT ;;
  }

  dimension: include {
    type: string
    sql: ${TABLE}.INCLUDE ;;
  }

  dimension: maximum {
    type: string
    sql: ${TABLE}.MAXIMUM ;;
  }

  dimension: minimum {
    type: string
    sql: ${TABLE}.MINIMUM ;;
  }

  dimension: object {
    type: number
    sql: ${TABLE}.OBJECT ;;
  }

  dimension: posted {
    type: string
    sql: ${TABLE}.POSTED ;;
  }

  dimension: section {
    type: number
    sql: ${TABLE}.SECTION ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.STATE ;;
  }

  dimension: stdev {
    type: string
    sql: ${TABLE}.STDEV ;;
  }

  dimension: weight {
    type: string
    sql: ${TABLE}.WEIGHT ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
