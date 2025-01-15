//
//  TaijiWebShare.swift
//  Grids
//
//  Created by Marquis Kurt on 06-01-2025.
//

import Foundation
import PuzzleKit

/// A service that shares a Taiji puzzle as a link.
public struct TaijiWebShare: Sendable {
    private static let editorDomain = "https://hiumee.github.io/react/taiji/"

    /// An enumeration for the sharing modes available.
    public enum WebShareMode: Sendable {
        /// The service shares an editor link to the puzzle.
        case editor
        
        /// The services shares a player link to the puzzle.
        case player
    }

    /// The Taiji puzzle code to share.
    var code: String

    /// The means by which the web share should be initiated.
    var shareMode: WebShareMode = .editor
    
    public init(encoding puzzle: PKTaijiPuzzle, mode shareMode: WebShareMode = .editor) {
        self.code = String(encoding: puzzle)
        self.shareMode = shareMode
    }

    /// Creates a shareable URL for the puzzle.
    public func shareURL() -> URL? {
        var builder = URLComponents(string: Self.editorDomain)
        var queryItems = [URLQueryItem(name: "m", value: code)]
        
        if shareMode == .player {
            queryItems.insert(URLQueryItem(name: "p", value: nil), at: 0)
        }
        
        builder?.queryItems = queryItems

        return builder?.url
    }
}
