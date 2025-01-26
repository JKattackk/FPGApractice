Simple adjustable timer.
Timer value is taken in minutes from SW 0:3 as a binary number.
BTN1 starts the timer while in waiting state, pauses or resumes the timer while active, and resets to waiting when the timer finishes.
BTN0 clears the timer and returns to the waiting state.
LEDS indicate the time selected by the switches (the time the timer counts down from)
Currently a time of zero minutes if selected using the switches is still a one minute countdown as the finish state is only checked at the end of each minute.
