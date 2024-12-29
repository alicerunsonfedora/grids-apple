//
//  GridEditorSidebarEntry.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import SwiftUI

struct GridEditorSidebarEntry: View {
    @Binding var document: WTPFile
    var index: Int
    var code: String

    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            Text(index + 1, format: .number)
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.white)
                    .aspectRatio(3/2, contentMode: .fit)
                    .shadow(radius: 4)
                TaijiPreviewPuzzle(puzzleCode: code)
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background {
            RoundedRectangle(cornerRadius: 4)
                .fill(index == document.currentPuzzleIndex ? Color.accentColor : Color.clear)
                .padding(.horizontal, 3)
        }
    }
}
