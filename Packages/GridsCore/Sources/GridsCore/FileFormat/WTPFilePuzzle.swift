//
//  WTPFilePuzzle.swift
//  Grids
//
//  Created by Marquis Kurt on 29-12-2024.
//

import PuzzleKit

/// A structure used to map a puzzle code to an associated Taiji puzzle.
///
/// This structure is used internally allow users to manipulate Taiji puzzles and have them bound back to a puzzle code
/// when re-encoding the data into the document.
///
/// - SeeAlso: To see their usage within the WTP file structure, refer to ``WTPFile/puzzles``.
public struct WTPFilePuzzle: Identifiable {
    /// The file puzzle's unique identifier.
    ///
    /// This typically corresponds to its position in the list of puzzle codes.
    public var id: Int

    /// The puzzle code at the specified identifier.
    public var code: String

    /// The Taiji puzzle derived from the ``code``.
    ///
    /// This will typically be the puzzle structure that users interact with.
    public var puzzle: PKTaijiPuzzle?
}
