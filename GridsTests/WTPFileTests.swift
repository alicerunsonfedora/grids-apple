//
//  WTPFileTests.swift
//  Grids
//
//  Created by Marquis Kurt on 06-01-2025.
//

import Testing
import SwiftUI
import PuzzleKit
@testable import Grids

@Suite("WTP File")
struct WTPFileTests {
    @Test("Blank initializer matches")
    func initNoParameters() async throws {
        let file = WTPFile()
        #expect(file.document.name == "Untitled Puzzle")
        #expect(file.document.author == "Author")
        #expect(file.document.puzzleCodes.count > 0)
        #expect(file.currentPuzzle.tiles.count == 9)
        #expect(file.currentPuzzleIndex == file.document.puzzleCodes.startIndex)
    }
    
    @Test("Puzzles computed property")
    func filePuzzlesComputedProperty() async throws {
        let file = WTPFile()
        #expect(file.puzzles.count == 1)
        
        guard let firstPuzzle = file.puzzles.first else {
            Issue.record()
            return
        }
        
        #expect(firstPuzzle.id == 0)
        #expect(firstPuzzle.code == "3:+I")
        #expect(firstPuzzle.puzzle == file.currentPuzzle)
    }

    @Test("Mutating current puzzle")
    func fileUpdatesDocumentWhenChangingPuzzle() async throws {
        var file = WTPFile()
        file.currentPuzzle = file.currentPuzzle.replacingSymbol(at: .one, with: .diamond)
        
        #expect(file.document.puzzleCodes[0] == "3:S+I")
    }

    @Test("Puzzle inserts after current index")
    func fileInsertPuzzleAfterCurrentIndex() async throws {
        var file = WTPFile()
        file.addPuzzleToSetAfterCurrentIndex()
        
        #expect(file.document.puzzleCodes.count == 2)
        #expect(file.currentPuzzleIndex == 0)
    }
    
    @Test("Jump to puzzle at specified index")
    func fileJumpToPuzzleAtIndex() async throws {
        var file = WTPFile()
        file.currentPuzzle = file.currentPuzzle.flippingTile(at: .one)
        file.addPuzzleToSetAfterCurrentIndex()
        file.jumpToPuzzleInSet(at: 1)
        
        #expect(file.currentPuzzleIndex == 1)
        #expect(file.currentPuzzle.tile(at: .one)?.filled == false)
    }
    
    @Test("Puzzle removed at index")
    func filePuzzleRemovedAtSpecifiedIndex() async throws {
        var file = WTPFile()
        file.currentPuzzle = file.currentPuzzle.flippingTile(at: .one)
        file.addPuzzleToSetAfterCurrentIndex()
        file.jumpToPuzzleInSet(at: 1)
        
        file.removePuzzleFromSet(at: 0)
        #expect(file.document.puzzleCodes.count == 1)
    }
}
