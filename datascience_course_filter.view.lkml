view: datascience_course_filter {
  derived_table: {
    sql:
      with sections as (
        SELECT dim_section.section_id, count(*) as c
        FROM ${dim_section.SQL_TABLE_NAME} AS dim_section
        INNER JOIN ${dim_textbook.SQL_TABLE_NAME}  AS dim_textbook ON dim_section.DIM_TEXTBOOK_ID = dim_textbook.DIM_TEXTBOOK_ID
        INNER JOIN ${roster.SQL_TABLE_NAME}  AS roster ON dim_section.SECTION_ID = roster.SECTION
        INNER JOIN ${users.SQL_TABLE_NAME}  AS users ON roster.user = users.id
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

      sql_trigger_value: select 2 ;; #change this number to regenerate
    }

    dimension: section_id {type:number primary_key:yes}
    dimension: set_type {type:string}
  }
