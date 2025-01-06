//
//  TaijiWebShareTests.swift
//  Grids
//
//  Created by Marquis Kurt on 06-01-2025.
//

import Foundation
import Testing
import PuzzleKit
@testable import Grids

private let puzzle = PKTaijiPuzzle(size: CGSize(width: 3, height: 3))

@Suite("Taiji web share tests")
struct TaijiWebShareTests {
    @Test("URL constructs")
    func webShareURLConstructs() async throws {
        let shareProvider = TaijiWebShare(encoding: puzzle)
        let url = shareProvider.shareURL()

        #expect(url != nil)
        #expect(url?.absoluteString == "https://hiumee.github.io/react/taiji/?m=3:+I")
    }
    
    @Test("URL constructs as editor")
    func webShareURLConstructsAsEditor() async throws {
        let shareProvider = TaijiWebShare(encoding: puzzle, mode: .editor)
        let url = shareProvider.shareURL()

        #expect(url != nil)
        #expect(url?.absoluteString == "https://hiumee.github.io/react/taiji/?m=3:+I")
    }
    
    @Test("URL constructs as player")
    func webShareURLConstructsAsPlayer() async throws {
        let shareProvider = TaijiWebShare(encoding: puzzle, mode: .player)
        let url = shareProvider.shareURL()

        #expect(url != nil)
        #expect(url?.absoluteString == "https://hiumee.github.io/react/taiji/?p&m=3:+I")
    }
}
