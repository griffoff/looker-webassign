view: questions_not_used {
  label: "Never Used Questions"
  derived_table: {
    sql: SelecT q.* from FT_OLAP_REGISTRATION_REPORTS.dim_question q
      left join wa_app_activity.responses r
      on q.question_ID = r.question_ID
      where r.id is null
       ;;
    sql_trigger_value: select count(*) from wa_app_activity.RESPONSES ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: dim_question_id {
    type: number
    sql: ${TABLE}.DIM_QUESTION_ID ;;
  }

  dimension: has_tutorial_popup {
    type: string
    sql: ${TABLE}.HAS_TUTORIAL_POPUP ;;
  }

  dimension: keywords {
    type: string
    sql: ${TABLE}.KEYWORDS ;;
  }

  dimension: qdiff_difficulty_index {
    type: number
    sql: ${TABLE}.QDIFF_DIFFICULTY_INDEX ;;
  }

  dimension: _fivetran_deleted {
    type: string
    sql: ${TABLE}._FIVETRAN_DELETED ;;
  }

  dimension: req_question_part_submission {
    type: string
    sql: ${TABLE}.REQ_QUESTION_PART_SUBMISSION ;;
  }

  dimension: is_webassign_author {
    type: string
    sql: ${TABLE}.IS_WEBASSIGN_AUTHOR ;;
  }

  dimension: has_watch_it {
    type: string
    sql: ${TABLE}.HAS_WATCH_IT ;;
  }

  dimension: permissions {
    type: string
    sql: ${TABLE}.PERMISSIONS ;;
  }

  dimension: is_trashed {
    type: string
    sql: ${TABLE}.IS_TRASHED ;;
  }

  dimension: qdiff_pct_correct_additional {
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ADDITIONAL ;;
  }

  dimension: qdiff_pct_correct_attempt_4 {
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_4 ;;
  }

  dimension: qdiff_pct_correct_attempt_5 {
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_5 ;;
  }

  dimension: qdiff_pct_correct_attempt_2 {
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_2 ;;
  }

  dimension: has_grading_statement {
    type: string
    sql: ${TABLE}.HAS_GRADING_STATEMENT ;;
  }

  dimension: qdiff_pct_correct_attempt_3 {
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_3 ;;
  }

  dimension: qdiff_pct_correct_attempt_1 {
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_1 ;;
  }

  dimension: dim_faculty_id_author {
    type: number
    sql: ${TABLE}.DIM_FACULTY_ID_AUTHOR ;;
  }

  dimension: has_read_it {
    type: string
    sql: ${TABLE}.HAS_READ_IT ;;
  }

  dimension: distinct_modes {
    type: string
    sql: ${TABLE}.DISTINCT_MODES ;;
  }

  dimension: level {
    type: string
    sql: ${TABLE}.LEVEL ;;
  }

  dimension: has_marvin {
    type: string
    sql: ${TABLE}.HAS_MARVIN ;;
  }

  dimension: question_code {
    type: string
    sql: ${TABLE}.QUESTION_CODE ;;
  }

  dimension: date_to {
    type: string
    sql: ${TABLE}.DATE_TO ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.VERSION ;;
  }

  dimension: dim_time_id_created_et {
    type: number
    sql: ${TABLE}.DIM_TIME_ID_CREATED_ET ;;
  }

  dimension: dim_question_mode_id {
    type: number
    sql: ${TABLE}.DIM_QUESTION_MODE_ID ;;
  }

  dimension: last_modified_et {
    type: string
    sql: ${TABLE}.LAST_MODIFIED_ET ;;
  }

  dimension: author_user_id {
    type: number
    sql: ${TABLE}.AUTHOR_USER_ID ;;
  }

  dimension: date_from {
    type: string
    sql: ${TABLE}.DATE_FROM ;;
  }

  dimension: chapter {
    type: string
    sql: ${TABLE}.CHAPTER ;;
  }

  dimension: has_feedback {
    type: string
    sql: ${TABLE}.HAS_FEEDBACK ;;
  }

  dimension: created_et {
    type: string
    sql: ${TABLE}.CREATED_ET ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.ORIGIN ;;
  }

  dimension: is_included_in_psp_quiz {
    type: string
    sql: ${TABLE}.IS_INCLUDED_IN_PSP_QUIZ ;;
  }

  dimension: taq_avg_time {
    type: number
    sql: ${TABLE}.TAQ_AVG_TIME ;;
  }

  dimension: num_boxes {
    type: number
    sql: ${TABLE}.NUM_BOXES ;;
  }

  dimension: question_mode {
    type: string
    sql: ${TABLE}.QUESTION_MODE ;;
  }

  dimension: has_practice_it {
    type: string
    sql: ${TABLE}.HAS_PRACTICE_IT ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: req_flash {
    type: string
    sql: ${TABLE}.REQ_FLASH ;;
  }

  dimension: has_image {
    type: string
    sql: ${TABLE}.HAS_IMAGE ;;
  }

  dimension: qdiff_num_attempts {
    type: number
    sql: ${TABLE}.QDIFF_NUM_ATTEMPTS ;;
  }

  dimension: dim_textbook_id {
    type: number
    sql: ${TABLE}.DIM_TEXTBOOK_ID ;;
  }

  dimension: has_tutorial {
    type: string
    sql: ${TABLE}.HAS_TUTORIAL ;;
  }

  dimension: taq_med_time {
    type: number
    sql: ${TABLE}.TAQ_MED_TIME ;;
  }

  dimension: has_solution {
    type: string
    sql: ${TABLE}.HAS_SOLUTION ;;
  }

  dimension: is_randomized {
    type: string
    sql: ${TABLE}.IS_RANDOMIZED ;;
  }

  dimension: has_pad {
    type: string
    sql: ${TABLE}.HAS_PAD ;;
  }

  dimension: has_master_it {
    type: string
    sql: ${TABLE}.HAS_MASTER_IT ;;
  }

  dimension: has_standalone_master_it {
    type: string
    sql: ${TABLE}.HAS_STANDALONE_MASTER_IT ;;
  }

  dimension: dim_question_group_key_id {
    type: number
    sql: ${TABLE}.DIM_QUESTION_GROUP_KEY_ID ;;
  }

  dimension: is_useable {
    type: string
    sql: ${TABLE}.IS_USEABLE ;;
  }

  dimension: question_id {
    type: number
    sql: ${TABLE}.QUESTION_ID ;;
  }

  dimension: is_locked_scheduled {
    type: string
    sql: ${TABLE}.IS_LOCKED_SCHEDULED ;;
  }

  dimension: dim_time_id_last_modified_et {
    type: number
    sql: ${TABLE}.DIM_TIME_ID_LAST_MODIFIED_ET ;;
  }

  dimension: taq_num_students {
    type: number
    sql: ${TABLE}.TAQ_NUM_STUDENTS ;;
  }

  dimension: textbook_id {
    type: number
    sql: ${TABLE}.TEXTBOOK_ID ;;
  }

  dimension: req_java {
    type: string
    sql: ${TABLE}.REQ_JAVA ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.COMMENT ;;
  }

  dimension: has_ebook_section {
    type: string
    sql: ${TABLE}.HAS_EBOOK_SECTION ;;
  }

  set: detail {
    fields: [
      dim_question_id,
      has_tutorial_popup,
      keywords,
      qdiff_difficulty_index,
      _fivetran_deleted,
      req_question_part_submission,
      is_webassign_author,
      has_watch_it,
      permissions,
      is_trashed,
      qdiff_pct_correct_additional,
      qdiff_pct_correct_attempt_4,
      qdiff_pct_correct_attempt_5,
      qdiff_pct_correct_attempt_2,
      has_grading_statement,
      qdiff_pct_correct_attempt_3,
      qdiff_pct_correct_attempt_1,
      dim_faculty_id_author,
      has_read_it,
      distinct_modes,
      level,
      has_marvin,
      question_code,
      date_to,
      version,
      dim_time_id_created_et,
      dim_question_mode_id,
      last_modified_et,
      author_user_id,
      date_from,
      chapter,
      has_feedback,
      created_et,
      origin,
      is_included_in_psp_quiz,
      taq_avg_time,
      num_boxes,
      question_mode,
      has_practice_it,
      _fivetran_synced,
      req_flash,
      has_image,
      qdiff_num_attempts,
      dim_textbook_id,
      has_tutorial,
      taq_med_time,
      has_solution,
      is_randomized,
      has_pad,
      has_master_it,
      has_standalone_master_it,
      dim_question_group_key_id,
      is_useable,
      question_id,
      is_locked_scheduled,
      dim_time_id_last_modified_et,
      taq_num_students,
      textbook_id,
      req_java,
      comment,
      has_ebook_section
    ]
  }
}
