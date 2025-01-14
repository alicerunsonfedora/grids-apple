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
    @AppStorage("build.showlive") var showLiveIssues = true

    @Binding var file: WTPFile
    @State private var selectedPuzzle: WTPFilePuzzle.ID?
    @State private var displayInspector = false
    @State private var toolState = EditorState()
    @State private var navigatorPane = GridEditorNavigator.puzzleSet
    @State private var issues = Set<Issue>()
    
    private let sidebarTip = PuzzleSetTip()
    
    var body: some View {
        NavigationSplitView {
            Divider()
            NavigatorPanePicker(selection: $navigatorPane)
            Divider()
            Group {
                switch navigatorPane {
                case .puzzleSet:
                    puzzleSetPane
                case .issues:
                    issuePane
                }
            }
            .frame(minWidth: 250, idealWidth: 280)
            
        } detail: {
            if selectedPuzzle == nil {
                ContentUnavailableView("Select a puzzle", systemImage: "square.grid.3x3")
            } else {
                GridCoreEditor(puzzle: $file.currentPuzzle, toolState: toolState)
            }
        }
        .navigationSubtitle(file.document.name)
        .onChange(of: selectedPuzzle ?? -1) { oldValue, newValue in
            guard (file.puzzles.startIndex...file.puzzles.endIndex).contains(newValue) else { return }
            self.issues.removeAll()
            file.currentPuzzleIndex = newValue
            if let newPuzzle = file.puzzles[newValue].puzzle {
                file.currentPuzzle = newPuzzle
                if showLiveIssues {
                    self.issues = PuzzleIssueValidator.validate(newPuzzle)
                }
            }
        }
        .onChange(of: file.currentPuzzle) { _, newPuzzle in
            if showLiveIssues {
                self.issues = PuzzleIssueValidator.validate(newPuzzle)
            }
        }
        .inspector(isPresented: $displayInspector) {
            GridEditorInspector(document: $file, toolState: $toolState)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { displayInspector.toggle() }) {
                    Label("Inspector", systemImage: "sidebar.right")
                }
            }
            ToolbarItem(placement: .status) {
                if issues.count > 0 {
                    Button {
                        navigatorPane = .issues
                    } label: {
                        IssueCounterView(issues: issues)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .toolbar {
            GridEditorToolbar(editorTool: $toolState.tool, puzzle: file.currentPuzzle)
        }
        .animation(.easeInOut, value: issues)
    }
    
    private var puzzleSetPane: some View {
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
        .overlay(alignment: .bottom) {
            VStack {
                Divider()
                HStack {
                    Button {
                        withAnimation {
                            file.addPuzzleToSetAfterCurrentIndex()
                        }
                    } label: {
                        Label("Add Puzzle", image: "square.grid.3x3.fill.badge.plus")
                    }
                }
                .padding(.vertical, 3)
                .padding(.bottom, 6)
                .buttonStyle(.plain)
                .labelStyle(.iconOnly)
            }
            .background(.thinMaterial)
        }
    }
    
    private var issuePane: some View {
        Group {
            if issues.isEmpty {
                Text("No Issues")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                    .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(Array(issues)) { issue in
                        IssueView(issue: issue)
                    }
                }
            }
        }
        
    }
}

#Preview {
    @Previewable @State var file = WTPFile()
    GridEditor(file: $file)
}
