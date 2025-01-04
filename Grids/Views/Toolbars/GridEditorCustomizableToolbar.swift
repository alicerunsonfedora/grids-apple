//
//  GridEditorCustomizableToolbar.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import SwiftUI

struct MomentaryToggleButton<Label>: View where Label: View {
    var isActive: Bool
    
    var action: () -> Void
    var label: () -> Label
    
    var body: some View {
        if isActive {
            rootButton.buttonStyle(.borderedProminent)
        } else {
            rootButton
        }
    }
    
    private var rootButton: some View {
        Button(action: action, label: label)
    }
}

struct GridEditorCustomizableToolbar: CustomizableToolbarContent {
    @Binding var editorTool: EditorTool

    var body: some CustomizableToolbarContent {
        ToolbarItem(id: "tool.painter") {
            MomentaryToggleButton(isActive: editorTool == .symbolPainter) {
                editorTool = .symbolPainter
            } label: {
                Label("Symbol Painter", systemImage: "paintbrush")
            }
        }
        
        ToolbarItem(id: "tool.shaper") {
            MomentaryToggleButton(isActive: editorTool == .tileShaper) {
                editorTool = .tileShaper
            } label: {
                Label("Tile Shaper", systemImage: "square.dashed")
            }
        }

        ToolbarItem(id: "tool.flipper") {
            MomentaryToggleButton(isActive: editorTool == .tileFlipper) {
                editorTool = .tileFlipper
            } label: {
                Label("Tile Flipper", systemImage: "arrow.clockwise.square")
            }
        }
        
        ToolbarItem(id: "tool.eraser") {
            MomentaryToggleButton(isActive: editorTool == .eraser) {
                editorTool = .eraser
            } label: {
                Label("Symbol Eraser", systemImage: "eraser")
            }
        }

        ToolbarItem(id: "tool.preview") {
            Button(action: {}) {
                Label("Preview", systemImage: "arrowtriangle.forward")
            }
        }
    }
}
