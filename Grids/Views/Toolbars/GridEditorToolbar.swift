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
    @Binding var editorTool: EditorTool
    var puzzle: PKTaijiPuzzle
    
    var body: some ToolbarContent {
        ToolbarItem(id: "tool.editorgroup", placement: .secondaryAction) {
            Picker("", selection: $editorTool) {
                ForEach(EditorTool.allCases, id: \.self) { tool in
                    Label(tool.name, systemImage: tool.systemImage)
                        .tag(tool)
                }
            }
            .pickerStyle(.segmented)
        }
        
        ToolbarItem(id: "tool.preview", placement: .primaryAction) {
            Button {
                
            } label: {
                Label("Preview", systemImage: "play.fill")
            }
        }

        ToolbarItem(id: "tool.quickshare") {
            if let link = TaijiWebShare(encoding: puzzle).shareURL() {
                ShareLink(item: link) {
                    Label("Quick Share", image: "square.and.arrow.up.badge.sparkles")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var editorTool = EditorTool.layoutEditor
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
