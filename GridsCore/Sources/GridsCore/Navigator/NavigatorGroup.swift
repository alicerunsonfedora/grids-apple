//
//  NavigatorGroup.swift
//  GridsCore
//
//  Created by Marquis Kurt on 25-01-2025.
//

import SwiftUI


/// A view used to display navigator items and select a single item.
///
/// Navigator groups work similarly to the traditional SwiftUI picker view, styled to work like the navigator picker in
/// Xcode, CodeEdit, and similar tools.
public struct NavigatorGroup<T: NavigatorItem & CaseIterable>: View where T.AllCases: RandomAccessCollection {
    /// The currently selected navigator item.
    @Binding public var selection: T

    /// The scale at which to render the group's items in.
    public var scale: Image.Scale = .large

    public init(selection: Binding<T>, scale: Image.Scale = .large) {
        self._selection = selection
        self.scale = scale
    }

    public var body: some View {
        HStack(spacing: 12) {
            ForEach(T.allCases, id: \.id) { (pane: T) in
                Button {
                    selection = pane
                } label: {
                    Image(systemName: pane.symbol + (selection == pane ? ".fill" : ""))
                        .foregroundStyle(
                            selection == pane ? Color.accentColor : Color.primary)
                        .imageScale(scale)
                }
                .help(pane.help)
                .tag(pane)
            }
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
    }
}

#Preview {
    @Previewable @State var selection = SampleNavigatorItem.files

    VStack {
        Divider()
        NavigatorGroup(selection: $selection)
        Divider()
        Text("Foo")
    }
    
}

#if DEBUG
// MARK: - Test Hooks

extension NavigatorGroup {
    var testHooks: TestHooks { TestHooks(target: self) }
    
    struct TestHooks {
        private let target: NavigatorGroup
        
        fileprivate init(target: NavigatorGroup) {
            self.target = target
        }
        
        func scale() async -> Image.Scale {
            target.scale
        }
    }
}
#endif
