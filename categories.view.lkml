view: categories {
  view_label: "Gradebook"
  sql_table_name: WA_APP_V4NET.CATEGORIES ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."ID"::string ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."_FIVETRAN_SYNCED" ;;
  }

  dimension: characteristics {
    type: string
    sql: ${TABLE}."CHARACTERISTICS" ;;
  }

   dimension: category {
    label: "Gradebook category group"
    sql: case
          when lower(${name}) like '%homework%' then 'Homework'
          when lower(${name}) like '%exam%'
                or lower(${name}) like '%final%'
                or lower(${name}) like '%test%'
                or lower(${name}) like '%midterm%' then 'Exam'
          when lower(${name}) like '%lab%'
                or lower(${name}) like '%project%' then 'Labwork'
          when lower(${name}) like '%quiz%' then 'Quiz'
          when lower(${name}) like '%attendance%'
                or lower(${name}) like '%in_class%'
                or lower(${name}) like '%participation%' then 'Presence'
          when lower(${name}) like '%bonus%' then 'Bonus'
          else
            'Other'
          end
                ;;
  }

  dimension: name {
    label: "Gradebook category"
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: user {
    type: number
    sql: ${TABLE}."USER" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
