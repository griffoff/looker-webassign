view: fact_registration {
  view_label: "Registrations (Activations)"
  sql_table_name: FT_OLAP_REGISTRATION_REPORTS.FACT_REGISTRATION ;;

  dimension: fact_registration_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.FACT_REGISTRATION_ID ;;
  }

  dimension: registration_count {
    type: number
    sql: ${TABLE}.COUNT ;;
  }

  dimension: course_id {
    type: number
    sql: ${TABLE}.COURSE_ID ;;
  }

  dimension: course_instructor_id {
    type: number
    sql: ${TABLE}.COURSE_INSTRUCTOR_ID ;;
  }

  dimension: dim_axscode_id {
    type: number
    sql: ${TABLE}.DIM_AXSCODE_ID ;;
  }

  dimension: dim_payment_method_id {
    description: "How the student gained access. Payment method regardless if a revenue type (access code, multi-term, etc.) or a no revenue type (free trial, LOE Reuse)."
    type: number
    sql: ${TABLE}.DIM_PAYMENT_METHOD_ID ;;
  }

  dimension: dim_school_id {
    type: number
    sql: ${TABLE}.DIM_SCHOOL_ID ;;
    hidden: yes
  }

  dimension: dim_section_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.DIM_SECTION_ID ;;
    hidden: yes
  }

  dimension: dim_textbook_id {
    type: number
    sql: ${TABLE}.DIM_TEXTBOOK_ID ;;
    hidden: yes
  }

  dimension: dim_time_id {
    type: number
    sql: ${TABLE}.DIM_TIME_ID ;;
  }

  dimension: event_type {
    description: "To denote if measures from sales are for purchase or refund"
    type: string
    sql: ${TABLE}.EVENT_TYPE ;;
  }

  dimension: purchase_type {
    description: "'Upgrade' for eBook upgrades, 'Registration' for purchases that gave access to a section, 'Fee' for extra fees the student was forced to pay (the result of a bug)"
    type: string
    sql: ${TABLE}.PURCHASE_TYPE ;;
  }

  dimension: redemption_model {
    type: yesno
    sql: ${TABLE}.REDEMPTION_MODEL ;;
  }

  dimension: registrations {
    description: "Registrations = # of student activations. Roster = # students enrolled in a course"
    type: number
    sql: ${TABLE}.REGISTRATIONS ;;
  }

  dimension: school_id {
    type: number
    sql: ${TABLE}.SCHOOL_ID ;;
  }

  dimension: section_id {
    type: number
    sql: ${TABLE}.SECTION_ID ;;
  }

  dimension: section_instructor_id {
    type: number
    sql: ${TABLE}.SECTION_INSTRUCTOR_ID ;;
  }

  dimension: sso_guid {
    type: string
    sql: ${TABLE}.SSO_GUID ;;
  }

  dimension: token_id {
    type: number
    sql: ${TABLE}.TOKEN_ID ;;
  }

  dimension: upgrades {
    description: "The number of eBook upgrades"
    type: number
    sql: ${TABLE}.UPGRADES ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.USERNAME ;;
  }

  measure: user_registrations {
    label: "Number of Registrations (activations)"
    description: "Total Activations"
    type: sum
    sql: ${registrations} ;;

    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      fact_registration_id,
      username,
      dim_section.dim_section_id,
      dim_section.course_name,
      dim_section.course_instructor_name,
      dim_section.course_instructor_username,
      dim_section.section_name,
      dim_section.section_instructor_name,
      dim_section.section_instructor_username,
      dim_section.bill_institution_contact_name
    ]
  }
}
