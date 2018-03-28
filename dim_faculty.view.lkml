view: dim_faculty {
  view_label: "Faculty"
  sql_table_name: FT_OLAP_REGISTRATION_REPORTS.DIM_FACULTY ;;

  dimension: dim_faculty_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DIM_FACULTY_ID ;;
    hidden: yes
  }

  dimension_group: created {
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
    sql: ${TABLE}.CREATED ;;
  }

  dimension_group: created_eastern {
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
    sql: ${TABLE}.CREATED_EASTERN ;;
  }

  dimension_group: date_from {
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
    sql: ${TABLE}.DATE_FROM ;;
  }

  dimension_group: date_to {
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
    sql: ${TABLE}.DATE_TO ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.DEPARTMENT ;;
  }

  dimension: dim_school_id {
    type: number
    sql: ${TABLE}.DIM_SCHOOL_ID ;;
    hidden: yes
  }

  dimension: dim_time_id_created {
    type: number
    value_format_name: id
    sql: ${TABLE}.DIM_TIME_ID_CREATED ;;
  }

  dimension: discipline {
    type: string
    sql: ${TABLE}.DISCIPLINE ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: faculty {
    description: "Whether or not this instructor has faculty privileges in the WebAssign application, i.e. yes or no. There are some teaching TAs in the system who will have the value 'no'"
    type: yesno
    sql: ${TABLE}.FACULTY ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: fullname {
    type: string
    sql: ${TABLE}.FULLNAME ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.LAST_NAME ;;
  }

  dimension: newsletter {
    type: string
    sql: ${TABLE}.NEWSLETTER ;;
  }

  dimension: participating {
    type: string
    sql: ${TABLE}.PARTICIPATING ;;
  }

  dimension: school_name {
    type: string
    sql: ${TABLE}.SCHOOL_NAME ;;
  }

  dimension: school_price_category_desc {
    type: string
    sql: ${TABLE}.SCHOOL_PRICE_CATEGORY_DESC ;;
  }

  dimension: school_type {
    description: "University, Community College, High School, Middle School, etc."
    type: string
    sql: ${TABLE}.SCHOOL_TYPE ;;
  }

  dimension: schoolid {
    type: number
    value_format_name: id
    sql: ${TABLE}.SCHOOL_ID ;;
  }

  dimension: sf_contact_id {
    type: string
    sql: ${TABLE}.SF_CONTACT_ID ;;
  }

  dimension: userid {
    type: number
    value_format_name: id
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.USERNAME ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.VERSION ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      dim_faculty_id,
      username,
      fullname,
      first_name,
      last_name,
      school_name
    ]
  }
}
