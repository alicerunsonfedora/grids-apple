//
//  GridEditorCustomizableToolbar.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import PuzzleKit
import SwiftUI
import TipKit

struct GridEditorToolbar: ToolbarContent {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.openWindow) private var openWindow
    @Binding var editorTool: EditorState.Tool
    var puzzle: PKTaijiPuzzle
    
    var body: some ToolbarContent {
        ToolbarItem(id: "tool.editorgroup", placement: .secondaryAction) {
            #if os(macOS)
            toolPicker
                .pickerStyle(.segmented)
            #else
            if horizontalSizeClass == .compact {
                toolPicker
                    .pickerStyle(.menu)
            } else {
                toolPicker
                    .pickerStyle(.segmented)
            }
            #endif
        }
        
        ToolbarItem(id: "tool.preview", placement: .primaryAction) {
            Button {
                openWindow(id: "player", value: puzzle)
            } label: {
                Label("Preview", systemImage: "play.fill")
            }
        }

        ToolbarItem(id: "tool.quickshare") {
            if let link = TaijiWebShare(encoding: puzzle).shareURL() {
                ShareLink(item: link) {
                    Label("Quick Share", image: "square.and.arrow.up.badge.sparkles")
                }
                .popoverTip(QuickShareTip(), arrowEdge: .bottom)
            }
        }
    }

    private var toolPicker: some View {
        Picker("Current Tool", selection: $editorTool) {
            ForEach(EditorState.Tool.allCases, id: \.self) { tool in
                Label(tool.name, systemImage: tool.systemImage)
                    .tag(tool)
            }
        }
    }
}

#Preview {
    @Previewable @State var editorTool = EditorState.Tool.layoutEditor
    NavigationStack {
        Text("Foo")
            .padding()
    }
    .navigationTitle("Grids")
    .frame(minWidth: 500, minHeight: 200)
    .toolbar {
        GridEditorToolbar(editorTool: $editorTool, puzzle: .init(size: CGSize(width: 3, height: 3)))
    }
}
