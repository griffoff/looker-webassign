#explore: datascience_course_filter{}

view: datascience_course_filter {
  derived_table: {
    sql:
      with sections as (
        SELECT dim_section.section_id
              ,count(*) as student_count
              ,count(case when roster.dropdate < dim_section.ends_eastern then 1 end) as drop_count
              ,count(case when roster.dropdate >= dim_section.ends_eastern then 1 end) as notdrop_count
        FROM ${dim_section.SQL_TABLE_NAME} AS dim_section
        INNER JOIN ${dim_textbook.SQL_TABLE_NAME}  AS dim_textbook ON dim_section.DIM_TEXTBOOK_ID = dim_textbook.DIM_TEXTBOOK_ID
        INNER JOIN ${roster.SQL_TABLE_NAME}  AS roster ON dim_section.SECTION_ID = roster.SECTION
        INNER JOIN ${users.SQL_TABLE_NAME}  AS users ON roster.user = users.id
        WHERE dim_textbook.CODE in ('SCalcET8', 'SCalc8')
          and dim_section.ends_eastern < dateadd(day, -7, current_date())
          and dim_section.gb_configured = 'yes'
          and dim_section.gb_has_data = 'yes'
          --and section_id in (select section_id from ${section_weeks.SQL_TABLE_NAME})
        group by 1
        having notdrop_count >= 20
        )
      select
          section_id
          ,student_count as students
          ,drop_count
          ,notdrop_count
          ,percent_rank() over (order by random(0.1)) as p
          ,case when p <= 0.6 then 'Train' when p <= 0.9 then 'Test' else 'Validate' end as set_type
      from sections
      sample (380 rows)
      --https://www.checkmarket.com/sample-size-calculator/ sample size: 30028, margin: 5%, confidence: 95%
      ;;

      sql_trigger_value: select 4 ;; #change this number to regenerate
    }

    dimension: section_id {type:number primary_key:yes}
    dimension: set_type {type:string}
    measure: count {type:count}
  }