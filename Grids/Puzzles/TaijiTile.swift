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
                .strokeBorder(tile.state == .invisible ? .clear : .gray, style: border)
                .background {
                    tile.state == .invisible ? Color.clear : Color("TileBackground")
                }
                .frame(width: tileSize, height: tileSize)
            if tile.filled {
                Rectangle()
                    .fill(.gray)
                    .frame(width: tileSize - 16, height: tileSize - 16)
            }
            symbol
                .font(.title)
                .bold()
                .imageScale(.large)
                .foregroundStyle(color)
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
    
    private var symbol: some View {
        Group {
            switch tile.symbol {
            case .flower:
                Image(systemName: "tree.fill")
            case .dot(let value, let additive):
                Image(systemName: "\(value).square\(additive ? ".fill": "")")
            case .diamond:
                Image(systemName: "diamond.fill")
            case .slashdash(let rotates):
                Image(systemName: rotates ? "line.diagonal" : "minus")
            case nil:
                EmptyView()
            }
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
            var tile = PKTaijiTile.symbolic(.slashdash(rotates: true))
            tile.filled = true
            return tile
        }())
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
