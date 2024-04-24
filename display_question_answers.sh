#!/bin/sh

# Function to display usage instructions
usage() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "    -h        Show this help message"
    echo "    -r        Resume the game from last save"
    echo "    -n        Start new game"
}

current_question=0
score=0
# Load progress or initialize variables
load_progress() {
    if [ -f game_progress.txt ] && [ "$new" -ne "1" ]; then
        read current_question score < game_progress.txt
    fi
}

# Save current progress
save_progress() {
    echo "$current_question $score" > game_progress.txt
}

# Parse answers and mark the correct one
parse_answers() {
    correct=$(echo "$1" | cut -d';' -f2)
    answers=$(echo "$1" | cut -d';' -f1)
    echo "Options:"
    index=1
    for ans in $(echo "$answers" | tr ',' '\n'); do
        echo "$index: $ans"
        [ "$ans" = "$correct" ] && correct_index=$index
        index=$((index + 1))
    done
    return $correct_index
}

# Display the question and answers
display_question() {
    question=$(sed "${1}q;d" questions.txt)
    answers=$(sed "${1}q;d" answers.txt)
    echo "Question ${1}: $question"
    parse_answers "$answers"
    correct_index=$?
    read -p "Enter the number of your answer: " user_answer
    if [ "$user_answer" -eq "$correct_index" ]; then
        echo "Correct!"
        score=$((score + 1 + 4 * ${1}))
    else
        echo "Wrong answer. The correct answer was $correct_index."
    fi
}

new=0
# Command line options handling
while getopts ":hrn" opt; do
    case $opt in
        h ) usage; exit 0 ;;
        r ) load_progress ;;
        n ) new=1 ;;
        * ) usage; exit 1 ;;
    esac
done

# Initialize or load game state

# Check for required files
if [ ! -f "questions.txt" ] || [ ! -s "questions.txt" ]; then
    echo "Error: 'questions.txt' is missing or empty."
    exit 1
fi

# Main game loop
question_count=$(wc -l < questions.txt)
while [ $current_question -lt $question_count ]; do
    current_question=$((current_question + 1))
    display_question $current_question
    save_progress
    read -p "Press enter to continue or 'q' to exit...  " input
    if [ "$input" = "q" ]; then
        echo "Exiting the game. Your progress has been saved."
        exit 0
    fi
    clear
done

echo "Game over! Your final score is: $score"

