//
//  GridPlayer.swift
//  Grids
//
//  Created by Marquis Kurt on 08-01-2025.
//

import SwiftUI
import PuzzleKit

struct GridPlayer: View {
    @Binding var puzzle: PKTaijiPuzzle?
    @State private var solved = false
    @State private var startShaking = false

    var body: some View {
        Group {
            VStack {
                if solved {
                    solvedLabel
                }
                Spacer()
                if let puzzle {
                    TaijiPuzzle(puzzle: puzzle) { tileIndex in
                        self.puzzle = puzzle.flippingTile(
                            at: tileIndex.toCoordinate(wrappingAround: puzzle.width))
                    }
                    .offset(x: startShaking ? 24 : 0)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Puzzle Player")
        .animation(.bouncy, value: solved)
        .toolbar {
            Button {
                if let validation = self.puzzle?.validate() {
                    switch validation {
                    case .success(_):
                        self.solved = true
                    case .failure(_):
                        startShaking = true
                        withAnimation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0.2)) {
                            self.solved = false
                            self.startShaking = false
                        }
                    }
                }
            } label: {
                Label("Check...", image: "square.grid.3x3.fill.badge.checkmark")
            }
            .keyboardShortcut(.return, modifiers: .command)
        }
    }
    
    var solvedLabel: some View {
        HStack {
            Label("Solved", systemImage: "checkmark.diamond")
                .font(.title2)
                .bold()
                .fontDesign(.rounded)
                .imageScale(.large)
                .foregroundStyle(.green)
                .padding(.horizontal)
                .padding(.vertical, 6)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.green.opacity(0.25))
        )
    }
}

#Preview {
    @Previewable @State var puzzle: PKTaijiPuzzle? = PKTaijiPuzzle(size: .init(width: 3, height: 3))
    GridPlayer(puzzle: $puzzle)
}
