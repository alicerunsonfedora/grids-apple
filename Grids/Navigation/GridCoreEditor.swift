//
//  GridCoreEditor.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import SwiftUI
import PuzzleKit

struct GridCoreEditor: View {
    @Binding var puzzle: PKTaijiPuzzle
    var toolState: EditorToolState

    var body: some View {
        TaijiPuzzle(puzzle: puzzle) { tileIndex in
            performActionForTool(at: tileIndex)
        }
    }

    private func performActionForTool(at index: Int) {
        let coordinate = index.toCoordinate(wrappingAround: puzzle.width)
        switch toolState.tool {
        case .symbolPainter:
            self.puzzle = puzzle.replacingSymbol(at: coordinate, with: toolState.taijiTileSymbol)
        case .eraser:
            self.puzzle = puzzle.replacingSymbol(at: coordinate, with: nil)
        case .tileFlipper:
            self.puzzle = puzzle.flippingTile(at: coordinate)
        default:
            break
        }
    }
}

#Preview {
    @Previewable
    @State var puzzle = PKTaijiPuzzle(size: .init(width: 3, height: 3))
    
    @Previewable
    @State var editorToolState = EditorToolState()
    
    GridCoreEditor(puzzle: $puzzle, toolState: editorToolState)
}
