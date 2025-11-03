//
//  IssueViewTests.swift
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
@Suite("Issue view tests")
struct IssueViewTests {
    @Test("Disclosure group hides without description")
    func testViewOnlyDisplaysLabelWithoutDescription() async throws {
        let issue = GridsCore.Issue("Boo!", id: "tests.boo", severity: .error)
        let view = IssueView(issue: issue)
        let sut = try view.inspect().implicitAnyView()
        
        #expect(throws: InspectionError.self) {
            try sut.disclosureGroup()
        }
        
        let label = try sut.find(text: issue.text)
        let numberOfLines = try label.lineLimit()
        let fontWeight = try label.attributes().fontWeight()
        #expect(fontWeight == .medium)
        #expect(numberOfLines == 3)
        
        let symbol = await view.testHooks.symbol()
        #expect(symbol == "xmark.octagon.fill")

        let symbolColor = await view.testHooks.symbolColor()
        #expect(symbolColor == .red)
    }
    
    @Test("Warning content matches styling")
    func testWarningContentMatches() async throws {
        let issue = GridsCore.Issue.layoutInaccessible
        let view = IssueView(issue: issue)
        let sut = try view.inspect().implicitAnyView()
        
        #expect(throws: Never.self) {
            try sut.disclosureGroup()
        }

        let label = try sut.disclosureGroup().find(text: issue.text)
        let numberOfLines = try label.lineLimit()
        let fontWeight = try label.attributes().fontWeight()
        #expect(fontWeight == .medium)
        #expect(numberOfLines == 3)
        
        let symbol = await view.testHooks.symbol()
        #expect(symbol == "exclamationmark.triangle.fill")

        let symbolColor = await view.testHooks.symbolColor()
        #expect(symbolColor == .yellow)
    }

    @Test("Error content matches styling")
    func testErrorContentMatches() async throws {
        let issue = GridsCore.Issue.layoutExceedsSize(.init(width: 99, height: 99))
        let view = IssueView(issue: issue)
        let sut = try view.inspect().implicitAnyView()
        
        #expect(throws: Never.self) {
            try sut.disclosureGroup()
        }

        let label = try sut.disclosureGroup().find(text: issue.text)
        let numberOfLines = try label.lineLimit()
        let fontWeight = try label.attributes().fontWeight()
        #expect(fontWeight == .medium)
        #expect(numberOfLines == 3)
        
        let symbol = await view.testHooks.symbol()
        #expect(symbol == "xmark.octagon.fill")

        let symbolColor = await view.testHooks.symbolColor()
        #expect(symbolColor == .red)
    }

    @Test("Runtime warning content matches styling")
    func testRuntimeWarningContentMatches() async throws {
        let issue = GridsCore.Issue.unevenDiamonds
        let view = IssueView(issue: issue)
        let sut = try view.inspect().implicitAnyView()
        
        #expect(throws: Never.self) {
            try sut.disclosureGroup()
        }

        let label = try sut.disclosureGroup().find(text: issue.text)
        let numberOfLines = try label.lineLimit()
        let fontWeight = try label.attributes().fontWeight()
        #expect(fontWeight == .medium)
        #expect(numberOfLines == 3)
        
        let symbol = await view.testHooks.symbol()
        #expect(symbol == "exclamationmark.shield.fill")

        let symbolColor = await view.testHooks.symbolColor()
        #expect(symbolColor == .purple)
    }
}

#endif
