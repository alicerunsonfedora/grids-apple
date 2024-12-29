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

private enum EditorSymbol: Hashable, CaseIterable {
    case flower
    case dot
    case dash
    case slash
    case diamond

    var isValueDependent: Bool {
        switch self {
        case .flower, .dot:
            return true
        default:
            return false
        }
    }
    
    var icon: String {
        switch self {
        case .flower:
            "tree.fill"
        case .dot:
            "5.square"
        case .diamond:
            "diamond.fill"
        case .slash:
            "line.diagonal"
        case .dash:
            "minus"
        }
    }
}

struct GridEditorInspector: View {
    @Binding var document: WTPFile
    @State private var currentPane = GridEditorInspectorPane.currentTool
    @State private var symbol = EditorSymbol.diamond
    @State private var symbolValue = 1
    @State private var dotAdditive = true

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
                    Section("Symbol") {
                        Picker("Symbol", selection: $symbol) {
                            ForEach(EditorSymbol.allCases, id: \.self) { editorSymbol in
                                Label("\(editorSymbol)".capitalized, systemImage: editorSymbol.icon)
                                    .tag(editorSymbol)
                            }
                        }
                        Picker("Value", selection: $symbolValue) {
                            ForEach(0..<10) { value in
                                if (symbol == .flower && value <= 4) || (symbol == .dot && value > 0) {
                                    Text(value, format: .number)
                                        .tag(value)
                                }

                            }
                        }
                        .disabled(!symbol.isValueDependent)
                        
                        if symbol == .dot {
                            Toggle(isOn: $dotAdditive) {
                                Text("Additive")
                            }
                        }
                    }
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
}

#Preview {
    @Previewable @State var file = WTPFile()
    NavigationStack {
        GridEditorInspector(document: $file)
    }
}

