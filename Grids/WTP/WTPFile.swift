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
    var document: WTPDocument

    static var readableContentTypes: [UTType] { [.wtp] }

    init() {
        document = .init(name: "Untitled Puzzle", author: "Author", icon: .generic, puzzleCodes: [])
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        document = WTPDocument(reading: string)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encodedContents = document.encoded()
        let data = Data(encodedContents.utf8)
        
        return .init(regularFileWithContents: data)
    }
}
