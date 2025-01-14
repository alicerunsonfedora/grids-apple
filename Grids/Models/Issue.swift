//
//  Issue.swift
//  Grids
//
//  Created by Marquis Kurt on 13-01-2025.
//

import Foundation

struct Issue: Hashable, Identifiable {
    enum Severity {
        case warning, error, runtimeWarning
    }

    var id: String
    var text: String
    var description: String?
    var severity: Severity
    
    init(_ text: String, description: String? = nil, id: String, severity: Severity) {
        self.text = text
        self.description = description
        self.id = id
        self.severity = severity
    }
}

extension Issue {
    // MARK: - Layout Issues
    static let layoutInaccessible = Issue(
        "This puzzle might not be easily readable on Playdate.",
        description: "This puzzle is bigger than the recommended 11 x 6 tiles, which will render at half scale.",
        id: "layout.irregular",
        severity: .warning)

    static func layoutExceedsSize(_ size: CGSize) -> Issue {
        Issue(
            "This puzzle is too big for What the Taiji?!",
            description: String(
                format: "This puzzle is %d x %d tiles, which exceeds 22 x 13 tiles.",
                Int(size.width),
                Int(size.height)),
            id: "layout.sizeexceeds",
            severity: .error)
    }

    // MARK: - Mechanical Issues
    static let unevenDiamonds = Issue(
        "Impossible constraints: mispaired diamonds",
        description: "There are an odd amount of diamonds in this puzzle, which might be unsolvable.",
        id: "mechanics.diamondmismatch",
        severity: .runtimeWarning)
    static let allNegativeDots = Issue(
        "Impossible constraints: all subtractive dots",
        description: "There are subtractive dots in this puzzle with no additive dots to cancel out or subtract from.",
        id: "mechanics.allnegativedots",
        severity: .runtimeWarning)

    // MARK: - Color Issues
    static let multicolor = Issue(
        "This puzzle contains symbols with multiple color types.",
        description: "Color mechanics are unsupported on Playdate and will render as black.",
        id: "mechanics.color",
        severity: .runtimeWarning)
}
