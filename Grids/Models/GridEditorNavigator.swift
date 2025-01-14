//
//  GridEditorNavigator.swift
//  Grids
//
//  Created by Marquis Kurt on 13-01-2025.
//

import SwiftUI

enum GridEditorNavigator: Hashable, CaseIterable {
    case puzzleSet
    case issues
    
    var name: LocalizedStringKey {
        switch self {
        case .puzzleSet:
            "Puzzles"
        case .issues:
            "Issues"
        }
    }
    
    var icon: String {
        switch self {
        case .puzzleSet:
            "square.grid.2x2"
        case .issues:
            "exclamationmark.triangle"
        }
    }
}
