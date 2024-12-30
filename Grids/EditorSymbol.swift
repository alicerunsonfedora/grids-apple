//
//  EditorSymbol.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import PuzzleKit

enum EditorSymbol: Hashable, CaseIterable {
    case flower
    case dot
    case dash
    case slash
    case diamond
    
    var isValueDependent: Bool {
        switch self {
        case .flower, .dot:
            return true
        default:
            return false
        }
    }
    
    var icon: String {
        switch self {
        case .flower:
            "flower.3"
        case .dot:
            "dot.plus.5"
        case .diamond:
            "diamond"
        case .slash:
            "slash"
        case .dash:
            "dash"
        }
    }
}

extension PKTaijiTile {
    init(_ editorSymbol: EditorSymbol, value: Int? = nil, additive: Bool = true) {
        switch editorSymbol {
        case .flower:
            self.init(state: .normal, symbol: .flower(petals: value ?? 0))
        case .dot:
            self.init(state: .normal, symbol: .dot(value: value ?? 1, additive: additive))
        case .dash:
            self.init(state: .normal, symbol: .slashdash(rotates: false))
        case .slash:
            self.init(state: .normal, symbol: .slashdash(rotates: true))
        case .diamond:
            self.init(state: .normal, symbol: .diamond)
        }
    }
}
