//
//  GridEditorInspector.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import GridsCore
import SwiftUI

private enum GridEditorInspectorPane: NavigatorItem, CaseIterable {
    case currentTool
    case document

    var id: String { self.name }
    
    var name: String {
        switch self {
        case .currentTool:
            String(localized: "Format")
        case .document:
            String(localized: "Document")
        }
    }
    
    var symbol: String {
        switch self {
        case .currentTool:
            "paintbrush"
        case .document:
            "document"
        }
    }

    var help: String {
        String(localized: "Show the \(name) inspector")
    }
}

struct GridEditorInspector: View {
    @Binding var document: WTPFile
    @Binding var toolState: EditorState
    @State private var currentPane = GridEditorInspectorPane.currentTool
        
    var body: some View {
        Divider()
        NavigatorGroup(selection: $currentPane, scale: .medium)
        Divider()
        
        Form {
            Group {
                switch currentPane {
                case .currentTool:
                    contextualForm
                case .document:
                    documentProperties
                }
            }
        }
    }

    private var documentProperties: some View {
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

