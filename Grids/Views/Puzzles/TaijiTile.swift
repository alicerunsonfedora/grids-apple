//
//  TaijiTile.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI
import PuzzleKit

struct TaijiTile: View {
    @Environment(\.colorScheme) var colorScheme
    var tileSize: CGFloat = 64
    var tile: PKTaijiTile
    
    var body: some View {
        ZStack {
            Rectangle()
                .strokeBorder(tile.state == .invisible ? Color.systemBackground : .tileBorder, style: border)
                .background {
                    tile.state == .invisible ? Color.systemBackground : .tileBackground
                }
                .frame(width: tileSize, height: tileSize)
            if tile.filled {
                Rectangle()
                    .fill(.tileBorder)
                    .frame(width: tileSize - 16, height: tileSize - 16)
            }
            if let symbol = tile.symbol {
                Image(imageName(for: symbol))
                    .frame(width: tileSize - 16, height: tileSize - 16)

                // NOTE: Somehow the rendering mode causes the tile to not render AT ALL whenever you're painting tiles.
                // As to why this is? No clue. Maybe it's a PNG related thing?
                
//                    .renderingMode(.template)
//                    .foregroundStyle(color)
            }
        }
        .frame(width: tileSize, height: tileSize)
    }

    private var border: StrokeStyle {
        if tile.state == .normal {
            StrokeStyle(lineWidth: 4)
        } else {
            StrokeStyle(lineWidth: 4, dash: [12, 7])
        }
    }

    private func imageName(for symbol: PKTaijiTileSymbol) -> String {
        switch symbol {
        case .flower(let petals):
            "flower.\(petals)"
        case .dot(let value, let additive):
            "dot.\(additive ? "plus": "minus").\(value)"
        case .diamond:
            "diamond"
        case .slashdash(let rotates):
            rotates ? "slash" : "dash"
        }
    }
    
    private var color: Color {
        switch tile.color {
        case .red:
                .red
        case .orange:
                .orange
        case .yellow:
                .yellow
        case .green:
                .green
        case .blue:
                .blue
        case .purple:
                .purple
        case .white:
            colorScheme == .light ? .white : .black
        case .black:
            colorScheme == .light ? .black : .white
        case nil:
                .clear
        }
    }
}

#Preview {
    HStack(spacing: 8) {
        TaijiTile(tile: .empty())
        TaijiTile(tile: .init(state: .fixed, symbol: .diamond, color: .purple))
        TaijiTile(tile: {
            var tile = PKTaijiTile.symbolic(.slashdash(rotates: true), coloredBy: .orange)
            tile.filled = true
            return tile
        }())
        TaijiTile(tile: .symbolic(.flower(petals: 3)))
        TaijiTile(tile: {
            var tile = PKTaijiTile.symbolic(.dot(value: 5, additive: true))
            tile.filled = true
            tile.state = .fixed
            tile.color = .green
            return tile
        }())
        TaijiTile(tile: .invisible())
    }
    .padding(8)
}
