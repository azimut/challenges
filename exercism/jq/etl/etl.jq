.legacy
  | with_entries(
        {
          key: .value[]|ascii_downcase,
          value: .key|tonumber,
        }
      )
