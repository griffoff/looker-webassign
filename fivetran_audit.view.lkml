include: "/core/fivetran.view.lkml"
view: fivetran_audit {
  extends: [fivetran_audit_base]

  derived_table: {
    sql:
        select ID,MESSAGE,UPDATE_STARTED,UPDATE_ID,fivetran_audit.SCHEMA,DONE,ROWS_UPDATED_OR_INSERTED,fivetran_audit.STATUS,PROGRESS
        from ft_olap_registration_reports.fivetran_audit
        union all
        select ID,MESSAGE,UPDATE_STARTED,UPDATE_ID,fivetran_audit.SCHEMA,DONE,ROWS_UPDATED_OR_INSERTED,fivetran_audit.STATUS,PROGRESS
        from ft_olap_etl_staging.fivetran_audit
        union all
        select ID,MESSAGE,UPDATE_STARTED,UPDATE_ID,fivetran_audit.SCHEMA,DONE,ROWS_UPDATED_OR_INSERTED,fivetran_audit.STATUS,PROGRESS
        from wa_app_activity.fivetran_audit
        union all
        select ID,MESSAGE,UPDATE_STARTED,UPDATE_ID,fivetran_audit.SCHEMA,DONE,ROWS_UPDATED_OR_INSERTED,fivetran_audit.STATUS,PROGRESS
        from wa_app_v4net.fivetran_audit
      ;;
  }

}


# webassign.ft_olap_registration_reports.fivetran_audit
#
# webassign.ft_olap_etl_staging.fivetran_audit
# webassign.wa_app_activity
# webassign.wa_app_v4net.fivetran_audit
