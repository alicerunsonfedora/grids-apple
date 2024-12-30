//
//  GridCoreEditor.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import SwiftUI
import PuzzleKit

struct GridCoreEditor: View {
    @Binding var puzzle: PKTaijiPuzzle?
    @Binding var file: WTPFile
    var editorTool: EditorTool

    var body: some View {
        Group {
            if let puzzle {
                TaijiPuzzle(puzzle: puzzle) { tileIndex in
                    performActionForTool(at: tileIndex)
                }
            } else {
                ContentUnavailableView("No Puzzle Selected", systemImage: "square.grid.3x3")
            }
        }
    }

    private func performActionForTool(at index: Int) {
        guard let puzzle else { return }
        let coordinate = index.toCoordinate(wrappingAround: puzzle.width)
        switch editorTool {
        case .tileFlipper:
            self.puzzle = puzzle.flippingTile(at: coordinate)
        default:
            break
        }
    }
}

#Preview {
    @Previewable
    @State var puzzle = PKTaijiPuzzle(decodingOrNull: "2:+D")
    
    @Previewable
    @State var file = WTPFile()
    
    GridCoreEditor(puzzle: $puzzle, file: $file, editorTool: .tileFlipper)
}
