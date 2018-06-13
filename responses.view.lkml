view: responses {
  #sql_table_name: WA2ANALYTICS.RESPONSES ;;
  view_label: "Responses"
  derived_table: {
    sql:
      select
        to_date("CREATED_AT") as Submission_Date,*
      from wa_app_activity.responses
      where to_date("CREATED_AT") > '2016-01-01' ;;

sql_trigger_value: select count(*) from wa_app_activity.RESPONSES ;;
    }

    set: all {fields: [id, userid, dim_question.code, iscorrect]}

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.ID ;;
      hidden: yes
    }

#     dimension: reverse_attemptnumber {
#       label: "Reverse Attempt Number"
#     }

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
      hidden: yes

    }

    dimension: iscorrect {
      label: "Is Correct"
      type: number
      sql: ${TABLE}.IS_CORRECT ;;
    }

    measure: numberwrong {
      label: "# Wrong"
      type: sum
#       sql:SELECT COUNT(*) FROM ${responses.SQL_TABLE_NAME}
#       WHERE ${TABLE}.IS_CORRECT = 0 ;;
    sql: CASE WHEN ${iscorrect} = 0 THEN 1 END ;;
    }

    measure: numbercorrect {
      label: "# Correct"
      type: sum
      sql: ${TABLE}.IS_CORRECT;;
      drill_fields: [dim_question.question_id,iscorrect,attemptnumber]
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

#     dimension: is_last_attempt {
#       type: yesno
#       sql: ${reverse_attemptnumber} = 1 ;;
#     }

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
      label: "Submission"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year,
        fiscal_year
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

    measure: scores {
      label: "Scores"
      type: sum
      sql: ${TABLE}.POINTS_SCORED;;
    }

    measure: count {
      type: count
      drill_fields: [all*]
    }
  }
