//
//  EditorToolState.swift
//  Grids
//
//  Created by Marquis Kurt on 30-12-2024.
//

import PuzzleKit

struct EditorToolState: Equatable {
    var tool: EditorTool = .tileFlipper
    var symbol: EditorSymbol = .diamond
    var value: Int = 1
    var dotAdditive: Bool = false
    
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
