//
//  IssueCounterViewTests.swift
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
@Suite("Issue counter view tests")
struct IssueCounterViewTests {
    @Test("Nothing displayed when empty")
    func testEmptyViewWithNoIssues() async throws {
        let view = IssueCounterView(issues: [])
        let sut = try view.inspect().implicitAnyView().hStack()

        async let issueTypes = await [view.testHooks.errors(),
                                      view.testHooks.warnings(),
                                      view.testHooks.runtimeWarnings()]

        #expect(await issueTypes.allSatisfy({ $0 == 0 }))
        #expect(sut.allSatisfy({ $0.isAbsent }))
    }

    @Test("Counter displays for all issue types")
    func testViewShowsAllCounters() async throws {
        let view = IssueCounterView(
            issues: [.allNegativeDots, .layoutInaccessible, .layoutExceedsSize(.init(width: 99, height: 99))]
        )
        let sut = try view.inspect().implicitAnyView().hStack()

        async let issueTypes = await [view.testHooks.errors(),
                                      view.testHooks.warnings(),
                                      view.testHooks.runtimeWarnings()]

        #expect(await issueTypes.allSatisfy({ $0 == 1 }))

        let counterExpectations = [
            ("exclamationmark.triangle.fill", Color.yellow, "1"),
            ("xmark.octagon.fill", Color.red, "1"),
            ("exclamationmark.shield.fill", Color.purple, "1")
        ]

        for (index, counter) in sut.enumerated() {
            let (expectedName, expectedColor, expectedText) = counterExpectations[index]
            let image = try counter[0].image().actualImage()
            let color = try counter[0].image().foregroundStyleShapeStyle(Color.self)
            let text = try counter[1].text()

            #expect(try image.name() == expectedName)
            #expect(color == expectedColor)
            #expect(try text.string() == expectedText)
        }
    }

    @Test("Counter displays conditional issues", arguments: zip([
            [GridsCore.Issue.layoutInaccessible],
            [GridsCore.Issue.allNegativeDots, GridsCore.Issue.unevenDiamonds],
            [GridsCore.Issue.layoutExceedsSize(.init(width: 99, height: 99))]
        ], [0, 2, 1]))
    func testConditionalCounterView(issues: Set<GridsCore.Issue>, issueIndex: Int) async throws {
        let view = IssueCounterView(issues: issues)
        let sut = try view.inspect().implicitAnyView().hStack()

        let intendedCounter = try sut.tupleView(issueIndex)
        #expect(!intendedCounter.isAbsent)

        #expect(sut.count(where: \.isAbsent) == 2)
    }
}

#endif
