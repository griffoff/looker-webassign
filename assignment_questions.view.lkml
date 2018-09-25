view: assignment_questions {
  derived_table: {
    explore_source: responses {
      column: assignment_id {field:dim_assignment.assignment_id}
      column: question_id {field:dim_question.question_id}
      column: box_num {field: responses.boxnum}
    }
    datagroup_trigger: responses_dependencies_datagroup
  }

  dimension: assignment_id {type:number}
  dimension: question_id {type:number}
  dimension: box_num {type:number}

}
