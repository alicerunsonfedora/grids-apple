//
//  WTPDocument.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var wtp = UTType(exportedAs: "net.marquiskurt.wtpFile")
}

struct WTPFile: FileDocument {
    var fileContents: String
    var document: WTPDocument

    static var readableContentTypes: [UTType] {
        [
            .wtp
        ]
    }

    init() {
        fileContents = ""
        document = .init(name: "Untitled Puzzle", author: "Author", puzzleCodes: [])
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        fileContents = string
        document = WTPDocument(reading: string)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(fileContents.utf8)
        return .init(regularFileWithContents: data)
    }
}
