//
//  WTPFile+SwiftUI.swift
//  GridsCore
//
//  Created by Marquis Kurt on 03-11-2025.
//

import PuzzleKit

#if canImport(SwiftUI)
import SwiftUI
import UniformTypeIdentifiers

public extension UTType {
    /// The uniform type identifier associated with What the Taiij?! puzzle files (.wtp).
    static let wtp = UTType(exportedAs: "net.marquiskurt.wtpFile")
}

extension WTPFile: FileDocument {
    public static var readableContentTypes: [UTType] { [.wtp] }

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
}

#endif
