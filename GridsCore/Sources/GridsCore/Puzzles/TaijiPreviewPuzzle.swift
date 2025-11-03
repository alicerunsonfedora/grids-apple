//
//  TaijiPreviewPuzzle.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

#if canImport(SwiftUI)

import PuzzleKit
import SwiftUI

/// A view displaying a preview grid of a given puzzle.
///
/// This is typically used to show a basic representation of a puzzle, such as for a card or mockup.
public struct TaijiPreviewPuzzleView: View {
    /// The puzzle code the view renders.
    public var puzzleCode: String

    private var puzzle: PKTaijiPuzzle? { .init(decodingOrNull: puzzleCode) }
    private var size: CGSize { .init(width: puzzle?.width ?? 1, height: puzzle?.height ?? 1) }

    /// Creates a preview from the puzzle code
    /// - Parameter puzzleCode: The puzzle code to decode and render a preview of.
    public init(_ puzzleCode: String) {
        self.puzzleCode = puzzleCode
    }
    
    public var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<Int(size.height), id: \.self) { _ in
                GridRow {
                    ForEach(0..<Int(size.width), id: \.self) { _ in
                        Image(systemName: "square")
                    }
                }
            }
            .font(.subheadline)
            .imageScale(.medium)
            .foregroundStyle(.gray)
            .background(Color.white)
        }
    }
}

#Preview {
    TaijiPreviewPuzzleView("6:0Cw+CY0Aw0Cw+DDw0Sw+CDw0Bw+CCw0Tw+BSw+BUw0")
}

#if DEBUG
extension TaijiPreviewPuzzleView {
    var testHooks: TestHooks { TestHooks(target: self) }
    
    struct TestHooks {
        private let target: TaijiPreviewPuzzleView
        
        fileprivate init(target: TaijiPreviewPuzzleView) {
            self.target = target
        }

        func puzzleSize() async -> CGSize {
            await target.size
        }
    }
}
#endif

#endif
