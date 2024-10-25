# Function to start extra command history logging
start_extra_history() {
    export EXTRA_HIST_START=$(history 1 | awk '{print $1}')  # Stores the starting point in history
    echo "Extra history started."
}

# Function to stop extra command history logging and save the session commands
stop_extra_history() {
    local target_file=$1

    # If no target file is specified, prompt the user for a filename
    if [ -z "$target_file" ]; then
        read -p "Please enter the full path for saving the history: " target_file
    fi

    # Expands the ~ to the full home directory path if used in the target path
    target_file="${target_file/#\~/$HOME}"

    if [ -n "$target_file" ]; then
        local current_end=$(history 1 | awk '{print $1}')  # Stores the current end point in history

        # Extracts only commands between the start and end points and saves them to the specified file
        history | awk -v start="$EXTRA_HIST_START" -v end="$current_end" '$1 > start && $1 <= end' > "$target_file"

        echo "History saved to $target_file."
    else
        echo "No valid filename provided. History was not saved."
    fi

    # Unsets the start marker to allow for a new session next time
    unset EXTRA_HIST_START
    echo "Extra history stopped."
}
