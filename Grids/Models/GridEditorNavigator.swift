//
//  GridEditorNavigator.swift
//  Grids
//
//  Created by Marquis Kurt on 13-01-2025.
//

import GridsCore
import SwiftUI

enum GridEditorNavigator: NavigatorItem, CaseIterable {
    case puzzleSet
    case issues

    var id: String { self.name }
    
    var name: String {
        switch self {
        case .puzzleSet:
            String(localized: "Puzzles")
        case .issues:
            String(localized: "Issues")
        }
    }
    
    var symbol: String {
        switch self {
        case .puzzleSet:
            "square.grid.2x2"
        case .issues:
            "exclamationmark.triangle"
        }
    }

    var help: String {
        String(localized: "Show the \(name) navigator")
    }
}
