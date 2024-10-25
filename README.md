# linux_extra_history - Extra History Logging Script
Lets you start and stop a dedicated history recording into a specified file

This script allows you to log only a selected portion of your Bash history 
between a "start" and "stop" command, saving it to a separate file. 
This setup is helpful for keeping a clear log of specific command sessions 
without altering the main session history.

## Setup Instructions

1. **Add Functions to .bashrc**  
   Copy the the two functions `start_extra_history` and `stop_extra_history` from the '.bashrc'-file  
   into the '/etc/bash.bashrc` file.

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
