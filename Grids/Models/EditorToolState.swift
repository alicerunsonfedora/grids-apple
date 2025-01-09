//
//  EditorToolState.swift
//  Grids
//
//  Created by Marquis Kurt on 30-12-2024.
//

import SwiftUI
import PuzzleKit

// TODO: Move this into EditorToolState.
enum EditorTool: CaseIterable {
    case symbolPainter
    case layoutEditor
    case tileFlipper
    case eraser
    
    var name: LocalizedStringKey {
        switch self {
        case .symbolPainter:
            "Symbol Painter"
        case .layoutEditor:
            "Layout Editor"
        case .tileFlipper:
            "Tile Flipper"
        case .eraser:
            "Symbol Eraser"
        }
    }
    
    var systemImage: String {
        switch self {
        case .symbolPainter:
            "paintbrush"
        case .layoutEditor:
            "aspectratio"
        case .tileFlipper:
            "arrow.clockwise.square"
        case .eraser:
            "eraser"
        }
    }
}

struct EditorToolState: Equatable {
    var tool: EditorTool = .tileFlipper
    var symbol: EditorSymbol = .diamond
    var value: Int = 1
    var dotAdditive: Bool = true
    var shaperKind: PKTaijiTileState = .normal
    
    var taijiTileSymbol: PKTaijiTileSymbol {
        switch symbol {
        case .flower:
                .flower(petals: value)
        case .dot:
                .dot(value: value, additive: dotAdditive)
        case .dash:
                .slashdash(rotates: false)
        case .slash:
                .slashdash(rotates: true)
        case .diamond:
                .diamond
        }
    }
}
