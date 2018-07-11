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

  measure: Homework_Score  {
    group_label: "Category Scores"
    type:  average
    sql: case when lower(${categories.name}) like '%homework%' then  ${value_base}/nullif(${outof_base},0) end ;;
    value_format_name: percent_1
  }
  measure: Exam_Score  {
    group_label: "Category Scores"
    type:  average
    sql: case when lower(${categories.name}) like '%exam%'
                or lower(${categories.name}) like '%final%'
                or lower(${categories.name}) like '%test%'
                or lower(${categories.name}) like '%midterm%' then  ${value_base}/nullif(${outof_base},0) end ;;
    value_format_name: percent_1
  }
  measure: Labwork_Score  {
    group_label: "Category Scores"
    type:  average
    sql: case when lower(${categories.name}) like '%lab%'
                or lower(${categories.name}) like '%project%' then  ${value_base}/nullif(${outof_base},0) end ;;
    value_format_name: percent_1
  }
  measure: Quiz_Score  {
    group_label: "Category Scores"
    type:  average
    sql: case when lower(${categories.name}) like '%quiz%' then  ${value_base}/nullif(${outof_base},0) end ;;
    value_format_name: percent_1
  }
  measure: Presence_Score  {
    group_label: "Category Scores"
    type:  average
    sql: case when lower(${categories.name}) like '%attendance%'
                or lower(${categories.name}) like '%in_class%'
                or lower(${categories.name}) like '%participation%' then  ${value_base}/nullif(${outof_base},0) end ;;
    value_format_name: percent_1
  }
  measure: Bonus_Score  {
    group_label: "Category Scores"
    type:  average
    sql: case when lower(${categories.name}) like '%bonus%' then  ${value_base}/nullif(${outof_base},0) end ;;
    value_format_name: percent_1
  }
  measure: Other_Score  {
    group_label: "Category Scores"
    type:  average
    sql: case when lower(${categories.name}) not like '%exam%'
               and lower(${categories.name}) not like '%final%'
               and lower(${categories.name}) not like '%test%'
               and lower(${categories.name}) not like '%midterm%'
               and lower(${categories.name}) not like '%homework%'
               and lower(${categories.name}) not like '%lab%'
               and lower(${categories.name}) not like '%project%'
               and lower(${categories.name}) like '%quiz%'
               and lower(${categories.name}) like '%attendance%'
               and lower(${categories.name}) like '%in_class%'
               and lower(${categories.name}) like '%participation%'
              then  ${value_base}/nullif(${outof_base},0) end ;;
    value_format_name: percent_1
  }

}
