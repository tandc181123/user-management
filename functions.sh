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

validate_user_input() {
    local data=$1
    local regex=$2

    echo "regex: $regex"

    if grep -Pq "$regex" <<<"$data"; then
        echo 0
    else
        echo 1
    fi

}
