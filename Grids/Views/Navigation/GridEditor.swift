//
//  GridEditor.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI
import TipKit
import PuzzleKit

struct GridEditor: View {
    @Binding var file: WTPFile
    @State private var selectedPuzzle: WTPFilePuzzle.ID?
    @State private var displayInspector = false
    @State private var toolState = EditorToolState()

    private let sidebarTip = PuzzleSetTip()
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedPuzzle) {
                ForEach(file.puzzles) { puzzle in
                    GridEditorSidebarEntry(file: $file, puzzle: puzzle)
                }
                .onMove { from, to in
                    file.document.puzzleCodes.move(fromOffsets: from, toOffset: to)
                }
                TipView(sidebarTip)
                    .listRowBackground(Color.clear)
            }
            .listStyle(.sidebar)
            .toolbar {
                Button {
                    withAnimation {
                        file.addPuzzleToSetAfterCurrentIndex()
                    }
                } label: {
                    Label("Add Puzzle", image: "square.grid.3x3.fill.badge.plus")
                }
            }
#if os(macOS)
            .frame(minWidth: 200, idealWidth: 250)
#endif
            
        } detail: {
            if selectedPuzzle == nil {
                ContentUnavailableView("Select a puzzle", systemImage: "square.grid.3x3")
            } else {
                GridCoreEditor(puzzle: $file.currentPuzzle, toolState: toolState)
            }
        }
        .onChange(of: selectedPuzzle ?? -1) { oldValue, newValue in
            guard (file.puzzles.startIndex...file.puzzles.endIndex).contains(newValue) else { return }
            file.currentPuzzleIndex = newValue
            if let newPuzzle = file.puzzles[newValue].puzzle {
                file.currentPuzzle = newPuzzle
            }
        }
#if os(macOS)
        .navigationSubtitle(file.document.name)
#endif
        .inspector(isPresented: $displayInspector) {
            GridEditorInspector(document: $file, toolState: $toolState)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { displayInspector.toggle() }) {
                    Label("Inspector", systemImage: "sidebar.right")
                }
            }
        }
        .toolbar {
            GridEditorToolbar(editorTool: $toolState.tool, puzzle: file.currentPuzzle)
        }
    }
}

#Preview {
    @Previewable @State var file = WTPFile()
    GridEditor(file: $file)
}
