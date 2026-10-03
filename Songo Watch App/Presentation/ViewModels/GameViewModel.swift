//
//  GameViewModel.swift
//  Songo
//
//  Created by Auliya Michelle Adhana on 01/10/26.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published private(set) var isNewRecord: Bool = false
    @Published private(set) var score: Int = 0
    @Published private(set) var lives: Int = 3
    @Published private(set) var currentNumber: Int =  GameLogic.generateNumber()
    @Published private(set) var isLocked: Bool = false
    @Published private(set) var gameState: GameState = .ready
    @Published private(set) var timeRemaining: Int = 45
    @Published private(set) var roll: Double = 0.0
    @Published var highScore: Int = 0
    
    private var timerCancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    let motion: MotionManager
    private let haptic: HapticServiceProtocol
    private let timer: TimerServiceProtocol
    private let sessionManager: GameSessionManager
    
    init(
        motion: MotionManager,
        haptic: HapticServiceProtocol,
        timer: TimerServiceProtocol,
        sessionManager: GameSessionManager = GameSessionManager()
    ) {
        self.motion = motion
        self.haptic = haptic
        self.timer = timer
        self.sessionManager = sessionManager
        loadHighScore()
        setupMotionSubscription()
    }
    
    private func setupMotionSubscription() {
        motion.$roll
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newRoll in
                guard let self = self else { return }
                self.roll = newRoll
                self.startMotion(newRoll)
            }
            .store(in: &cancellables)
    }
    
    private func loadHighScore() {
        highScore = UserDefaults.standard.integer(forKey: "highScore")
    }
    
    private func saveHighScore(_ newScore: Int) {
        UserDefaults.standard.set(newScore, forKey: "highScore")
    }
    
    
    
    func submitAnswer(guessedDivisible: Bool){
        guard lives > 0 else { return }
        let actuallyDivisible = GameLogic.isDivisibleBy9(currentNumber)
        
        if guessedDivisible == actuallyDivisible {
            score += 1
            haptic.playSuccess()
        } else {
            lives -= 1
            if lives <= 0 {
                endGame()
            } else {
                haptic.playFailure()
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
        
        motion.startUpdates()
        sessionManager.startSession()
        
        timer.start { [weak self] in
            self?.handleTimer()
        }
    }
    
    func endGame(){
        timer.stop()
        gameState = .gameOver
        
        motion.stopUpdates()
        
        if score > highScore {
            highScore = score
            saveHighScore(score)
            isNewRecord = true
            haptic.playNewRecord()
        } else {
            isNewRecord = false
            haptic.playGameOver()
        }
    }
    
    func startMotion(_ newRoll: Double){
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
    
    func backToMenu() {
        timer.stop()
        motion.stopUpdates()
        gameState = .ready
    }
    
    func startAppSession() {
        sessionManager.startSession()
    }
    
    func stopAppSession() {
        sessionManager.stopSession()
    }
    
    private func handleTimer() {
        guard gameState == .playing else { return }
        if timeRemaining > 0 {
            timeRemaining -= 1
            if timeRemaining > 0 && timeRemaining <= 5 {
                haptic.playTimerTick()
            } else if timeRemaining == 0 {
                endGame()
            }
        }
    }
}
