//
//  PKTaijiPuzzle+Codable.swift
//  Grids
//
//  Created by Marquis Kurt on 08-01-2025.
//

import PuzzleKit

// TODO: Maybe this should go back upstream instead of doing a retroactive extension here?

extension PKTaijiPuzzle: @retroactive Codable {
    public func encode(to encoder: any Encoder) throws {
        let encodedString = String(encoding: self)
        var container = encoder.unkeyedContainer()
        try container.encode(encodedString)
    }
    
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let code = try container.decode(String.self)
        try self.init(decoding: code)
    }
}

extension PKTaijiPuzzle: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Set(tiles))
    }
}
