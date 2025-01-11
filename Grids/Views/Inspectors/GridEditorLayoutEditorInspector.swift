//
//  GridEditorTileShaperInspector.swift
//  Grids
//
//  Created by Marquis Kurt on 02-01-2025.
//

import PuzzleKit
import SwiftUI

extension PKTaijiTileState: @retroactive CaseIterable {
    public static var allCases: [PKTaijiTileState] {
        [.normal, .invisible, .fixed]
    }

    var name: String {
        switch self {
        case .normal:
            "Normal"
        case .fixed:
            "Locked"
        case .invisible:
            "Invisible"
        }
    }
    
    var icon: String {
        switch self {
        case .normal:
            "square"
        case .fixed:
            "square.dashed"
        case .invisible:
            "square.slash"
        }
    }
}

struct GridEditorLayoutEditorInspector: View {
    @Binding var toolState: EditorState

    var body: some View {
        Group {
            Picker("Style", selection: $toolState.shaperKind) {
                ForEach(PKTaijiTileState.allCases, id: \.self) { editorSymbol in
                    Label("\(editorSymbol)".localizedCapitalized, systemImage: editorSymbol.icon)
                        .tag(editorSymbol)
                }
            }
        }
        .animation(.easeInOut, value: toolState)
    }
}

#Preview {
    @Previewable @State var editorState = EditorState()
    Form {
        GridEditorLayoutEditorInspector(toolState: $editorState)
    }
    .frame(minHeight: 100)
}
