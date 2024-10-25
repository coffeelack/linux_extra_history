# linux_extra_history - Extra History Logging Script
Lets you start and stop a dedicated history recording into a specified file

This script allows you to log only a selected portion of your Bash history 
between a "start" and "stop" command, saving it to a separate file. 
This setup is helpful for keeping a clear log of specific command sessions 
without altering the main session history.

## Setup Instructions

1. **Add Functions to .bashrc**  
   Copy the following `start_extra_history` and `stop_extra_history` functions 
   into your `.bashrc` file.

   ```bash
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
   ```

2. **Reload .bashrc**  
   Run the following command to apply changes:
   ```bash
   source ~/.bashrc
   ```

## Usage

1. **Start Extra History Logging**  
   Use the `start_extra_history` command to begin logging specific commands.
   ```bash
   start_extra_history
   ```
   This command marks the starting point in the session history.

2. **Execute Commands**  
   Run any commands you want to log specifically for this session.

3. **Stop Logging and Save History**  
   Use `stop_extra_history` to stop logging and save the commands to a specified file:
   ```bash
   stop_extra_history /path/to/target_file
   ```
   If no file path is provided, you will be prompted to enter a filename.

   > **Note**: You can use `~` to refer to the home directory (e.g., `~/my_history.log`), and it will expand automatically.

4. **Example**  
   ```bash
   start_extra_history
   echo "Sample command"
   ls -al
   stop_extra_history ~/selected_history.txt
   ```
   The file `~/selected_history.txt` will contain only `echo "Sample command"` and `ls -al`.

## How It Works

- **start_extra_history**: Sets a marker at the current point in your history.
- **stop_extra_history**: Captures all commands executed since the start marker and writes them to the specified file without modifying the main session history.

Enjoy selective logging for your Bash sessions!
