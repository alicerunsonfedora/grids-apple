//
//  GridEditorSymbolToolInspector.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import PuzzleKit
import SwiftUI

struct GridEditorSymbolToolInspector: View {
    @Binding var symbol: EditorSymbol
    @Binding var symbolValue: Int
    @Binding var dotAdditive: Bool

    var body: some View {
        Group {
            Picker("Symbol", selection: $symbol) {
                ForEach(EditorSymbol.allCases, id: \.self) { editorSymbol in
                    Label("\(editorSymbol)".capitalized, image: editorSymbol.icon)
                        .tag(editorSymbol)
                }
            }

            if symbol.isValueDependent {
                Section {
                    Picker("Value", selection: $symbolValue) {
                        ForEach(0..<10) { value in
                            if valueCanBeShown(value) {
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
            }
        }
        .animation(.easeInOut, value: symbol)
    }
    
    private func valueCanBeShown(_ value: Int) -> Bool {
        return switch symbol {
        case .flower:
            (0...4).contains(value)
        case .dot:
            (1...9).contains(value)
        default:
            false
        }
    }
}
