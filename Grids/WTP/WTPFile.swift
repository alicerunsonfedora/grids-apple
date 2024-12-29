//
//  WTPDocument.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import PuzzleKit
import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var wtp = UTType(exportedAs: "net.marquiskurt.wtpFile")
}

struct WTPFile: FileDocument {
    typealias Pointer = [PKTaijiPuzzle].Index
    var document: WTPDocument
    var currentPuzzle: PKTaijiPuzzle?
    var currentPuzzleIndex: Pointer = 0

    static var readableContentTypes: [UTType] { [.wtp] }

    init() {
        document = .init(name: "Untitled Puzzle", author: "Author", icon: .generic, puzzleCodes: ["3:+I"])
        currentPuzzle = PKTaijiPuzzle(decodingOrNull: "3:+I")
        currentPuzzleIndex = 0
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        document = WTPDocument(reading: string)
        currentPuzzle = try PKTaijiPuzzle(decoding: document.puzzleCodes.first ?? "1:0")
        currentPuzzleIndex = document.puzzleCodes.startIndex
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        guard let currentPuzzle else { throw CocoaError(.fileWriteUnknown) }

        var newDocument = document
        newDocument.puzzleCodes[currentPuzzleIndex] = String(encoding: currentPuzzle)
        
        let encodedContents = newDocument.encoded()
        let data = Data(encodedContents.utf8)
        
        return .init(regularFileWithContents: data)
    }

    mutating func flipTileInCurrentPuzzle(at index: Int) {
        guard let puzzle = currentPuzzle else { return }
        let coordinate = index.toCoordinate(wrappingAround: puzzle.width)
        currentPuzzle = puzzle.flippingTile(at: coordinate)
    }

    // MARK: - Sets
    mutating func jumpToPuzzleInSet(at index: Int) {
        guard (document.puzzleCodes.startIndex...document.puzzleCodes.endIndex).contains(index) else { return }
        guard let newPuzzle = PKTaijiPuzzle(decodingOrNull: document.puzzleCodes[index]) else { return }
        currentPuzzleIndex = index
        currentPuzzle = newPuzzle
    }

    mutating func addPuzzleToSetAfterCurrentIndex() {
        document.puzzleCodes.insert("3:+I", at: document.puzzleCodes.index(after: currentPuzzleIndex))
    }
    
    func nextPuzzleInSet() -> (Pointer, PKTaijiPuzzle)? {
        let newIndex = document.puzzleCodes.index(after: currentPuzzleIndex)
        guard newIndex < document.puzzleCodes.count else { return nil }
        guard let newPuzzle = PKTaijiPuzzle(decodingOrNull: document.puzzleCodes[newIndex]) else { return nil }
        return (newIndex, newPuzzle)
    }

    func previousPuzzleInSet() -> (Pointer, PKTaijiPuzzle)? {
        let newIndex = document.puzzleCodes.index(before: currentPuzzleIndex)
        guard newIndex >= document.puzzleCodes.startIndex else { return nil }
        guard let newPuzzle = PKTaijiPuzzle(decodingOrNull: document.puzzleCodes[newIndex]) else { return nil }
        return (newIndex, newPuzzle)
    }
}
