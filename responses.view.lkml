view: responses {
  #sql_table_name: WA2ANALYTICS.RESPONSES ;;
  derived_table: {
    sql:
      select
        *
        ,row_number() over (partition by responses.USERID,responses.QUESTIONID,responses.BOXNUM
                              order by responses.ATTEMPTNUMBER desc) as reverse_attemptnumber
      from WA2ANALYTICS.RESPONSES;;

      sql_trigger_value: select count(*) from WA2ANALYTICS.RESPONSES ;;
    }

    set: all {fields: [id, userid, dim_question.code, iscorrect]}

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.ID ;;
    }

    dimension: reverse_attemptnumber {}

    dimension: attemptnumber {
      type: number
      sql: ${TABLE}.ATTEMPTNUMBER ;;
    }

    dimension: boxnum {
      type: number
      sql: ${TABLE}.BOXNUM ;;
    }

    dimension_group: createdat {
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
      sql: ${TABLE}.CREATEDAT ;;
    }

    dimension: iscorrect {
      type: number
      sql: ${TABLE}.ISCORRECT ;;
    }

    measure: numbercorrect {
      label: "# Correct"
      type: sum
      sql: ${TABLE}.ISCORRECT;;
      drill_fields: [all*]
    }

    measure: percentcorrect {
      label: "% Correct"
      type: number
      sql: ${numbercorrect} / nullif(${count}, 0);;
      value_format_name: percent_1
      drill_fields: [all*]
      html:
      <div style="width:100%;">
      <div style="width: {{rendered_value}};background-color: rgba(70,130,180, 0.25);text-align:center; overflow:visible">{{rendered_value}}</div>
      </div>;;
    }

    dimension: is_last_attempt {
      type: yesno
      sql: ${reverse_attemptnumber} = 1 ;;
    }

    dimension: overridescore {
      type: number
      sql: ${TABLE}.OVERRIDESCORE ;;
    }

    dimension: pointsscored {
      type: number
      sql: ${TABLE}.POINTSSCORED ;;
    }

    dimension: questionid {
      type: number
      value_format_name: id
      sql: ${TABLE}.QUESTIONID ;;
    }

    dimension: sectionslessonsid {
      type: number
      value_format_name: id
      sql: ${TABLE}.SECTIONSLESSONSID ;;
    }

    dimension_group: updatedat {
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
      sql: ${TABLE}.UPDATEDAT ;;
    }

    dimension: userid {
      hidden: yes
      type: number
      value_format_name: id
      sql: ${TABLE}.USERID ;;
    }

    measure: user_count {
      label: "# Users"
      type: count_distinct
      sql: ${userid} ;;
    }

    measure: count {
      type: count
      drill_fields: [all*]
    }
  }
