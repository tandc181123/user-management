#!/bin/bash

# sources
script_dir=$(dirname "${BASH_SOURCE[0]}")
. "$script_dir/../functions.sh"
. "$script_dir/../regex_patterns.sh"

# password_regex=^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^[:alnum:]_])$
# password-length limitation {8,12}

function provide_valid_length_passwords() {
  local items=("Aa!12345" "Aa!123456" "Aa!1234567" "Aa!12345678" "Aa!123456789")
  echo "${items[@]}"
}

# data_provider provide_valid_length_passwords
function test_valid_password_length() {
  local item=$1
  result=$(validate_user_input "$item" "$password_regex")
  assert_equals "0" "$result"
}

function provide_invalid_length_passwords() {
  local items=("" "Ab!1" "Ab!12" "Ab!123" "Ab!1234" "Aa!1234567891" "Aa!12345678912")
  echo "${items[@]}"
}

# data_provider provide_invalid_length_passwords
function test_invalid_password_length() {
  local item=$1
  result=$(validate_user_input "$item" "$password_regex")
  assert_equals "1" "$result"
}

# password-forbidden characters [^[:space:]\\\/\%\=\'\"\<\>\,\*\?]

function provide_passwords_with_forbidden_chars() {
  local items=("Ac!1234 " "Ac!1234\\" "Ac!1234/" "Ac!1234%" "Ac!1234=" "Ac!1234'" "Ac!1234\"" "Ac!1234<" "Ac!1234>" "Ac!1234," "Ac!1234*" "Ac!1234?")
  echo "${items[@]}"
}

# data_provider provide_passwords_with_forbidden_chars
function test_password_contains_forbiden_chars() {
  local item=$1
  result=$(validate_user_input "$item" "$password_regex")
  assert_equals "1" "$result"
}
