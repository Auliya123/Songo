//
//  ContentView.swift
//  Songo Watch App
//
//  Created by Auliya Michelle Adhana on 22/09/26.
//

import SwiftUI
import WatchKit
import Combine

enum GameState {
    case ready
    case playing
    case gameOver
}

struct ContentView: View {
    @AppStorage("highScore") private var highScore: Int = 0
    @State private var isNewRecord: Bool = false
    @State private var score: Int = 0
    @State private var lives: Int = 3
    @State private var currentNumber: Int =  GameLogic.generateNumber()
    @State private var isLocked: Bool = false
    @State private var gameState: GameState = .ready
    @State private var timeRemaining: Int = 45

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @StateObject private var motion = MotionManager()

    var body: some View {
        VStack {
            switch gameState {
            case .ready:
                VStack(spacing: 8) {
                    Text("Habis Bagi 9?")
                        .font(.headline)

                    Text("Tilt kiri = Ya (✓)\nTilt kanan = Tidak (✗)")
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)

                    Button("Mulai Main!"){
                        startGame()
                    }
                    .tint(.green)
                }

            case .playing:
                VStack {
                    // Header Skor & Nyawa
                    HStack {
                        Text("⏱️ \(timeRemaining)s")
                            .font(.footnote)
                            .bold()
                            .foregroundStyle(timeRemaining <= 5 ?.red : .secondary)
                        Spacer()
                        Text("Skor: \(score)")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(String(repeating: "❤️", count: max(0, lives)))
                            .font(.caption2)
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title3)
                            .scaleEffect(motion.roll < -0.2 ? 1.5 : 1.0)
                            .animation(.easeInOut(duration: 0.15), value: motion.roll)
                        Spacer()
                        Text("\(currentNumber)")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.title3)
                            .scaleEffect(motion.roll > 0.2 ? 1.5 : 1.0)
                            .animation(.easeInOut(duration: 0.15), value: motion.roll)
                    }
                    .padding(.horizontal, 4)
                    Spacer()
                    // Tombol Bawah (Cukup panggil submitAnswer!)
                    HStack(spacing: 12) {
                        Button("<- Ya") {
                            submitAnswer(guessedDivisible: true)
                        }
                        .tint(.green)
                        Button("Tidak ->") {
                            submitAnswer(guessedDivisible: false)
                        }
                        .tint(.red)
                    }
                    .font(.caption2)
                }

            case .gameOver:
                VStack(spacing: 6){
                    if isNewRecord {
                        Text("🎉 REKOR BARU!")
                            .font(.headline)
                            .foregroundStyle(.yellow)
                    } else {
                        Text("Game Over")
                            .font(.headline)
                            .foregroundStyle(.red)
                    }

                    Text("Skor: \(score)")
                        .font(.title3)
                        .bold()

                    Text("Terbaik: \(highScore)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    Button("Main Lagi"){
                        startGame()
                    }
                    .tint(.blue)

                    Button("Menu Utama"){
                        gameState = .ready
                    }
                    .tint(.gray)
                }
            }
        }
        .padding()
        .onAppear {
            motion.startUpdates()
        }
        .onDisappear {
            motion.stopUpdates()
        }
        .onChange(of: motion.roll) { oldRoll, newRoll in
            guard gameState == .playing else { return } // Sensor cuma aktif saat playing!

            if !isLocked {
                if newRoll < -0.4 {
                    submitAnswer(guessedDivisible: true)
                    isLocked = true
                } else if newRoll > 0.4 {
                    submitAnswer(guessedDivisible: false)
                    isLocked = true
                }
            } else {
                if abs(newRoll) < 0.2 {
                    isLocked = false
                }
            }
        }
        .onReceive(timer) { _ in
            guard gameState == .playing else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
                if timeRemaining > 0 && timeRemaining <= 5 {
                    WKInterfaceDevice.current().play(.click)
                } else if timeRemaining == 0 {
                    endGame()
                }
            }
        }
    }

    func submitAnswer(guessedDivisible: Bool){
        guard lives > 0 else { return }
        let actuallyDivisible = GameLogic.isDivisibleBy9(currentNumber)

        if guessedDivisible == actuallyDivisible {
            score += 1
            WKInterfaceDevice.current().play(.success)
        } else {
            lives -= 1
            if lives <= 0 {
                endGame()
            } else {
                WKInterfaceDevice.current().play(.failure)
            }
        }
        currentNumber = GameLogic.generateNumber()
    }

    func startGame(){
        score = 0
        lives = 3
        timeRemaining = 45
        currentNumber = GameLogic.generateNumber()
        isLocked = false
        gameState = .playing
    }

    func endGame(){
        gameState = .gameOver
        if score > highScore {
            highScore = score
            isNewRecord = true
            WKInterfaceDevice.current().play(.notification)
        } else {
            isNewRecord = false
            WKInterfaceDevice.current().play(.retry)
        }
    }
}

#Preview {
    ContentView()
}
