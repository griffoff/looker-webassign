view: topics {
  sql_table_name: LO_METADATA.TOPICS ;;

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
  }

  dimension_group: _fivetran_synced {
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
    sql: ${TABLE}."_FIVETRAN_SYNCED" ;;
  }

  dimension: _row {
    type: number
    sql: ${TABLE}."_ROW" ;;
  }

  dimension: chapter_num_ {
    type: number
    sql: ${TABLE}."CHAPTER_NUM_" ;;
  }

  dimension: chapter_title_from_book_ {
    type: string
    sql: ${TABLE}."CHAPTER_TITLE_FROM_BOOK_" ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}."COMMENT" ;;
  }

  dimension: general_or_stewart_specific_stewart_specific_often_means_not_unique_content_topics_it_s_applications_of_other_content_topics_ {
    type: string
    sql: ${TABLE}."GENERAL_OR_STEWART_SPECIFIC_STEWART_SPECIFIC_OFTEN_MEANS_NOT_UNIQUE_CONTENT_TOPICS_IT_S_APPLICATIONS_OF_OTHER_CONTENT_TOPICS_" ;;
  }

  dimension: section {
    type: number
    sql: ${TABLE}."SECTION" ;;
  }

  dimension: section_text_ {
    type: string
    sql: ${TABLE}."SECTION_TEXT_" ;;
  }

  dimension: section_title_from_book_ {
    type: string
    sql: ${TABLE}."SECTION_TITLE_FROM_BOOK_" ;;
  }

  dimension: sub_topic_generalized_section_title_ {
    type: string
    sql: ${TABLE}."SUB_TOPIC_GENERALIZED_SECTION_TITLE_" ;;
  }

  dimension: topic_generalized_chapter_title_ {
    type: string
    sql: ${TABLE}."TOPIC_GENERALIZED_CHAPTER_TITLE_" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
