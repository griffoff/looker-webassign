view: dim_question {
  view_label: "Question"
  sql_table_name: WA2ANALYTICS.DIM_QUESTION ;;

  set: all {fields:[dim_question_id, dim_textbook.dim_textbook_id, dim_textbook.name, dim_textbook.publisher_name]}

  dimension: dim_question_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DIM_QUESTION_ID ;;
  }

  dimension: author_user_id {
    type: number
    sql: ${TABLE}.AUTHOR_USER_ID ;;
  }

#   dimension: is_webassign_author {
#     type:  yesno
#     sql: ${author_user_id} = 3162  ;;
#   }

  dimension: chapter {
    type: string
    sql: ${TABLE}.CHAPTER ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.COMMENT ;;
  }

  dimension_group: created_et {
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
    sql: ${TABLE}.CREATED_ET ;;
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

  dimension: dim_faculty_id_author {
    type: number
    value_format_name: id
    sql: ${TABLE}.DIM_FACULTY_ID_AUTHOR ;;
  }

  dimension: dim_question_group_key_id {
    type: number
    sql: ${TABLE}.DIM_QUESTION_GROUP_KEY_ID ;;
  }

  dimension: dim_question_mode_id {
    type: number
    sql: ${TABLE}.DIM_QUESTION_MODE_ID ;;
  }

  dimension: dim_textbook_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.DIM_TEXTBOOK_ID ;;
  }

  dimension: dim_time_id_created_et {
    type: number
    value_format_name: id
    sql: ${TABLE}.DIM_TIME_ID_CREATED_ET ;;
  }

  dimension: dim_time_id_last_modified_et {
    type: number
    value_format_name: id
    sql: ${TABLE}.DIM_TIME_ID_LAST_MODIFIED_ET ;;
  }

  dimension: distinct_modes {
    type: string
    sql: ${TABLE}.DISTINCT_MODES ;;
  }

  dimension: Features {
    group_label: "Question Attributes"
    type: string
    label: "Question feature list"
    case: {
      when: {
        sql: ${has_ebook_section} = 'Yes' ;;
        label: "Ebook"
      }
      when: {
        sql: ${has_feedback} = 'Yes' ;;
        label: "Feedback"
      }
    when: {
        sql: ${has_grading_statement} = 'Yes' ;;
        label: "Grading Statement"
      }
    when: {
        sql: ${has_image} = 'Yes' ;;
        label: "Image"
      }
    when: {
        sql: ${has_marvin} = 'Yes' ;;
        label: "Marvin"
      }
      when: {
        sql: ${has_master_it} = 'Yes' ;;
        label: "Master It"
      }
      when: {
        sql: ${has_pad} = 'Yes' ;;
        label: "Pad"
      }
      when: {
        sql: ${has_practice_it} = 'Yes' ;;
        label: "Practice"
      }
      when: {
        sql: ${has_read_it} = 'Yes' ;;
        label: "Read It"
      }
      when: {
        sql: ${has_solution} = 'Yes' ;;
        label: "Solution"
      }
      when: {
        sql: ${has_tutorial} = 'Yes' ;;
        label: "Tutorial"
      }
      when: {
        sql: ${has_tutorial_popup} = 'Yes' ;;
        label: "Tutorial Popup"
      }
      when: {
        sql: ${has_watch_it} = 'Yes' ;;
        label: "Watch It"
      }
    }
  }

  dimension: has_ebook_section {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_EBOOK_SECTION ;;
  }

  dimension: has_feedback {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_FEEDBACK ;;
  }

  dimension: has_grading_statement {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_GRADING_STATEMENT ;;
  }

  dimension: has_image {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_IMAGE ;;
  }

  dimension: has_marvin {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_MARVIN ;;
  }

  dimension: has_master_it {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_MASTER_IT ;;
  }

  dimension: has_pad {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_PAD ;;
  }

  dimension: has_practice_it {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_PRACTICE_IT ;;
  }

  dimension: has_read_it {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_READ_IT ;;
  }

  dimension: has_solution {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_SOLUTION ;;
  }

  dimension: has_standalone_master_it {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_STANDALONE_MASTER_IT ;;
  }

  dimension: has_tutorial {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_TUTORIAL ;;
  }

  dimension: has_tutorial_popup {
    group_label: "Question Attributes"
    description: "Has a Tutorial PopUp"
    type: yesno
    sql: ${TABLE}.HAS_TUTORIAL_POPUP ;;
  }

  dimension: has_watch_it {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.HAS_WATCH_IT ;;
  }

  dimension: is_included_in_psp_quiz {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.IS_INCLUDED_IN_PSP_QUIZ ;;
  }

  dimension: is_locked_scheduled {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.IS_LOCKED_SCHEDULED ;;
  }

  dimension: is_randomized {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.IS_RANDOMIZED ;;
  }

  dimension: is_trashed {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.IS_TRASHED ;;
  }

  dimension: is_useable {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.IS_USEABLE ;;
  }

  dimension: is_webassign_author {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.IS_WEBASSIGN_AUTHOR ;;
  }

  dimension: keywords {
    type: string
    sql: ${TABLE}.KEYWORDS ;;
  }

  dimension_group: last_modified_et {
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
    sql: ${TABLE}.LAST_MODIFIED_ET ;;
  }

  dimension: level {
    type: string
    sql: ${TABLE}.LEVEL ;;
  }

  dimension: num_boxes {
    type: number
    sql: ${TABLE}.NUM_BOXES ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.ORIGIN ;;
  }

  dimension: permissions {
    type: string
    sql: ${TABLE}.PERMISSIONS ;;
  }

  dimension: qdiff_difficulty_index {
    group_label: "Question Difficulty"
    type: number
    sql: ${TABLE}.QDIFF_DIFFICULTY_INDEX ;;
  }

  dimension: qdiff_num_attempts {
    group_label: "Question Difficulty"
    type: number
    sql: ${TABLE}.QDIFF_NUM_ATTEMPTS ;;
  }

  dimension: qdiff_pct_correct_additional {
    group_label: "Question Difficulty"
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ADDITIONAL ;;
  }

  dimension: qdiff_pct_correct_attempt_1 {
    group_label: "Question Difficulty"
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_1 ;;
  }

  dimension: qdiff_pct_correct_attempt_2 {
    group_label: "Question Difficulty"
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_2 ;;
  }

  dimension: qdiff_pct_correct_attempt_3 {
    group_label: "Question Difficulty"
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_3 ;;
  }

  dimension: qdiff_pct_correct_attempt_4 {
    group_label: "Question Difficulty"
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_4 ;;
  }

  dimension: qdiff_pct_correct_attempt_5 {
    group_label: "Question Difficulty"
    type: number
    sql: ${TABLE}.QDIFF_PCT_CORRECT_ATTEMPT_5 ;;
  }

  dimension: question_code {
    type: string
    sql: ${TABLE}.QUESTION_CODE ;;
  }

  dimension: question_mode {
    group_label: "Question Attributes"
    type: string
    sql: ${TABLE}.QUESTION_MODE;;
  }

  dimension: questionid {
    type: number
    value_format_name: id
    sql: ${TABLE}.QUESTIONID ;;
  }

  dimension: req_flash {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.REQ_FLASH ;;
  }

  dimension: req_java {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.REQ_JAVA ;;
  }

  dimension: req_question_part_submission {
    group_label: "Question Attributes"
    type: yesno
    sql: ${TABLE}.REQ_QUESTION_PART_SUBMISSION ;;
  }

  dimension: taq_avg_time_secs {
    hidden: yes
    type: number
    sql: ${TABLE}.TAQ_AVG_TIME;;
  }

  dimension: taq_avg_time {
    label: "Question Take Time (Avg.)"
    description: "The average time needed to answer a question. (TAQ) average time"
    type: number
    sql: ${taq_avg_time_secs} / 60 / 60 / 24;;
    value_format: "m \m\i\n s \s\e\c\s"
  }

  dimension: taq_med_time {
    label: "Question Take Time (Med.)"
    description: "The median time needed to answer a question. (TAQ) med time"
    type: number
    sql: ${TABLE}.TAQ_MED_TIME ;;
  }

  measure: taq_num_students {
    type: sum
    sql: ${TABLE}.TAQ_NUM_STUDENTS ;;
  }

  dimension: textbookid {
    type: number
    value_format_name: id
    sql: ${TABLE}.TEXTBOOKID ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.VERSION ;;
  }

  measure: count {
    type: count
    drill_fields: [all*]
  }
  measure: count_questions {
    type: count_distinct
    description: "# of questions"
    sql: ${dim_question_id} ;;
  }
}
