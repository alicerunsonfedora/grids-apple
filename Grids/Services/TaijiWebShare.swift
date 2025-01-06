//
//  TaijiWebShare.swift
//  Grids
//
//  Created by Marquis Kurt on 06-01-2025.
//

import Foundation
import PuzzleKit

struct TaijiWebShare {
    private static var editorDomain = "https://hiumee.github.io/react/taiji/"

    enum WebShareMode {
        case editor
        case player
    }
    
    var code: String
    var shareMode: WebShareMode = .editor
    
    init(encoding puzzle: PKTaijiPuzzle, mode shareMode: WebShareMode = .editor) {
        self.code = String(encoding: puzzle)
        self.shareMode = shareMode
    }

    func shareURL() -> URL? {
        var builder = URLComponents(string: Self.editorDomain)
        var queryItems = [URLQueryItem(name: "m", value: code)]
        
        if shareMode == .player {
            queryItems.insert(URLQueryItem(name: "p", value: nil), at: 0)
        }
        
        builder?.queryItems = queryItems

        return builder?.url
    }
}
