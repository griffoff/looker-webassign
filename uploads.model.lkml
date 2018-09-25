#connection: "snowflake_webassign"

#include: "*.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project
include: "webassign.dims.model.lkml"
include: "UPLOADS.*.view.lkml"
include: "dim_question_temp.view.lkml"
include: "responses.view.lkml"
#include: "dim_section.view.lkml"
#include: "responses.view.lkml"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
  explore: uploads_combined {

join: dim_deployment {
  sql_on: ${uploads_combined.deployment_id} = ${dim_deployment.deployment_id};;
  relationship: many_to_one
}

join: dim_section {
  sql_on: ${dim_deployment.section_id} = ${dim_section.section_id};;
    relationship: many_to_one
}
}
