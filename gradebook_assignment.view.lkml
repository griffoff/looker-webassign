#include:"student_insights.model.lkml"
#explore: gradebook_assignment{}

view: gradebook_assignment {

  derived_table: {
    explore_source: gradebook {
      derived_column: pk { sql: hash(section_id,'|',user_id, '|', deployment_id);; }
      column: section_id { field: gbcolumns.section }
      column: user_id { field: gradebook.user}
      column: deployment_id { field: gbcolumns.id }
      column: col { field: gbcolumns.col }
      column: category_id { field: gbcolumns.category_id }
      column: category_name { field: categories.name }
      column: category_group { field: categories.category }
      column: points_scored {field: gradebook.value_converted }
      column: points_possible {field: gradebook.outof_base_null }
      column: sheet { field: gbcolumns.sheet }
      column: comment {}
      filters: {
        field: gbcolumns.object
        value: "10"
      }

    }
    datagroup_trigger: gradebook_datagroup
  }
  dimension: pk {primary_key:yes hidden:yes}
  dimension: section_id {
    type: number
  }
  dimension: user_id {
    type: number
  }
  dimension: deployment_id {
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
  dimension: sheet {
    type: number
  }
  dimension: comment {}


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

  measure: homework_score  {
    group_label: "Category Scores"
    type:  average
    sql: ${score} ;;
    filters: {
      field: category_group
      value: "Homework"
    }
    value_format_name: percent_1
  }
  measure: exam_score  {
    group_label: "Category Scores"
    type:  average
    sql: ${score} ;;
    filters: {
      field: category_group
      value: "Exam"
    }
    value_format_name: percent_1
  }
  measure: labwork_score  {
    group_label: "Category Scores"
    type:  average
    sql: ${score} ;;
    filters: {
      field: category_group
      value: "Labwork"
    }
    value_format_name: percent_1
  }
  measure: quiz_score  {
    group_label: "Category Scores"
    type: average
    sql: ${score} ;;
    filters: {
      field: category_group
      value: "Quiz"
    }
    value_format_name: percent_1
  }
  measure: presence_score  {
    group_label: "Category Scores"
    type: average
    sql: ${score} ;;
    filters: {
      field: category_group
      value: "Presence"
    }
    value_format_name: percent_1
  }
  measure: bonus_score  {
    group_label: "Category Scores"
    type:  average
    sql: ${score} ;;
    filters: {
      field: category_group
      value: "Bonus"
    }
    value_format_name: percent_1
  }
  measure: other_score  {
    group_label: "Category Scores"
    type:  average
    sql: ${score} ;;
    filters: {
      field: category_group
      value: "Other"
    }
    value_format_name: percent_1
  }
}
