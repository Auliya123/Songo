//
//  ReadyView.swift
//  Songo
//
//  Created by Auliya Michelle Adhana on 01/10/26.
//

import SwiftUI

struct ReadyView: View {
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        VStack(spacing: 8) {
            Text("Habis Bagi 9?")
                .font(.headline)

            Text("Tilt kiri = Ya (✓)\nTilt kanan = Tidak (✗)")
                .font(.caption2)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("Mulai Main!"){
                viewModel.startGame()
            }
            .tint(.green)
        }
    }
}
