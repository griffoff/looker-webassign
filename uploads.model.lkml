connection: "snowflake_webassign"

#include: "*.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project
include: "UPLOADS.*.view.lkml"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
  explore: course_objectives {

}
