//
//  GridEditorSidebarEntry.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import SwiftUI

struct GridEditorSidebarEntry: View {
    @Binding var file: WTPFile
    var puzzle: WTPFilePuzzle

    private var cardSize: CGSize {
        .init(width: 100 * 1.25, height: 66 * 1.25)
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            Text(puzzle.id + 1, format: .number)
                .fontWidth(.condensed)
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .aspectRatio(3/2, contentMode: .fit)
                    .shadow(radius: 4)
                TaijiPreviewPuzzle(puzzleCode: puzzle.code)
                    .frame(width: cardSize.width, height: cardSize.height)
                    .clipped()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 4))
            }
            .frame(width: cardSize.width, height: cardSize.height)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .contextMenu {
            Button {
                file.removePuzzleFromSet(at: puzzle.id)
            } label: {
                Label("Remove Puzzle", systemImage: "minus")
            }
            .disabled(file.document.puzzleCodes.count < 2)
        }
    }
}
