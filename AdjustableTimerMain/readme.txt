Simple adjustable timer.
Timer value is taken in minutes from SW 0:3 as a binary number.
BTN1 starts the timer while in waiting state, pauses or resumes the timer while active, and resets to waiting when the timer finishes.
BTN0 clears the timer and returns to the waiting state.
LED 5:2 indicate the time selected by the switches (the time the timer counts down from)
LED 1:0 indicate which state the timer is currently in (00 - waiting | 01 - active | 10 - paused | 11 - finished)

Selecting a time of zero minutes currently just causes the timer to run indefinitely 
