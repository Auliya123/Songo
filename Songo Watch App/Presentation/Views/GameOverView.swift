//
//  GameOverView.swift
//  Songo
//
//  Created by Auliya Michelle Adhana on 01/10/26.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 6){
            if viewModel.isNewRecord {
                Text("🎉 REKOR BARU!")
                    .font(.headline)
                    .foregroundStyle(.yellow)
            } else {
                Text("Game Over")
                    .font(.headline)
                    .foregroundStyle(.red)
            }

            Text("Skor: \(viewModel.score)")
                .font(.title3)
                .bold()

            Text("Terbaik: \(viewModel.highScore)")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Button("Main Lagi"){
                viewModel.startGame()
            }
            .tint(.blue)

            Button("Menu Utama"){
                viewModel.backToMenu()
            }
            .tint(.gray)
        }
    }
}
