#!/bin/bash

script_dir=$(dirname "${BASH_SOURCE[0]}")
. "$script_dir/../functions.sh"
. "$script_dir/../regex_patterns.sh"

function test_validate_user_input() {
  result=$(validate_user_input "abc" "$password_regex")
  assert_equals "1" "$result"
}