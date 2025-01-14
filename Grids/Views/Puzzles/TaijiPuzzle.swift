//
//  TaijiPuzzle.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI
import PuzzleKit

extension PKTaijiPuzzle {
    init?(decodingOrNull decode: String) {
        do {
            self = try .init(decoding: decode)
        } catch {
            return nil
        }
    }
}

struct TaijiPuzzle: View {
    @ScaledMetric var scale = 64
    var puzzle: PKTaijiPuzzle

    var tapIndexCallback: ((Int) -> Void)?

    var layout: [GridItem] {
        Array(
            repeating: GridItem(.fixed(scale)),
            count: puzzle.width)
    }

    var body: some View {
        LazyVGrid(columns: layout, spacing: 8) {
            ForEach(Array(zip(puzzle.tiles.indices, puzzle.tiles)), id: \.0) { (index, tile) in
                TaijiTile(tileSize: scale, tile: tile)
                    .onTapGesture {
                        tapIndexCallback?(index)
                    }
            }
        }
        .scaledToFit()
    }
}

#Preview {
    struct MyPreview: View {
        var body: some View {
            Group {
                if let puzzle = PKTaijiPuzzle(decodingOrNull: "6:0Cw+CY0Aw0Cw+DDw0Sw+CDw0Bw+CCw0Tw+BSw+BUw0") {
                    TaijiPuzzle(puzzle: puzzle)
                }
            }
        }
    }
    return MyPreview()
}
