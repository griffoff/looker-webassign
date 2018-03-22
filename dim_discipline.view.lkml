view: dim_discipline {
  view_label: "Discipline"
  sql_table_name: FT_OLAP_REGISTRATION_REPORTS.DIM_DISCIPLINE ;;

  dimension: dim_discipline_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DIM_DISCIPLINE_ID ;;
    hidden: yes
  }

  dimension: discipline_id {
    type: number
    sql: ${TABLE}.DISCIPLINE_ID ;;
    hidden: yes
  }

  dimension: discipline_name {
    label: "Discipline - WA"
    description: "Based on WebAssign definition - likely varies from standard Cengage discipline definitions"
    type: string
    sql: ${TABLE}.DISCIPLINE_NAME ;;
  }

  dimension: sub_discipline_id {
    type: number
    sql: ${TABLE}.SUB_DISCIPLINE_ID ;;
    hidden: yes
  }

  dimension: sub_discipline_name {
    label: "Sub-discipline - WA"
    description: "Based on WebAssign definition - unclear what the proxy in Cengage terms would be.  Sub-discipline could be a subset of Math areas, for example (e.g. Calculus)"
    type: string
    sql: ${TABLE}.SUB_DISCIPLINE_NAME ;;
  }

  measure: count {
    type: count
    drill_fields: [dim_discipline_id, discipline_name, sub_discipline_name, dim_section.count]
  }
}
