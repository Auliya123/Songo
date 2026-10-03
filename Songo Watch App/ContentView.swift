//
//  ContentView.swift
//  Songo Watch App
//
//  Created by Auliya Michelle Adhana on 22/09/26.
//

import SwiftUI
import Combine

struct ContentView: View {

    @StateObject private var viewModel = GameViewModel(
        motion: MotionManager(),
        haptic: HapticService(),
        timer: TimerService()
    )

    var body: some View {
        VStack {
            switch viewModel.gameState {
            case .ready:
               ReadyView(viewModel: viewModel)

            case .playing:
                PlayingView(viewModel: viewModel)

            case .gameOver:
               GameOverView(viewModel: viewModel)
            }
        }
        .padding()
        .onAppear {
            viewModel.startAppSession()
        }
        .onDisappear {
            viewModel.stopAppSession()
            viewModel.motion.stopUpdates()
        }
    }

  
}

#Preview {
    ContentView()
}
