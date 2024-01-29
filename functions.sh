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
    pass
}
