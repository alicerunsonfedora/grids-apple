//
//  GridEditor.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI
import PuzzleKit

struct GridEditor: View {
    @Binding var file: WTPFile
    @State private var openDocInspector: Bool = false

    var body: some View {
        NavigationSplitView {
            VStack {
                ScrollView {
                    ForEach(Array(zip(file.document.puzzleCodes.indices, file.document.puzzleCodes)), id: \.0) { idx, code in
                        GridEditorSidebarEntry(document: $file, index: idx, code: code)
                        .onTapGesture {
                            file.jumpToPuzzleInSet(at: idx)
                        }
                    }
                }
                
                Spacer()
                Button {
                    withAnimation {
                        file.addPuzzleToSetAfterCurrentIndex()
                    }
                } label: {
                    Image(systemName: "plus")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .buttonStyle(.plain)
                .controlSize(.extraLarge)
            }
#if os(macOS)
            .frame(minWidth: 200, idealWidth: 250)
#endif
            
        } detail: {
            Group {
                if let puzzle = file.currentPuzzle {
                    TaijiPuzzle(puzzle: puzzle) { index in
                        withAnimation {
                            file.flipTileInCurrentPuzzle(at: index)
                        }
                    }
                }
            }
        }
#if os(macOS)
        .navigationSubtitle(file.document.name)
#endif
            .toolbar {
//                Button(action: {}) {
//                    Label("Tile Painter", systemImage: "paintbrush")
//                }
//                Button(action: {}) {
//                    Label("Eraser", systemImage: "eraser")
//                }
//                Button(action: {}) {
//                    Label("Preview", systemImage: "arrowtriangle.forward.fill")
//                }
            
                Button(action: { openDocInspector.toggle() }) {
                    Label("Inspector", systemImage: "sidebar.right")
                }
            }
            .inspector(isPresented: $openDocInspector) {
                GridEditorInspector(document: $file)
            }
    }
}

#Preview {
    @Previewable @State var file = WTPFile()
    GridEditor(file: $file)
}
