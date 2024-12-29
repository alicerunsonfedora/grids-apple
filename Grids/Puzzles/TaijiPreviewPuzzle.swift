//
//  TaijiPreviewPuzzle.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import PuzzleKit
import SwiftUI

struct TaijiPreviewPuzzle: View {
    var puzzleCode: String

    private var puzzle: PKTaijiPuzzle? { .init(decodingOrNull: puzzleCode) }
    private var size: CGSize { .init(width: puzzle?.width ?? 1, height: puzzle?.height ?? 1) }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<Int(size.height), id: \.self) { _ in
                GridRow {
                    ForEach(0..<Int(size.width), id: \.self) { _ in
                        Image(systemName: "square")
                    }
                }
            }
            .font(.subheadline)
            .imageScale(.large)
            .foregroundStyle(.gray)
            .background(Color.white)
        }
    }
}

#Preview {
    TaijiPreviewPuzzle(puzzleCode: "6:0Cw+CY0Aw0Cw+DDw0Sw+CDw0Bw+CCw0Tw+BSw+BUw0")
}
