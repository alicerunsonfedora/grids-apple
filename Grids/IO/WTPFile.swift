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
    var currentPuzzle: PKTaijiPuzzle? {
        didSet {
            if let currentPuzzle {
                let code = String(encoding: currentPuzzle)
                document.puzzleCodes[currentPuzzleIndex] = code
            }
        }
    }
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
        let encodedContents = document.encoded()
        let data = Data(encodedContents.utf8)
        
        return .init(regularFileWithContents: data)
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

    mutating func removePuzzleFromSet(at index: Int) {
        guard document.puzzleCodes.count > 1 else { return }
        document.puzzleCodes.remove(at: index)
        if index == currentPuzzleIndex {
            currentPuzzleIndex = 0
            currentPuzzle = PKTaijiPuzzle(decodingOrNull: document.puzzleCodes[0])
        }
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
