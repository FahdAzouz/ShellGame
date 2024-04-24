# Documentation for Quiz Game Script

## File Name
**display_question_answers.sh**

## Purpose
The purpose of this script is to provide an interactive quiz game that runs in the shell environment. Players can answer questions loaded from a text file, track their progress, and score points based on their answers. The script offers functionality to resume a previous game, start a new game, or exit at any point.

## How to Run the Script
To run the script, ensure you have a Unix-like environment with a Bash shell. Follow these steps:

### Make the Script Executable
```bash
chmod +x display_question_answers.sh
```
### Run the Script
To start a new game
```bash
./display_question_answers.sh -n
```
To resume a previous game
```bash
./display_question_answers.sh -r
```
To view help
```bash
./display_question_answers.sh -h
```

### During the Game
- Answer the questions by entering the number corresponding to your chosen answer.
- Press 'q' to quit and save progress at any point.

## Assumptions Made During Development
1. **Environment**: The script is designed to run in a Unix-like environment with a standard Bash shell.
2. **File Format**: It is assumed that the `questions.txt` and `answers.txt` files exist in the same directory as the script and are properly formatted:
   - `questions.txt` contains one question per line.
   - `answers.txt` contains answers for each question in the format where incorrect answers are separated by commas, and the correct answer follows after a semicolon.
3. **Input Integrity**: The script assumes that the inputs in `answers.txt` are correctly formatted and correspond line-by-line with `questions.txt`.
4. **User Input**: It is assumed that the user inputs valid integers when answering questions. Invalid or non-integer inputs are not handled by the script and may cause errors or unexpected behavior.
5. **File Presence**: The script assumes that the `game_progress.txt` file can be created and written to in the script's running directory. If permissions or other file system issues prevent this, the script will not function correctly.

## Error Handling
The script includes basic error handling:
- Checks if `questions.txt` exists and is not empty.
- Ensures that the game progresses smoothly even if the user enters unexpected input by handling non-integer inputs.

## Future Enhancements
- **Input Validation**: Adding robust input validation to handle non-integer and out-of-range answers.
- **Enhanced Error Handling**: Improved error handling for file access issues, and better user guidance for incorrect inputs.
- **Graphical Interface**: Considering a GUI version for a more user-friendly experience outside the command line.

## Conclusion
This script provides a basic but functional interactive quiz game suitable for educational purposes and casual gaming in a shell environment. It is designed for easy modification and extension, allowing further customization as needed.

