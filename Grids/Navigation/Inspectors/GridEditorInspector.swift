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
    @State private var currentPane = GridEditorInspectorPane.currentTool
    @State private var symbol = EditorSymbol.diamond
    @State private var symbolValue = 1
    @State private var dotAdditive = true
    
    var editorTool: EditorTool
    
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
            switch editorTool {
            case .symbolPainter:
                GridEditorSymbolToolInspector(
                    symbol: $symbol,
                    symbolValue: $symbolValue,
                    dotAdditive: $dotAdditive)
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
    NavigationStack {
        GridEditorInspector(document: $file, editorTool: .tileFlipper)
    }
}

