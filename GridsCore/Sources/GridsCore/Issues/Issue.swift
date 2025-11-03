//
//  Issue.swift
//  GridsCore
//
//  Created by Marquis Kurt on 13-01-2025.
//

import Foundation

/// A structure representing an issue that can be displayed in an issue navigator.
public struct Issue: Hashable, Identifiable, Sendable {
    /// An enumeration representing the various severity levels an issue can take.
    public enum Severity: Sendable, Equatable {
        case warning
        case error
        case runtimeWarning
    }

    /// The issue's unique identifier.
    public var id: String

    /// The issue's primary message.
    public var text: String

    /// A description that provides additional context for the issue.
    public var description: String?

    /// The issue's given severity.
    public var severity: Severity

    /// Creates an issue that can be displayed in the issues navigator.
    /// - Parameter text: The issue's primary message.
    /// - Parameter description: A description that provides additional context for the issue.
    /// - Parameter id: A unique identifier for this issue.
    /// - Parameter severity: The issue's severity level.
    public init(_ text: String, description: String? = nil, id: String, severity: Severity) {
        self.text = text
        self.description = description
        self.id = id
        self.severity = severity
    }
}

public extension Issue {
    // MARK: - Layout Issues
    /// A warning indicating the current layout size will be rendered at half-scale.
    static let layoutInaccessible = Issue(
        String(localized: "This puzzle might not be easily readable on Playdate."),
        description: String(
            localized: "This puzzle is bigger than the recommended 11 x 6 tiles, which will render at half scale."),
        id: "layout.irregular",
        severity: .warning)

    /// An error indicating the current layout size is too big.
    /// - Parameter size: The board's current size.
    static func layoutExceedsSize(_ size: CGSize) -> Issue {
        Issue(
            String(localized: "This puzzle is too big for Playdate."),
            description: String(
                localized: "This puzzle is \(Int(size.width)) x \(Int(size.height)) tiles, which exceeds 22 x 13 tiles."),
            id: "layout.sizeexceeds",
            severity: .error
)
    }

    // MARK: - Mechanical Issues
    /// A runtime warning indicating there is an uneven amount of diamonds on the board.
    static let unevenDiamonds = Issue(
        String(localized: "Impossible constraints: mispaired diamonds"),
        description: String(localized: "There are an odd amount of diamonds in this puzzle, which might be unsolvable."),
        id: "mechanics.diamondmismatch",
        severity: .runtimeWarning)

    /// A runtime warning indicating there exists a dot configuration that contains a negative size.
    static let allNegativeDots = Issue(
        String(localized: "Impossible constraints: all subtractive dots"),
        description: String(
            localized: "There are subtractive dots in this puzzle with no additive dots to cancel out or subtract from."),
        id: "mechanics.allnegativedots",
        severity: .runtimeWarning)

    // MARK: - Color Issues
    /// A runtime warning indicating the puzzle contains multiple colors.
    static let multicolor = Issue(
        String(localized: "This puzzle contains symbols with multiple color types."),
        description: String(localized: "Color mechanics are unsupported on Playdate and will render as black."),
        id: "mechanics.color",
        severity: .runtimeWarning)
}
