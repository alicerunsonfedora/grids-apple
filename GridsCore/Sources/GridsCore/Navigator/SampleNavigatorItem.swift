//
//  SampleNavigatorItem.swift
//  GridsCore
//
//  Created by Marquis Kurt on 26-01-2025.
//

#if DEBUG && canImport(SwiftUI)
import SwiftUI

enum SampleNavigatorItem: NavigatorItem, CaseIterable {
    case files
    case issues
    case tests
    
    var id: String { self.symbol }

    var symbol: String {
        switch self {
        case .files:
            "folder"
        case .issues:
            "exclamationmark.triangle"
        case .tests:
            "checkmark.diamond"
        }
    }

    var name: String {
        switch self {
        case .files:
            return "Files"
        case .issues:
            return "Issues"
        case .tests:
            return "Tests"
        }
    }
    
    var help: String {
        "Show the \(self.name) navigator"
    }
}

extension SampleNavigatorItem: DefaultSelectionProvider {
    static var defaultSelection: SampleNavigatorItem {
        .files
    }
}
#endif
