connection: "snowflake_webassign"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: dim_textbook {
  extension: required
  join: dim_discipline {
    sql_on: ${dim_textbook.dim_discipline_id} = ${dim_discipline.dim_discipline_id} ;;
    relationship: many_to_one
  }
}

# explore: dim_faculty {
#   extension: required
#   join: dim_school {
#     sql_on: ${dim_faculty.dim_school_id}=${dim_school.school_id} ;;
#     relationship: many_to_one
#   }
# }
