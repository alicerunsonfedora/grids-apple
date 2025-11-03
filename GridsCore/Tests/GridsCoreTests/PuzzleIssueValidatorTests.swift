//
//  PuzzleIssueValidatorTests.swift
//  GridsCore
//
//  Created by Marquis Kurt on 24-01-2025.
//

import Foundation
import Testing
import PuzzleKit
@testable import GridsCore

@Suite("Puzzle issue validation tests")
struct PuzzleIssueValidatorTests {
    typealias Validator = PuzzleIssueValidator

    @Test("No violations")
    func testValidationNoViolations() async throws {
        let puzzle = PKTaijiPuzzle(size: .init(width: 3, height: 3))
        let issues = Validator.validate(puzzle)
        
        #expect(issues.isEmpty)
    }

    @Test("Layout inaccessible warning")
    func testValidationLayoutInaccessibleWarning() async throws {
        let puzzle = PKTaijiPuzzle(size: .init(width: 12, height: 7))
        let issues = Validator.validate(puzzle)
        
        #expect(issues.contains(.layoutInaccessible))
    }

    @Test("Layout too large error")
    func testValidationLayoutTooLarge() async throws {
        let puzzleSize = CGSize(width: 25, height: 25)
        let puzzle = PKTaijiPuzzle(size: puzzleSize)
        let issues = Validator.validate(puzzle)
        
        #expect(issues.contains(.layoutExceedsSize(puzzleSize)))
    }

    @Test("Uneven diamonds runtime warning")
    func testValidationUnevenDiamonds() async throws {
        let puzzle = try PKTaijiPuzzle(decoding: "7:0Sw+HSw+CJw+CSw+JJw+IJw0")
        let issues = Validator.validate(puzzle)
        
        #expect(issues.contains(.unevenDiamonds))
    }

    @Test("Negative dots runtime warning")
    func testValidationNegativeDots() async throws {
        let puzzle = try PKTaijiPuzzle(decoding: "7:0Sw+HSw+CJw+CSw+JJw+IJw0")
        let issues = Validator.validate(puzzle)
        
        #expect(issues.contains(.allNegativeDots))
    }
}
