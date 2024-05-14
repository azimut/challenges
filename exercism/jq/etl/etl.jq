.legacy
  | to_entries
  | map(.key as $key | .value
         | map({key: ascii_downcase,
                value: $key | tonumber}))
  | flatten
  | from_entries
