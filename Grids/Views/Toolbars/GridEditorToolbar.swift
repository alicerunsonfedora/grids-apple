//
//  GridEditorCustomizableToolbar.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import SwiftUI
import TipKit


struct GridEditorToolbar: ToolbarContent {
    @Binding var editorTool: EditorTool
    
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
    }
}
