#!/bin/bash

# Author: Tommy Chen
# Created: 2024-02-04
# Description: This script contains functions for generating random characters, symbols, and numbers.
# Version: 1.0

# Generate a random alphabet character based on the specified case.
# Parameters:
#   $1: Case type - "upper" for uppercase, "lower" for lowercase
# Usage:
#   upper_char=$(generate_random_alphabet "upper")
#   lower_char=$(generate_random_alphabet "lower")
function generate_random_alphabet() {
    local case=$1
    local upper=({A..Z})
    local lower=({a..z})

    if [[ "$case" == "upper" ]]; then
        echo "${upper[((RANDOM % 26))]}"
    elif [[ "$case" == "lower" ]]; then
        echo "${lower[((RANDOM % 26))]}"
    fi
}

# Generate a random symbol from a predefined list.
# This function selects a symbol randomly from a list of symbols.
# Usage:
#   symbol=$(generate_random_symbol)
function generate_random_symbol() {
    local symbols=("#" "$" "^" "-" "_" "[" "]" "{" "}" "~" "\`" "|")
    echo "${symbols[((RANDOM % 12))]}"
}

# Generate a random number with logical progression, each digit is a random decimal digit.
# Parameters:
#   $1: Number of digits
# Usage:
#   result=$(generate_random_number 5)
function generate_random_number() {
    local type=$1
    local result

    for ((i = 0; i < type; i++)); do
        if [[ i -eq $((type - 1)) ]]; then
            ((result += (1 + RANDOM % 9) * 10 ** i))
            break
        fi
        ((result += (RANDOM % 10) * 10 ** i))
    done
    echo "$result"
}

# Generate a random unrealistic number with the specified number of digits.
# Parameters:
#   $1: Number of digits
# Usage:
#   result=$(generate_random_unrealistic_number 5)
function generate_random_unrealistic_number() {
    local num_digits=$1
    local result=""

    for ((i = 0; i < num_digits; i++)); do
        result+=$((RANDOM % 10))
    done
    echo "$result"
}

# Generate a shuffled version of the input string using the Fisher-Yates shuffle algorithm.
# Parameters:
#   $1: Input string to be shuffled
# Usage:
#   shuffled_string=$(shuffle "input_string")
function shuffle() {
    local input="$1"
    local length="${#input}"
    local shuffled="$input"
    local after=""

    local -a chars=()
    for ((i = 0; i < length; i++)); do
        chars+=("${input:i:1}")
    done

    while true; do
        # Fisher-Yates shuffle algorithm
        for ((i = length - 1; i > 0; i--)); do
            local j="$((RANDOM % (i + 1)))"
            local temp="${chars[i]}"
            chars[i]="${chars[j]}"
            chars[j]="$temp"
        done

        after=$(printf '%s' "${chars[@]}")

        if [[ "$after" != "$shuffled" ]]; then
            shuffled="$after"
            break
        fi
    done

    echo "$shuffled"
}

# Generate a password based on the provided options and password length.
# Parameters:
#   $1: String containing options ('u' for uppercase, 'l' for lowercase, 's' for symbol, 'n' for number)
#   $2: Length of the password
# Usage:
#   password=$(generate_password "options" 8)
function generate_password() {
    local options="$1"
    local password_length="$2"

    # Check if the password length is less than the number of options
    if [[ $password_length -lt ${#options} ]]; then
        echo "Password length is less than the number of options." >&2
        return 1
    fi

    # Check if the options contain invalid characters
    if [[ ! "${options}" =~ ^[ulsnr]+$ ]]; then
        echo "Invalid options: ${options}" >&2
        return 1
    fi

    local password=""

    # Generate the initial part of the password based on the options
    for ((i = 0; i < ${#options}; i++)); do
        case "${options:$i:1}" in
        u)
            password+=$(generate_random_alphabet "upper")
            ;;
        l)
            password+=$(generate_random_alphabet "lower")
            ;;
        s)
            password+=$(generate_random_symbol)
            ;;
        n)
            password+=$(generate_random_unrealistic_number "1")
            ;;
        esac
    done

    # Generate the remaining part of the password based on the options
    for ((i = 0; i < (password_length - ${#options}); i++)); do
        local option="${options:RANDOM%${#options}:1}"
        case "$option" in
        u)
            password+=$(generate_random_alphabet "upper")
            ;;
        l)
            password+=$(generate_random_alphabet "lower")
            ;;
        s)
            password+=$(generate_random_symbol)
            ;;
        n)
            password+=$(generate_random_unrealistic_number "1")
            ;;
        esac
    done

    echo "$password"
}

# Example usage:
# Generate a password with 8 characters containing at least one uppercase letter and one symbol
password=$(shuffle "$(generate_password "ulsn" 8)")
echo "Generated password: $password"
