//
//  PuzzleIssueValidator.swift
//  Grids
//
//  Created by Marquis Kurt on 13-01-2025.
//

import Foundation
import PuzzleKit

/// An issue validator that validates a puzzle.
public enum PuzzleIssueValidator {
    /// Validates the specified puzzle and reports any issues found.
    /// - Parameter puzzle: The puzzle to validate and generate an issue report for.
    public static func validate(_ puzzle: PKTaijiPuzzle) -> Set<Issue> {
        var issuesFound = Set<Issue>()

        switch (puzzle.width, puzzle.height) {
        case (23..., _), (_, 14...):
            issuesFound.insert(.layoutExceedsSize(CGSize(width: puzzle.width, height: puzzle.height)))
        case (12..<23, _), (_, 7..<14):
            issuesFound.insert(.layoutInaccessible)
        default:
            break
        }

        let diamondsInPuzzle = puzzle.tiles.count { tile in
            tile.symbol == .diamond
        }
        if diamondsInPuzzle % 2 != 0 { issuesFound.insert(.unevenDiamonds) }

        let dotSize = puzzle.tiles.reduce(0) { accum, current in
            guard case let .dot(value, additive) = current.symbol else { return accum }
            return additive ? accum + value : accum - value
        }
        if dotSize < 0 { issuesFound.insert(.allNegativeDots) }

        let containsOtherColor = puzzle.tiles.contains { tile in
            tile.color != nil && tile.color != .black
        }
        if containsOtherColor { issuesFound.insert(.multicolor) }
        
        return issuesFound
    }
}
