view: gradebook_final {
  derived_table: {
    explore_source: gradebook {
      derived_column: pk { sql: hash(section_id,'|',user_id);; }
      column: section_id { field: gbcolumns.section }
      column: user_id { field: gradebook.user}
      column: col { field: gbcolumns.col }
      column: category_id { field: gbcolumns.category_id }
      column: category_name { field: categories.name }
      column: category_group { field: categories.category }
      column: points_scored {field: gradebook.value_converted }
      column: points_possible {field: gradebook.outof_base_null }
      filters: {
        field: gbcolumns.object
        value: "20"
      }
      filters: {
        field: gbcolumns.id
        value: "0"
      }
    }
    datagroup_trigger: gradebook_datagroup
  }
  dimension: section_id {
    type: number
  }
  dimension: user_id {
    type: number
  }
  dimension: col {
    type: string
  }
  dimension: category_id {
    type: number
  }
  dimension: category_name {
    type: string
  }
  dimension: category_group {
    type: string
  }

  dimension: points_scored {
    type: number
  }
  dimension: points_possible {
    type: number
  }
  dimension: score {
    type: number
    sql: ${points_scored}/${points_possible} ;;
    value_format_name: percent_1
  }

  measure: average_score {
    type: average
    sql: ${score} ;;
    value_format_name: percent_1
  }


}
