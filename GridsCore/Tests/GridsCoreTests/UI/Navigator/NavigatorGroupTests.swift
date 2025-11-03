//
//  NavigatorGroupTests.swift
//  GridsCore
//
//  Created by Marquis Kurt on 25-01-2025.
//

import Testing
import SwiftUI
import ViewInspector
@testable import GridsCore

@MainActor
@Suite("Navigator group tests")
struct NavigatorGroupTests {
    @Test("View displays initial")
    func testViewDisplays() async throws {
        @Binding var selection: SampleNavigatorItem = .files
        let view = NavigatorGroup(selection: $selection)
        let sut: InspectableView<ViewType.AnyView> = try view.inspect().implicitAnyView()
        
        #expect(await view.testHooks.scale() == .large)
        
        let stack = try sut.hStack(0)
        #expect(try stack.spacing() == 12)

        let forEachGroup = try stack.forEach(0)
        #expect(forEachGroup.count == SampleNavigatorItem.allCases.count)
        
        for (child, item) in zip(forEachGroup, SampleNavigatorItem.allCases) {
            let button = try child.button()
            #expect(try button.tag() as? SampleNavigatorItem == item)
            #expect(try button.help().string() == item.help)

            let image = try button.labelView().image()
            let imageName = try image.actualImage().name()
            let imageColor = try image.foregroundStyleShapeStyle(Color.self)

            #expect(imageName.contains(item.symbol))
            if item == selection {
                #expect(imageName.hasSuffix(".fill"))
                #expect(imageColor == Color.accentColor)
            } else {
                #expect(!imageName.hasSuffix(".fill"))
                #expect(imageColor == Color.primary)
            }
        }
    }
}
