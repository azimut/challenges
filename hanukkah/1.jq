#!/usr/bin/jq -Mrf

def formatName: .name  | split(" ") | nth(1) | ascii_downcase ;
def formatPhone: .phone | gsub("-";"") ;
def letter2number:
  . as $letter |
  {
    "abc": "2",  "def": "3", "ghi": "4",  "jkl": "5",
    "mno": "6", "pqrs": "7", "tuv": "8", "wxyz": "9",
  }
  | to_entries[]
  | select(.key | contains([$letter]|implode))
  | .value;

def person2number:
  formatName
  | explode
  | map(letter2number)
  | join("");

select(person2number == formatPhone)
      .phone
