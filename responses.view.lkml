view: responses {
  #sql_table_name: WA2ANALYTICS.RESPONSES ;;
  view_label: "Responses"
  derived_table: {
    sql:
      select
        *
        ,row_number() over (partition by responses.USER_ID,responses.QUESTION_ID,responses.BOXNUM
                              order by responses.ATTEMPT_NUM desc) as reverse_attemptnumber
      from wa_app_activity.responses;;

persist_for: "20 hours"
#       sql_trigger_value: select count(*) from WA2ANALYTICS.RESPONSES ;;
    }

    set: all {fields: [id, userid, dim_question.code, iscorrect]}

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.ID ;;
    }

    dimension: reverse_attemptnumber {
      label: "Reverse Attempt Number"
    }

    dimension: attemptnumber {
      label: "Attempt Number"
      type: number
      sql: ${TABLE}.ATTEMPT_NUM ;;
    }

    dimension: boxnum {
      label: "Box Num"
      type: number
      sql: ${TABLE}.BOXNUM ;;
    }

    dimension_group: createdat {
      label: "Create"
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
      sql: ${TABLE}.CREATED_AT ;;
    }

    dimension: iscorrect {
      label: "Is Correct"
      type: number
      sql: ${TABLE}.IS_CORRECT ;;
    }

    measure: numbercorrect {
      label: "# Correct"
      type: sum
      sql: ${TABLE}.IS_CORRECT;;
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
      label: "Override Score"
      type: number
      sql: ${TABLE}.OVERRIDE_SCORE ;;
    }

    dimension: pointsscored {
      label: "Points Scored"
      type: number
      sql: ${TABLE}.POINTS_SCORED ;;
    }

    dimension: questionid {
      label: "Question ID"
      type: number
      value_format_name: id
      sql: ${TABLE}.QUESTION_ID ;;
    }

    dimension: deployment_id {
      label: "Deployment ID"
      type: number
      value_format_name: id
      sql: ${TABLE}.DEPLOYMENT_ID ;;
    }

    dimension_group: updatedat {
      label: "Update"
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
      sql: ${TABLE}.UPDATED_AT ;;
    }

    dimension: userid {
      label: "User ID"
      hidden: yes
      type: number
      value_format_name: id
      sql: ${TABLE}.USER_ID ;;
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
