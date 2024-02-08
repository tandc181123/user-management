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
function random_alphabet() {
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
function random_symbol() {
    local symbols=("#" "$" "^" "-" "_" "[" "]" "{" "}" "~" "\`" "|")
    echo "${symbols[((RANDOM % 12))]}"
}

# Generate a random number with logical progression, each digit is a random decimal digit.
# Parameters:
#   $1: Number of digits
# Usage:
#   result=$(generate_number 5)
function number() {
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
#   result=$(generate_unrealistic_number 5)
function unrealistic_number() {
    local num_digits=$1
    local result=""

    for ((i = 0; i < num_digits; i++)); do
        result+=$((RANDOM % 10))
    done
    echo "$result"
}

function selector() {
    declare -a array
    while getopts "ulsnr" opt; do
        case $opt in
        u)
            array+=("$(random_alphabet "upper")")
            ;;
        l)
            array+=("$(random_alphabet "lower")")
            ;;
        s)
            array+=("$(random_symbol)")
            ;;
        n)
            array+=("$(unrealistic_number "1")")
            ;;
        r)
            echo "Before: " "${array[@]}"
            declare -a shuffled=("${array[@]}")
            local length=${#shuffled[@]}
            local i=0
            while true; do
                # Fisher-Yates shuffle algorithm
                for ((i = length - 1; i > 0; i--)); do
                    local j="$((RANDOM % (i + 1)))"
                    local temp=${shuffled[i]}
                    shuffled[i]=${shuffled[j]}
                    shuffled[j]=$temp
                done

                if [[ "${shuffled[*]}" != "${array[*]}" ]]; then
                    break
                fi
            done
            echo "After: " "${shuffled[@]}"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
        esac
    done
}

function omg() {
    eval "local range=($1)"
    local random_length="${range[((RANDOM % ${#range[@]}))]}"
    local in_sequence="$2"

}

selector -sulr
