view: datascience_course_filter {
  derived_table: {
    sql:
      with sections as (
        select dim_section.section_id, count(*) as c
        FROM ${dim_section.SQL_TABLE_NAME} AS dim_section
        LEFT JOIN ${dim_textbook.SQL_TABLE_NAME}  AS dim_textbook ON dim_section.DIM_TEXTBOOK_ID = dim_textbook.DIM_TEXTBOOK_ID
        LEFT JOIN ${roster.SQL_TABLE_NAME}  AS roster ON dim_section.SECTION_ID = roster.SECTION
        WHERE
          dim_textbook.CODE in ('SCalcET8', 'SCalc8')
        group by 1
        having count(*) > 20
        )
      select
          section_id
          ,c as students
          ,percent_rank() over (order by random(0.1)) as p
          ,case when p <= 0.6 then 'Train' when p <= 0.9 then 'Test' else 'Validate' end as set_type
      from sections
      sample (380 rows)
      --https://www.checkmarket.com/sample-size-calculator/ sample size: 30028, margin: 5%, confidence: 95%
      ;;

      sql_trigger_value: select 1 ;; #don't regenerate
    }

    dimension: section_id {type:number primary_key:yes}
    dimension: set_type {type:string}
  }
