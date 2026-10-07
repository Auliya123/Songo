# Songo

Songo is a native watchOS math game that challenges players to determine whether a number is divisible by 9 ("songo" means nine in Javanese). Built with SwiftUI, Combine, and Clean Architecture (MVVM), the app provides an engaging wrist-first experience powered by CoreMotion tilt gestures and immersive WatchKit haptics.

## Features

- **Motion Tilt Gameplay**: Answer intuitively by tilting your wrist left (Yes) or right (No) using CoreMotion device attitude (`roll`), complete with dynamic on-screen scale animations.
- **Button Controls**: Alternative on-screen touch buttons (`<- Ya` and `Tidak ->`) for quick manual input.
- **Math Challenge Generator**: Generates 3- to 4-digit numbers with calibrated probability bias for divisibility testing.
- **Dynamic Haptic Feedback**: Context-aware haptics using `WKInterfaceDevice` for correct answers, errors, countdown ticks, high score records, and game over.
- **Score & High Score Tracking**: Real-time score counting, 3-heart life system, 45-second countdown timer, and persistent personal high score saved via `UserDefaults`.

## Screenshots

<img width="240" alt="Songo Ready Screen" src="https://github.com/user-attachments/assets/your-ready-screen-id" />

<img width="240" alt="Songo Gameplay" src="https://github.com/user-attachments/assets/your-gameplay-id" />

<img width="240" alt="Songo Game Over" src="https://github.com/user-attachments/assets/your-gameover-id" />

## Video Screenshot

https://github.com/user-attachments/assets/your-demo-video-id

## Requirements

- watchOS 10.0+ (Deployment target: watchOS 11.6)
- Swift 5.0+
- Xcode 15.0+
- Apple Watch (Physical device recommended for CoreMotion and Haptics)

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/Auliya123/Songo.git
    cd Songo
    ```

2. Open the project in Xcode:

    ```bash
    open Songo.xcodeproj
    ```

3. Select the **Songo Watch App** scheme and choose your paired Apple Watch or a simulator.

4. Build and run the project (`⌘ + R`).

## Usage

1. **Ready Screen**:
    - Launch the app to view the game rules ("Habis Bagi 9?").
    - Review the gesture guide: Tilt left = Yes (✓), Tilt right = No (✗).
    - Tap **Mulai Main!** to begin the game session.

2. **Gameplay & Tilt Controls**:
    - A 3- to 4-digit number is presented on screen with a 45-second countdown timer and 3 lives (❤️❤️❤️).
    - **Tilt Left** (`roll < -0.4`) or tap **<- Ya** if the number is divisible by 9.
    - **Tilt Right** (`roll > 0.4`) or tap **Tidak ->** if the number is not divisible by 9.
    - Return your wrist to neutral position (`|roll| < 0.2`) to unlock the next tilt gesture.
    - *Pro-Tip*: A number is divisible by 9 if the sum of all its digits equals a multiple of 9 (e.g., 2 + 5 + 2 = 9)!

3. **Haptic Feedback**:
    - Feel an instant `.success` haptic tap when your answer is correct.
    - Receive a `.failure` haptic vibration and lose 1 life if your answer is incorrect.
    - As the timer reaches the last 5 seconds, an urgent `.click` ticker pulses every second to warn you.

4. **Game Over & New Record**:
    - The game ends when either the 45-second timer runs out or all 3 lives are lost.
    - View your final score alongside your personal high score.
    - If you break your previous record, a celebratory **🎉 REKOR BARU!** banner appears with a special haptic alert.
    - Tap **Main Lagi** to replay immediately, or tap **Menu Utama** to return to the ready screen.

Feel free to reach out if you have any questions or need further assistance!
