view: section_weeks {
  derived_table: {
    sql:
      with weeks as (
            select seq4() as week_no
            from table(generator(rowcount=>104))
          --104 covers 99% of the courses
        )
        ,response as (
            select section_id, min(logged) as first_response_created, max(logged) as last_response_update
            from ${responses.SQL_TABLE_NAME} r
            inner join ${dim_deployment.SQL_TABLE_NAME} d on r.deployment_id = d.deployment_id
            group by section_id
        )
        ,sections as (
          select
              s.section_id
              ,case
                when false
                --when datediff(week, starts_eastern, ends_eastern ) > 52 or datediff(week, starts_eastern, ends_eastern ) < 0
                 then r.first_response_created
                 else starts_eastern
                 end as start_date
              ,case
                    --when datediff(week, starts_eastern, ends_eastern ) > 52 or datediff(week, starts_eastern, ends_eastern ) < 0
                when starts_eastern > ends_eastern
                then r.last_response_update
                 else ends_eastern
                 end as end_date
              ,first_response_created
              ,last_response_update
              ,starts_eastern, ends_eastern
              ,datediff(week, start_date, end_date) as course_length
          from ${dim_section.SQL_TABLE_NAME} s
          inner join response r on s.section_id = r.section_id
          --where s.section_id = 448614
        )
        select
            section_id
            ,week_no as relative_week
            ,start_date
            ,end_date
            ,first_response_created
            ,last_response_update
            ,course_length
            ,dateadd(week, week_no, start_date) as week_start
        from sections s
        inner join weeks on course_length >= weeks.week_no;;

        sql_trigger_value: select * from ${dim_section.SQL_TABLE_NAME} ;;
    }

    dimension: section_id {primary_key:yes}
    dimension: relative_week {type:number}

  }
