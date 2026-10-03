//
//  PlayingView.swift
//  Songo
//
//  Created by Auliya Michelle Adhana on 01/10/26.
//

import SwiftUI

struct PlayingView: View {
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        VStack {
            HStack {
                Text("⏱️ \(viewModel.timeRemaining)s")
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(viewModel.timeRemaining <= 5 ? .red : .secondary)
                Spacer()
                Text("Skor: \(viewModel.score)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(String(repeating: "❤️", count: max(0, viewModel.lives)))
                    .font(.caption2)
            }
            Spacer()
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title3)
                    .scaleEffect(viewModel.roll < -0.2 ? 1.5 : 1.0)
                    .animation(.easeInOut(duration: 0.15), value: viewModel.roll)
                Spacer()
                Text("\(viewModel.currentNumber)")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title3)
                    .scaleEffect(viewModel.roll > 0.2 ? 1.5 : 1.0)
                    .animation(.easeInOut(duration: 0.15), value: viewModel.roll)
            }
            .padding(.horizontal, 4)
            Spacer()
            // Tombol Bawah
            HStack(spacing: 12) {
                Button("<- Ya") {
                    viewModel.submitAnswer(guessedDivisible: true)
                }
                .tint(.green)
                Button("Tidak ->") {
                    viewModel.submitAnswer(guessedDivisible: false)
                }
                .tint(.red)
            }
            .font(.caption2)
        }
    }
}
