//
//  WTPFileIcon.swift
//  GridsCore
//
//  Created by Marquis Kurt on 03-11-2025.
//

import Foundation

/// An enumeration of the different file icons a puzzle can have.
///
/// File icons are generally used to denote the major theme or mechanic for a given puzzle file.
public enum WTPFileIcon: Int, Identifiable, Sendable, CaseIterable {
    case generic = 1
    case gardens = 2
    case mill = 3
    case mines = 4
    case shrine = 5
    case challenge = 7
    case `set` = 9
    case tutorial = 10

    public var name: String {
        switch self {
        case .generic:
            "Generic"
        case .gardens:
            "Gardens"
        case .mill:
            "Mill"
        case .mines:
            "Mines"
        case .shrine:
            "Shrine"
        case .challenge:
            "Challenge"
        case .set:
            "Puzzle Set"
        case .tutorial:
            "Tutorial"
        }
    }

    public var id: Int {
        self.rawValue
    }
}
