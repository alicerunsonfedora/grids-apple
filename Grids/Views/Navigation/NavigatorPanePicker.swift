//
//  NavigatorPanePicker.swift
//  Grids
//
//  Created by Marquis Kurt on 13-01-2025.
//

import SwiftUI

struct NavigatorPanePicker: View {
    @Binding var selection: GridEditorNavigator

    var body: some View {
        HStack(spacing: 12) {
            ForEach(GridEditorNavigator.allCases, id: \.self) { pane in
                Button {
                    selection = pane
                } label : {
                    Image(systemName: pane.icon + (selection == pane ? ".fill" : ""))
                        .foregroundStyle(
                            selection == pane ? Color.accentColor : Color.primary)
                        .imageScale(.large)
                        .help(pane.name)
                        .tag(pane)
                }
                .buttonStyle(.plain)
            }
            .labelStyle(.iconOnly)
        }
    }
}

#Preview {
    @Previewable @State var selection = GridEditorNavigator.puzzleSet
    
    List {
        Divider()
        NavigatorPanePicker(selection: $selection)
        Divider()
        
        ForEach(0..<5) { _ in
            Text("Do you remember the maze?")
        }
    }
    .listStyle(.sidebar)
}
