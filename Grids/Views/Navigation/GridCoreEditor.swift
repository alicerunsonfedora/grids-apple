//
//  GridCoreEditor.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import SwiftUI
import PuzzleKit

struct GridCoreEditor: View {
    enum DragDirection {
        case horizontal
        case vertical
    }

    enum LayoutOperation {
        case addColumn
        case addRow
        case removeColumn
        case removeRow
    }

    @Binding var puzzle: PKTaijiPuzzle
    var toolState: EditorState

    @State private var isDragging: DragDirection? = nil

    private let baseTileSize: CGFloat = 64
    
    var scale: CGFloat {
        switch (puzzle.width, puzzle.height) {
        case (20..., _), (_, 14...):
            return 0.5
        case (11..<20, _), (_, 7..<14):
            return 0.75
        default:
            return 1.0
        }
    }

    var body: some View {
        HStack {
            Spacer()
            TaijiPuzzle(scale: baseTileSize * scale, puzzle: puzzle) { tileIndex in
                performActionForTool(at: tileIndex)
            }
            .opacity(isDragging != nil ? 0 : 1)
            .border(isDragging != nil ? .accent : .clear, width: 2)
            .overlay {
                if isDragging != nil {
                    Text("\(puzzle.width) x \(puzzle.height)")
                        .font(.largeTitle)
                        .opacity(0.5)
                }
            }
            .overlay(alignment: .bottom) {
                if toolState.tool == .layoutEditor {
                    ZStack {
                        Capsule(style: .continuous)
                            .fill(isDragging == .vertical ? Color.accentColor : .secondary.opacity(0.5))
                            .frame(width: dragHandleSize.width,
                                   height: dragHandleSize.height)
                        Image(systemName: "line.3.horizontal")
                    }
                    .gesture(verticalDrag)
                    .offset(y: 4 + dragHandleSize.height)
                }
                
            }
            .overlay(alignment: .trailing) {
                if toolState.tool == .layoutEditor {
                    ZStack {
                        Capsule(style: .continuous)
                            .fill(isDragging == .horizontal ? Color.accentColor : .secondary.opacity(0.5))
                            .frame(width: dragHandleSize.height,
                                   height: dragHandleSize.width)
                        Image(systemName: "line.3.horizontal")
                            .rotationEffect(.degrees(90))
                    }
                    .gesture(horizontalDrag)
                    .offset(x: 8 + dragHandleSize.height)
                }
            }
            
            Spacer()
        }
        .animation(.bouncy, value: isDragging)
        .animation(.easeInOut, value: scale)
    }

    // MARK: - Drag Gestures
    private var dragHandleSize: CGSize {
        CGSize(width: 64, height: 16)
    }

    var horizontalDrag: some Gesture {
        DragGesture(minimumDistance: baseTileSize / 2)
            .onChanged { value in
                if isDragging == nil { isDragging = .horizontal }
                let shouldAddColumn = value.translation.width > 0
                if abs(value.translation.width) > (baseTileSize * scale) {
                    self.adjustLayout(shouldAddColumn ? .addColumn : .removeColumn)
                }

            }
            .onEnded { _ in
                isDragging = nil
            }
    }

    var verticalDrag: some Gesture {
        DragGesture(minimumDistance: baseTileSize / 2)
            .onChanged { value in
                if isDragging == nil { isDragging = .vertical }
                let shouldAddRow = value.translation.height > 0
                if abs(value.translation.height) > (baseTileSize * scale) {
                    self.adjustLayout(shouldAddRow ? .addRow : .removeRow)
                }
            }
            .onEnded { _ in
                isDragging = nil
            }
    }
    
    
    private func performActionForTool(at index: Int) {
        let coordinate = index.toCoordinate(wrappingAround: puzzle.width)
        switch toolState.tool {
        case .symbolPainter:
            self.puzzle = puzzle.replacingSymbol(at: coordinate, with: toolState.taijiTileSymbol)
        case .eraser:
            self.puzzle = puzzle.replacingSymbol(at: coordinate, with: nil)
        case .tileFlipper:
            self.puzzle = puzzle.flippingTile(at: coordinate)
        case .layoutEditor:
            self.puzzle = puzzle.applyingState(at: coordinate, with: toolState.shaperKind)
        }
    }

    private func adjustLayout(_ operation: LayoutOperation) {
        switch operation {
        case .addColumn:
            self.puzzle = self.puzzle.appendingColumn()
        case .addRow:
            self.puzzle = self.puzzle.appendingRow()
        case .removeColumn:
            guard self.puzzle.width > 1 else { return }
            self.puzzle = self.puzzle.removingLastColumn()
        case .removeRow:
            guard self.puzzle.height > 1 else { return }
            self.puzzle = self.puzzle.removingLastRow()
        }
    }
}

#Preview {
    @Previewable
    @State var puzzle = PKTaijiPuzzle(size: .init(width: 3, height: 3))
    
    @Previewable
    @State var editorToolState = EditorState()
    
    GridCoreEditor(puzzle: $puzzle, toolState: editorToolState)
}
