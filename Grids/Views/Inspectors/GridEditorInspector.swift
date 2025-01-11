//
//  GridEditorInspector.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI

private enum GridEditorInspectorPane: Hashable, CaseIterable {
    case currentTool
    case document
    
    var name: String {
        switch self {
        case .currentTool:
            "Format"
        case .document:
            "Document"
        }
    }
    
    var icon: String {
        switch self {
        case .currentTool:
            "paintbrush"
        case .document:
            "document"
        }
    }
}

struct GridEditorInspector: View {
    @Binding var document: WTPFile
    @Binding var toolState: EditorState
    @State private var currentPane = GridEditorInspectorPane.currentTool
        
    var body: some View {
        Picker("", selection: $currentPane) {
            ForEach(GridEditorInspectorPane.allCases, id: \.self) { mode in
                Label(mode.name, systemImage: mode.icon)
                    .tag(mode)
            }
        }
        .pickerStyle(.segmented)
        .labelStyle(.iconOnly)
        .padding([.top, .leading, .trailing])
        
        Form {
            Group {
                switch currentPane {
                case .currentTool:
                    contextualForm
                case .document:
                    Group {
                        Section("Metadata") {
                            TextField("Name", text: $document.document.name)
                            TextField("Author", text: $document.document.author)
                            
                            Picker("Icon", selection: $document.document.icon) {
                                ForEach(WTPDocument.FileIcon.allCases) { icon in
                                    Text(icon.name).tag(icon, includeOptional: true)
                                }
                            }
                        }
                        
                        Section("Challenges") {
                            TextField("Timer (seconds)", value: $document.document.timer, format: .number)
                        }
                    }
                }
            }
            
        }
    }
    
    private var contextualForm: some View {
        Group {
            switch toolState.tool {
            case .symbolPainter:
                GridEditorSymbolToolInspector(toolState: $toolState)
            case .layoutEditor:
                GridEditorLayoutEditorInspector(toolState: $toolState)
            default:
                Text("No settings for active tool.")
                    .foregroundStyle(.secondary)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    @Previewable @State var file = WTPFile()
    @Previewable @State var toolState = EditorState()
    NavigationStack {
        GridEditorInspector(document: $file, toolState: $toolState)
    }
}

