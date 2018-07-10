view: questions {
  label: "Question Text"
  sql_table_name: WA_APP_V4NET.QUESTIONS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._FIVETRAN_DELETED ;;
  }

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: answer {
    type: string
    sql: ${TABLE}.ANSWER ;;
  }

  dimension: author {
    type: number
    sql: ${TABLE}.AUTHOR ;;
  }

  dimension: chapter {
    type: string
    sql: ${TABLE}.CHAPTER ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.CODE ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.COMMENT ;;
  }

  dimension: keywords {
    type: string
    sql: ${TABLE}.KEYWORDS ;;
  }

  dimension: level {
    type: string
    sql: ${TABLE}.LEVEL ;;
  }

  dimension: locked {
    type: string
    sql: ${TABLE}.LOCKED ;;
  }

  dimension: mode {
    type: string
    sql: ${TABLE}.MODE ;;
  }

  dimension: permissions {
    type: string
    sql: ${TABLE}.PERMISSIONS ;;
  }

  dimension: question {
    type: string
    sql: ${TABLE}.QUESTION ;;
  }

  dimension: solution {
    type: string
    sql: ${TABLE}.SOLUTION ;;
  }

  dimension: textbook {
    type: number
    sql: ${TABLE}.TEXTBOOK ;;
  }

  dimension: useable {
    type: string
    sql: ${TABLE}.USEABLE ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
