view: roster_extended {
  extends: [roster]

  dimension: dropped {
    type: yesno
    sql:  ${dropdate_raw} < ${dim_section.ends_eastern_raw};;
  }
}
view: roster {
  sql_table_name: WA_APP_V4NET.ROSTER ;;

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
    sql: ${TABLE}.logged ;;
  }

  dimension_group: dropdate {
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
    sql: ${TABLE}.DROPDATE ;;
  }

  dimension: nickname {
    type: string
    sql: ${TABLE}.NICKNAME ;;
  }

  dimension_group: payment_synced {
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
    sql: ${TABLE}.PAYMENT_SYNCED ;;
  }

  dimension: section {
    type: number
    sql: ${TABLE}.SECTION ;;
  }

  dimension_group: synced_to_cengage {
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
    sql: ${TABLE}.SYNCED_TO_CENGAGE ;;
  }

  dimension: user {
    type: number
    sql: ${TABLE}."USER" ;;
    hidden: yes
  }

  measure: count {
    label: "# Roster"
    type: count
    drill_fields: [nickname]
  }
}
