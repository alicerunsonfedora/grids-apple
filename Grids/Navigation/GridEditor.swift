//
//  GridEditor.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI
import PuzzleKit

enum EditorTool {
    case symbolPainter
    case tileShaper
    case tileFlipper
    case eraser
}

struct GridEditor: View {
    @Binding var file: WTPFile
    @State private var selectedPuzzle: WTPFilePuzzle.ID?
    @State private var puzzle: PKTaijiPuzzle?
    @State private var displayInspector = false
    @State private var currentTool: EditorTool = .tileFlipper

    private var puzzles: [WTPFilePuzzle] {
        file.document.puzzleCodes.enumerated().map { (index, code) in
            WTPFilePuzzle(id: index,
                          code: code,
                          puzzle: PKTaijiPuzzle(decodingOrNull: code))
        }
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $selectedPuzzle) {
                ForEach(puzzles) { puzzle in
                    GridEditorSidebarEntry(file: $file, puzzle: puzzle)
                }
                .onMove { from, to in
                    file.document.puzzleCodes.move(fromOffsets: from, toOffset: to)
                }
            }
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
            GridCoreEditor(puzzle: $puzzle, file: $file, editorTool: currentTool)
        }
        .onAppear {
            selectedPuzzle = file.document.puzzleCodes.startIndex
            file.currentPuzzleIndex = file.document.puzzleCodes.startIndex
        }
        .onChange(of: selectedPuzzle ?? -1) { oldValue, newValue in
            guard (0..<puzzles.count).contains(newValue) else { return }
            file.currentPuzzleIndex = newValue
            puzzle = puzzles[newValue].puzzle
            file.currentPuzzle = puzzles[newValue].puzzle
        }
        .onChange(of: puzzle) { oldValue, newValue in
            file.currentPuzzle = newValue
        }
#if os(macOS)
        .navigationSubtitle(file.document.name)
#endif
        .inspector(isPresented: $displayInspector) {
            GridEditorInspector(document: $file, editorTool: currentTool)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { displayInspector.toggle() }) {
                    Label("Inspector", systemImage: "sidebar.right")
                }
            }
        }
        .toolbar(id: "editor.tools") {
            GridEditorCustomizableToolbar(editorTool: $currentTool)
        }
    }
}

#Preview {
    @Previewable @State var file = WTPFile()
    GridEditor(file: $file)
}
