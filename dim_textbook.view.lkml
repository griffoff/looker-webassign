view: dim_textbook {
  label: "Textbook"
  sql_table_name: FT_OLAP_REGISTRATION_REPORTS.DIM_TEXTBOOK ;;

  dimension: dim_textbook_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DIM_TEXTBOOK_ID ;;
    hidden: yes
  }

  dimension: author {
    type: string
    sql: ${TABLE}.AUTHOR ;;
  }

  dimension: available {
    description: "These designations control the availability of the textbook in WebAssign and visibility on the info site. Possible values are: New, Coming Soon, Available, Old Edition, Hidden, Canceled"
    type: string
    sql: ${TABLE}.AVAILABLE ;;
  }

  dimension: code {
    label: "Product Code"
    description: "The WebAssign equivalent to Product Family Code. Unique code by product and edition"
    type: string
    sql: ${TABLE}.CODE ;;
  }

  dimension: content_id {
    type: number
    sql: ${TABLE}.CONTENT_ID ;;
  }

  dimension: copyright_publisher {
    description: "copyright year"
    type: string
    sql: ${TABLE}.COPYRIGHT_PUBLISHER ;;
  }

  dimension: copyright_wa {
    type: string
    sql: ${TABLE}.COPYRIGHT_WA ;;
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

  dimension: dim_discipline_id {
    type: number
    sql: ${TABLE}.DIM_DISCIPLINE_ID ;;
    hidden: yes
  }

  dimension: edition {
    type: string
    sql: ${TABLE}.EDITION ;;
  }

  dimension: has_ebook {
    type: yesno
    sql: ${TABLE}.HAS_EBOOK ;;
  }

  dimension: has_practice_it {
    type: yesno
    sql: ${TABLE}.HAS_PRACTICE_IT ;;
  }

  dimension: has_psp {
    type: yesno
    sql: ${TABLE}.HAS_PSP ;;
  }

  dimension: has_read_it {
    type: yesno
    sql: ${TABLE}.HAS_READ_IT ;;
  }

  dimension: has_watch_it {
    type: yesno
    sql: ${TABLE}.HAS_WATCH_IT ;;
  }

  dimension: is_labs {
    type: yesno
    sql: ${TABLE}.IS_LABS ;;
  }

  dimension: is_original_content {
    type: yesno
    sql: ${TABLE}.IS_ORIGINAL_CONTENT ;;
  }

  dimension: is_publisher_textbook {
    type: yesno
    sql: ${TABLE}.IS_PUBLISHER_TEXTBOOK ;;
  }

  dimension: loe {
    type: string
    sql: ${TABLE}.LOE ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: permission {
    description: "Textbook Permission: Restricted or Open. Copyrighted textbooks are typically designated as Restricted. Open textbooks can be used in a class without incurring additional fees. "
    type: string
    sql: ${TABLE}.PERMISSION ;;
  }

  dimension: price_category {
    description: "The price category of the textbook at the time of purchase. Also known as the 'Content Subtype'"
    type: string
    sql: ${TABLE}.PRICE_CATEGORY ;;
  }

  dimension: price_category_desc {
    type: string
    sql: ${TABLE}.PRICE_CATEGORY_DESC ;;
  }

  dimension: publisher_code {
    type: string
    sql: ${TABLE}.PUBLISHER_CODE ;;
  }

  dimension: publisher_id {
    type: number
    sql: ${TABLE}.PUBLISHER_ID ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.PUBLISHER_NAME ;;
  }

  dimension: reporting_isbn {
    type: string
    sql: ${TABLE}.REPORTING_ISBN ;;
  }

  dimension: sf_product_id {
    type: string
    sql: ${TABLE}.SF_PRODUCT_ID ;;
  }

  dimension: short {
    type: string
    sql: ${TABLE}.SHORT ;;
  }

  dimension: textbookid {
    label: "Textbook ID"
    type: number
    value_format_name: id
    sql: ${TABLE}.TEXTBOOK_ID ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.VERSION ;;
  }

  measure: count {
    label: "# Textbooks"
    type: count
    drill_fields: [dim_textbook_id, name, publisher_name, dim_question.count]
  }
}
