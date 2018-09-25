view: uploads_combined {
#   # Or, you could make this view a derived table, like this:
  derived_table: {
      sql:
      SELECT
        e.course_obj,
        e.unit_obj,
        e.learning_obj,
        e.Title as title,
        e.question_code AS question_code,
        e.dim_question_id AS dim_question_id,
        r.*
        FROM
        (
        SELECT
          d.course_obj,
          d.unit_obj,
          d.learning_obj,
          d.Title as title,
          q.question_code AS question_code,
          q.question_id AS dim_question_id
            FROM
            (SELECT
            b.course_obj,
            b.unit_obj,
            b.learning_obj,
            aa.Title as title
              FROM
              (SELECT
              a.course_obj,
              a.unit_obj,
              l.ordinal as learning_obj
                FROM
                (SELECT
                c.ordinal AS course_obj,
                u.ordinal AS unit_obj
                  FROM uploads.lo_metadata.course_objectives c
                  JOIN uploads.lo_metadata.units_objectives u
                  ON c.ordinal = u.parent_ordinal) a
                  JOIN uploads.lo_metadata.learning_objectives l
                  ON a.unit_obj = l.parent_objective) b
                  JOIN uploads.lo_metadata.assessment_assets aa
                  ON b.learning_obj = aa.lo_1) d
                  JOIN webassign.ft_olap_registration_reports.dim_question q
                  ON d.title = q.question_code
                  ) e
                  JOIN ${responses.SQL_TABLE_NAME} r
                  --JOIN webassign.wa_app_activity.responses AS r
                  ON e.dim_question_id = r.question_id
            ;;
            }



dimension: course_obj {}

dimension: unit_obj {}

dimension: learning_obj {}

dimension: title  {}

dimension: question_code {}

dimension: question_id {}

dimension: correct {}

dimension: deployment_id {}

measure: question_count {
  label: "question count"
  type:  count_distinct
  sql: ${question_id} ;;
}

#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
}
