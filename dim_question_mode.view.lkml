view: dim_question_mode {
  label: "Question Mode"
  sql_table_name: FT_OLAP_REGISTRATION_REPORTS.DIM_QUESTION_MODE ;;

  dimension: dim_question_mode_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DIM_QUESTION_MODE_ID ;;
    hidden: yes
  }

  dimension: hashcode {
    type: number
    sql: ${TABLE}.HASHCODE ;;
    hidden: yes
  }

  dimension: is_algebraic {
    type: yesno
    sql: ${TABLE}.IS_ALGEBRAIC = 'Y' ;;
  }

  dimension: is_essay {
    type: yesno
    sql: ${TABLE}.IS_ESSAY = 'Y';;
  }

  dimension: is_file_upload {
    type: yesno
    sql: ${TABLE}.IS_FILE_UPLOAD = 'Y' ;;
  }

  dimension: is_fill_in_the_blank {
    type: yesno
    sql: ${TABLE}.IS_FILL_IN_THE_BLANK = 'Y';;
  }

  dimension: is_graphing {
    type: yesno
    sql: ${TABLE}.IS_GRAPHING = 'Y' ;;
  }

  dimension: is_image_map {
    type: yesno
    sql: ${TABLE}.IS_IMAGE_MAP = 'Y' ;;
  }

  dimension: is_java {
    type: yesno
    sql: ${TABLE}.IS_JAVA = 'Y';;
  }

  dimension: is_matching {
    type: yesno
    sql: ${TABLE}.IS_MATCHING = 'Y';;
  }

  dimension: is_multiple_choice {
    type: yesno
    sql: ${TABLE}.IS_MULTIPLE_CHOICE = 'Y';;
  }

  dimension: is_multiple_select {
    type: yesno
    sql: ${TABLE}.IS_MULTIPLE_SELECT 'Y' ;;
  }

  dimension: is_number_line {
    type: yesno
    sql: ${TABLE}.IS_NUMBER_LINE = 'Y';;
  }

  dimension: is_numerical {
    type: yesno
    sql: ${TABLE}.IS_NUMERICAL = 'Y';;
  }

  dimension: is_pencil_pad {
    type: yesno
    sql: ${TABLE}.IS_PENCIL_PAD = 'Y';;
  }

  dimension: is_poll {
    type: yesno
    sql: ${TABLE}.IS_POLL = 'Y';;
  }

  dimension: is_symbolic {
    type: yesno
    sql: ${TABLE}.IS_SYMBOLIC = 'Y';;
  }

  measure: count {
    type: count
    drill_fields: [dim_question_mode_id, dim_question.count]
  }
}
