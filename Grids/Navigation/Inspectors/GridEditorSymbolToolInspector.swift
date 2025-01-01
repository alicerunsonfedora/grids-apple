//
//  GridEditorSymbolToolInspector.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import PuzzleKit
import SwiftUI

struct GridEditorSymbolToolInspector: View {
    @Binding var toolState: EditorToolState

    var body: some View {
        Group {
            Picker("Symbol", selection: $toolState.symbol) {
                ForEach(EditorSymbol.allCases, id: \.self) { editorSymbol in
                    Label("\(editorSymbol)".capitalized, image: editorSymbol.icon)
                        .tag(editorSymbol)
                }
            }

            if toolState.symbol.isValueDependent {
                Section {
                    Picker("Value", selection: $toolState.value) {
                        ForEach(0..<10) { value in
                            if valueCanBeShown(value) {
                                Text(value, format: .number)
                                    .tag(value)
                            }
                            
                        }
                    }
                    .disabled(!toolState.symbol.isValueDependent)
                    
                    if toolState.symbol == .dot {
                        Toggle(isOn: $toolState.dotAdditive) {
                            Text("Additive")
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: toolState)
    }
    
    private func valueCanBeShown(_ value: Int) -> Bool {
        return switch toolState.symbol {
        case .flower:
            (0...4).contains(value)
        case .dot:
            (1...9).contains(value)
        default:
            false
        }
    }
}
