view: dim_section {
  view_label: "Section"
  derived_table: {
    sql: select time.cdate,sec.* from
      FT_OLAP_REGISTRATION_REPORTS.DIM_SECTION  sec
      left join  FT_OLAP_REGISTRATION_REPORTS.DIM_TIME time
      on sec.dim_time_id_starts = time.dim_time_id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: roster_sum {
    label: "Possible Users"
    type: sum
    sql: ${TABLE}.ROSTER ;;
  }

  dimension: cdate {
    label: "Created Date"
    type: date
    sql: ${TABLE}.CDATE ;;
  }

  dimension: dim_section_id {
    type: number
    sql: ${TABLE}.DIM_SECTION_ID ;;
    hidden: yes
  }

  dimension: bill_institution_option {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_OPTION ;;
    hidden: yes
  }

  dimension: bill_institution_contact_email {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_CONTACT_EMAIL ;;
    hidden: yes
  }

  dimension: bill_institution_invoice_amount {
    type: number
    sql: ${TABLE}.BILL_INSTITUTION_INVOICE_AMOUNT ;;
    hidden: yes
  }

  dimension: year {
    type: string
    sql: ${TABLE}.YEAR ;;
    hidden: yes
  }

  dimension: created_eastern {
    type: string
    sql: ${TABLE}.CREATED_EASTERN ;;
    hidden: yes
  }

  dimension: _fivetran_deleted {
    type: string
    sql: ${TABLE}._FIVETRAN_DELETED ;;
    hidden: yes
  }

  dimension: dim_time_id_created {
    type: number
    sql: ${TABLE}.DIM_TIME_ID_CREATED ;;
    hidden: yes
  }

  dimension: bb_version {
    type: string
    sql: ${TABLE}.BB_VERSION ;;
    hidden: yes
  }

  dimension: billing {
    type: string
    sql: ${TABLE}.BILLING ;;
    hidden: yes
  }

  dimension: bill_institution_method {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_METHOD ;;
    hidden: yes
  }

  dimension: bill_institution_contact_name {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_CONTACT_NAME ;;
    hidden: yes
  }

  dimension: gb_configured {
    group_label: "Gradebook Details"
    type: string
    sql: ${TABLE}.GB_CONFIGURED ;;
  }

  dimension: section_instructor_username {
    group_label: "Section Instructor Details"
    type: string
    sql: ${TABLE}.SECTION_INSTRUCTOR_USERNAME ;;
  }

  dimension: dim_time_id_leeway {
    type: number
    sql: ${TABLE}.DIM_TIME_ID_LEEWAY ;;
    hidden: yes
  }

  dimension: leeway_eastern {
    type: string
    sql: ${TABLE}.LEEWAY_EASTERN ;;
    hidden: yes
  }

  dimension: meets {
    type: string
    sql: ${TABLE}.MEETS ;;
    hidden: yes
  }

  dimension: registrations {
    type: number
    sql: ${TABLE}.REGISTRATIONS ;;
  }

  dimension: dim_time_id_ends {
    type: number
    sql: ${TABLE}.DIM_TIME_ID_ENDS ;;
  }

  dimension: course_name {
    type: string
    sql: ${TABLE}.COURSE_NAME ;;
  }

  dimension: psp_mode {
    group_label: "psp"
    type: string
    sql: ${TABLE}.PSP_MODE ;;
  }

  dimension: date_to {
    type: string
    sql: ${TABLE}.DATE_TO ;;
    hidden: yes
  }

  dimension: course_instructor_id {
    group_label: "Course Instructor Details"
    type: number
    sql: ${TABLE}.COURSE_INSTRUCTOR_ID ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.VERSION ;;
  }

  dimension: course_instructor_name {
    group_label: "Course Instructor Details"
    type: string
    sql: ${TABLE}.COURSE_INSTRUCTOR_NAME ;;
  }

  dimension: bill_institution_comments {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_COMMENTS ;;
    hidden: yes
  }

  dimension: section_instructor_name {
    group_label: "Section Instructor Details"
    type: string
    sql: ${TABLE}.SECTION_INSTRUCTOR_NAME ;;
  }

  dimension: bill_institution_isbn {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_ISBN ;;
  }

  dimension: psp_students_attempting_test {
    group_label: "psp"
    type: number
    sql: ${TABLE}.PSP_STUDENTS_ATTEMPTING_TEST ;;
  }

  dimension: course_instructor_sf_id {
    group_label: "Course Instructor Details"
    type: string
    sql: ${TABLE}.COURSE_INSTRUCTOR_SF_ID ;;
  }

  dimension: bill_institution_invoice_date {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_INVOICE_DATE ;;
    hidden: yes
  }

  dimension: course_description {
    type: string
    sql: ${TABLE}.COURSE_DESCRIPTION ;;
  }

  dimension: date_from {
    type: string
    sql: ${TABLE}.DATE_FROM ;;
    hidden: yes
  }

  dimension: trashed {
    type: string
    sql: ${TABLE}.TRASHED ;;
    hidden: yes
  }

  dimension: ends_eastern {
    type: date
    sql: ${TABLE}.ENDS_EASTERN ;;
  }

  dimension: bill_institution_contact_phone {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_CONTACT_PHONE ;;
    hidden: yes
  }

  dimension: section_instructor_sf_id {
    group_label: "Section Instructor Details"
    type: string
    sql: ${TABLE}.SECTION_INSTRUCTOR_SF_ID ;;
    hidden: yes
  }

  dimension: dim_time_id_starts {
    type: number
    sql: ${TABLE}.DIM_TIME_ID_STARTS ;;
  }

  dimension: roster {
    type: number
    sql: ${TABLE}.ROSTER ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
    hidden: yes
  }

  dimension: bill_institution_invoice_number {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_INVOICE_NUMBER ;;
    hidden: yes
  }

  dimension: school_id {
    type: number
    sql: ${TABLE}.SCHOOL_ID ;;
  }

  dimension: section_id {
    type: number
    sql: ${TABLE}.SECTION_ID ;;
    primary_key: yes
  }

  dimension: bill_institution_po_num {
    type: string
    sql: ${TABLE}.BILL_INSTITUTION_PO_NUM ;;
    hidden: yes
  }

  dimension: psp_enabled {
    group_label: "psp"
    type: string
    sql: ${TABLE}.PSP_ENABLED ;;
  }

  dimension: dim_textbook_id {
    type: number
    sql: ${TABLE}.DIM_TEXTBOOK_ID ;;
  }

  dimension: term {
    type: string
    sql: ${TABLE}.TERM ;;
  }

  dimension: using_open_resources {
    type: string
    sql: ${TABLE}.USING_OPEN_RESOURCES ;;
    hidden: yes
  }

  dimension: course_id {
    type: number
    sql: ${TABLE}.COURSE_ID ;;
  }

  dimension: granted_ebook {
    type: string
    sql: ${TABLE}.GRANTED_EBOOK ;;
  }

  dimension: dim_discipline_id {
    type: number
    sql: ${TABLE}.DIM_DISCIPLINE_ID ;;
    hidden: yes
  }

  dimension: section_name {
    type: string
    sql: ${TABLE}.SECTION_NAME ;;
  }

  dimension: section_instructor_email {
    group_label: "Section Instructor Details"
    type: string
    sql: ${TABLE}.SECTION_INSTRUCTOR_EMAIL ;;
  }

  dimension: has_invoice {
    type: string
    sql: ${TABLE}.HAS_INVOICE ;;
  }

  dimension: class_key {
    type: string
    sql: ${TABLE}.CLASS_KEY ;;
  }

  dimension: course_instructor_email {
    group_label: "Course Instructor Details"
    type: string
    sql: ${TABLE}.COURSE_INSTRUCTOR_EMAIL ;;
  }

  dimension: term_description {
    type: string
    sql: ${TABLE}.TERM_DESCRIPTION ;;
  }

  dimension: course_instructor_username {
    group_label: "Course Instructor Details"
    type: string
    sql: ${TABLE}.COURSE_INSTRUCTOR_USERNAME ;;
  }

  dimension: psp_students_attempting_quiz {
    group_label: "psp"
    type: number
    sql: ${TABLE}.PSP_STUDENTS_ATTEMPTING_QUIZ ;;
  }

  dimension: deployments {
    type: number
    sql: ${TABLE}.DEPLOYMENTS ;;
  }

  dimension: starts_eastern {
    type: date
    sql: ${TABLE}.STARTS_EASTERN ;;
  }

  dimension: section_instructor_id {
    group_label: "Section Instructor Details"
    type: number
    sql: ${TABLE}.SECTION_INSTRUCTOR_ID ;;
  }

  dimension: gb_has_data {
    group_label: "Gradebook Details"
    type: string
    sql: ${TABLE}.GB_HAS_DATA ;;
  }

  set: detail {
    fields: [
      cdate,
      dim_section_id,
      bill_institution_option,
      bill_institution_contact_email,
      bill_institution_invoice_amount,
      year,
      created_eastern,
#       _fivetran_deleted,
      dim_time_id_created,
      bb_version,
      billing,
      bill_institution_method,
      bill_institution_contact_name,
      gb_configured,
      section_instructor_username,
      dim_time_id_leeway,
      leeway_eastern,
      meets,
      registrations,
      dim_time_id_ends,
      course_name,
      psp_mode,
      date_to,
      course_instructor_id,
      version,
      course_instructor_name,
      bill_institution_comments,
      section_instructor_name,
      bill_institution_isbn,
      psp_students_attempting_test,
      course_instructor_sf_id,
      bill_institution_invoice_date,
      course_description,
      date_from,
      trashed,
      ends_eastern,
      bill_institution_contact_phone,
      section_instructor_sf_id,
      dim_time_id_starts,
      roster,
#       _fivetran_synced,
      bill_institution_invoice_number,
      school_id,
      section_id,
      bill_institution_po_num,
      psp_enabled,
      dim_textbook_id,
      term,
      using_open_resources,
      course_id,
      granted_ebook,
      dim_discipline_id,
      section_name,
      section_instructor_email,
      has_invoice,
      class_key,
      course_instructor_email,
      term_description,
      course_instructor_username,
      psp_students_attempting_quiz,
      deployments,
      starts_eastern,
      section_instructor_id,
      gb_has_data
    ]
  }
}
