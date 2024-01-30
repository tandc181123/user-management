#!/bin/bash

script_dir=$(dirname "${BASH_SOURCE[0]}")
. "$script_dir/../functions.sh"
. "$script_dir/../regex_patterns.sh"

function provider_length_valid_data() {
  local items=("Aa!12345" "Aa!123456" "Aa!1234567" "Aa!12345678" "Aa!123456789")
  echo "${items[@]}"
}

# data_provider provider_length_valid_data
function test_data_length_validation() {
  local item=$1
  result=$(validate_user_input "$item" "$password_regex")
  assert_equals "0" "$result"
}

function provider_length_invalid_data() {
  local items=("" "Ab!1" "Ab!12" "Ab!123" "Ab!1234" "Aa!1234567891" "Aa!12345678912")
  echo "${items[@]}"
}

# data_provider provider_length_invalid_data
function test_data_length_invalidation() {
  local item=$1
  result=$(validate_user_input "$item" "$password_regex")
  assert_equals "1" "$result"
}
