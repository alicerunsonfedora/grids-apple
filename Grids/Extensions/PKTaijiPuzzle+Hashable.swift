//
//  PKTaijiPuzzle+Codable.swift
//  Grids
//
//  Created by Marquis Kurt on 08-01-2025.
//

import PuzzleKit

extension PKTaijiPuzzle: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Set(tiles))
    }
}
