read_user_input() {
    local type=$1
    local output

    case $type in
    "password")
        read -s -p "Enter the $type: " output
        echo >&2
        ;;
    *)
        read -p "Enter the $type: " output
        ;;
    esac

    echo "$output"

}

function test_regex() {
    local items=$1
    local regex=$2

    for item in $items; do
        result=$(grep -P "$regex" <<<"$item")
        if [[ $result != "$item" ]]; then
            red=$(tput setaf 1)
            bold=$(tput bold)
            reset=$(tput sgr0)
            echo "${red}${bold}Failed!${reset} regex test '$regex' '${bold}${item}${reset}'"
        fi
    done
}
