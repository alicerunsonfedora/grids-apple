//
//  TaijiPuzzlePreviewTests.swift
//  GridsCore
//
//  Created by Marquis Kurt on 24-01-2025.
//

#if canImport(SwiftUI)

import Testing
import SwiftUI
import ViewInspector
@testable import GridsCore

@MainActor
@Suite("Puzzle preview tests")
struct TaijiPuzzlePreviewTests {
    @Test("Preview display")
    func testPreviewDisplay() async throws {
        let view = TaijiPreviewPuzzleView("3:+I")
        let sut = try view.inspect().implicitAnyView()

        #expect(await view.testHooks.puzzleSize() == .init(width: 3, height: 3))

        let grid = try sut.grid()
        #expect(try grid.forEach(0).count == 3)

        let forEachBlock = try grid.forEach(0)
        #expect(try forEachBlock.font() == .subheadline)
        #expect(try forEachBlock.foregroundStyleShapeStyle(Color.self) == .gray)
        #expect(try forEachBlock.background().color().value() == Color.white)
        
        let gridRow = try forEachBlock.gridRow(0)
        #expect(try gridRow.forEach(0).count == 3)

        let image = try gridRow.forEach(0)[0].image()
        #expect(try image.actualImage().name() == "square")
    }
}

#endif
