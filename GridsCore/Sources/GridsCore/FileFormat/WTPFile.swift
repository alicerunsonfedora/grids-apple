//
//  WTPDocument.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import PuzzleKit
import SwiftUI
import UniformTypeIdentifiers

public extension UTType {
    /// The uniform type identifier associated with What the Taiij?! puzzle files (.wtp).
    static let wtp = UTType(exportedAs: "net.marquiskurt.wtpFile")
}

public extension PKTaijiPuzzle {
    /// Creates a puzzle, decoding a Taiji puzzle code or returning `nil` if decoding fails.
    ///
    /// - Warning: Using this initializer is generally not recommended. Refer to the PuzzleKit documentation for how to
    ///   initialize a puzzle from a code.
    /// - Parameter decode: The Taiji puzzle code to decode.
    init?(decodingOrNull decode: String) {
        do {
            self = try .init(decoding: decode)
        } catch {
            return nil
        }
    }
}

/// A file structure representing an open file for What the Taiji?! puzzle files.
public struct WTPFile: FileDocument {
    /// A convenience typealias referring to the index or pointer in a puzzle code list.
    public typealias Pointer = [PKTaijiPuzzle].Index

    /// The underlying document structure.
    public var document: WTPDocument

    /// The current puzzle being edited.
    public var currentPuzzle: PKTaijiPuzzle {
        didSet {
            let code = String(encoding: currentPuzzle)
            document.puzzleCodes[currentPuzzleIndex] = code
        }
    }

    /// The location of where the current puzzle is in the document's list of codes.
    public var currentPuzzleIndex: Pointer = 0

    public static var readableContentTypes: [UTType] { [.wtp] }

    /// A mapping of decoded puzzles in the file, accounting for their position in the file.
    public var puzzles: [WTPFilePuzzle] {
        document.puzzleCodes.enumerated().map { (index, code) in
            WTPFilePuzzle(id: index,
                          code: code,
                          puzzle: PKTaijiPuzzle(decodingOrNull: code))
        }
    }

    /// Creates an empty document with an empty 3x3 puzzle board.
    public init() {
        document = .init(name: "Untitled Puzzle", author: "Author", icon: .generic, puzzleCodes: ["3:+I"])
        currentPuzzle = PKTaijiPuzzle(size: .init(width: 3, height: 3))
        currentPuzzleIndex = 0
    }
    
    public init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        document = WTPDocument(reading: string)
        currentPuzzle = try PKTaijiPuzzle(decoding: document.puzzleCodes.first ?? "1:0")
        currentPuzzleIndex = document.puzzleCodes.startIndex
    }
    
    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encodedContents = document.encoded()
        let data = Data(encodedContents.utf8)
        
        return .init(regularFileWithContents: data)
    }

    // MARK: - Sets
    /// Sets the currently active puzzle to the one at the specified index.
    /// - Parameter index: The position to jump to in the file.
    public mutating func jumpToPuzzleInSet(at index: Int) {
        guard (document.puzzleCodes.startIndex...document.puzzleCodes.endIndex).contains(index) else { return }
        guard let newPuzzle = PKTaijiPuzzle(decodingOrNull: document.puzzleCodes[index]) else { return }
        currentPuzzleIndex = index
        currentPuzzle = newPuzzle
    }

    /// Creates a new 3x3 puzzle board after the current puzzle's position (``currentPuzzleIndex`` + 1).
    public mutating func addPuzzleToSetAfterCurrentIndex() {
        document.puzzleCodes.insert("3:+I", at: document.puzzleCodes.index(after: currentPuzzleIndex))
    }

    /// Removes the puzzle at the specified position.
    /// - Parameter index: The position of the puzzle to remove from the file.
    public mutating func removePuzzleFromSet(at index: Int) {
        guard document.puzzleCodes.count > 1 else { return }
        document.puzzleCodes.remove(at: index)
        if index == currentPuzzleIndex {
            currentPuzzleIndex = 0
            if let puzzle = PKTaijiPuzzle(decodingOrNull: document.puzzleCodes[0]) {
                currentPuzzle = puzzle
            }
        }
    }

    /// Retrieves the next puzzle in the set, relative to the current position.
    public func nextPuzzleInSet() -> (Pointer, PKTaijiPuzzle)? {
        let newIndex = document.puzzleCodes.index(after: currentPuzzleIndex)
        guard newIndex < document.puzzleCodes.count else { return nil }
        guard let newPuzzle = PKTaijiPuzzle(decodingOrNull: document.puzzleCodes[newIndex]) else { return nil }
        return (newIndex, newPuzzle)
    }

    /// Retrieves the previous puzzle in the set, relative to the current position.
    public func previousPuzzleInSet() -> (Pointer, PKTaijiPuzzle)? {
        let newIndex = document.puzzleCodes.index(before: currentPuzzleIndex)
        guard newIndex >= document.puzzleCodes.startIndex else { return nil }
        guard let newPuzzle = PKTaijiPuzzle(decodingOrNull: document.puzzleCodes[newIndex]) else { return nil }
        return (newIndex, newPuzzle)
    }
}
