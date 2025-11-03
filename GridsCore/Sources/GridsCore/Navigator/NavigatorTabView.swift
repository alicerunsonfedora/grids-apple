//
//  NavigatorTabView.swift
//  GridsCore
//
//  Created by Marquis Kurt on 26-01-2025.
//

import SwiftUI

/// A protocol representing an item that has a default selection.
public protocol DefaultSelectionProvider: CaseIterable {
    /// The selection that acts as the default case.
    static var defaultSelection: Self { get }
}

/// A navigator item that can be used in navigator tab views.
///
/// Navigator tab items provide a default selection and must be sendable.
public typealias NavigatorTabItem = NavigatorItem & DefaultSelectionProvider & Sendable

/// A tab view used to display navigator panes.
public struct NavigatorTabView<N: NavigatorTabItem, D: View>: View where N.AllCases: RandomAccessCollection {
    @State private var selection: N
    private var navigatorItemType: N.Type
    private var tab: (N) -> D

    public init(for navigatorItemType: N.Type, selection: N = N.defaultSelection, content: @escaping (N) -> D) {
        self.navigatorItemType = navigatorItemType
        self.selection = selection
        self.tab = content
    }

    public var body: some View {
        Group {
            Divider()
            NavigatorGroup(selection: $selection)
            Divider()
            tab(selection)
        }
    }
}

#Preview {
    NavigatorTabView(for: SampleNavigatorItem.self) { tab in
        Group {
            switch tab {
            case .files:
                Text("Files!")
            case .issues:
                Image(systemName: "square.and.pencil")
            case .tests:
                ProgressView()
            }
            Spacer()
        }
    }
}

#if DEBUG
extension NavigatorTabView {
    var testHooks: TestHooks { TestHooks(target: self) }
    
    struct TestHooks {
        private let target: NavigatorTabView
        
        fileprivate init(target: NavigatorTabView) {
            self.target = target
        }

        func selection() async -> N {
            await target.selection
        }
    }
}
#endif
