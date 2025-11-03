//
//  WTPFile+DocumentKit.swift
//  GridsCore
//
//  Created by Marquis Kurt on 03-11-2025.
//

import DocumentKit
import Foundation
import PuzzleKit

extension WTPFile: Document {
    public static let readableContentExtensions: [String]  = ["wtp"]
    public static let isPackageDocumentType: Bool = false

    public init(url: URL) throws {
        let data = try Data(contentsOf: url)

        guard let textContents = String(data: data, encoding: .utf8) else {
            throw CocoaError(.fileReadInapplicableStringEncoding)
        }
        let document = WTPDocument(reading: textContents)

        self.document = document
        currentPuzzle = try PKTaijiPuzzle(decoding: document.puzzleCodes.first ?? "1:0")
        currentPuzzleIndex = 0
        
    }

    public func write(to url: URL) throws {
        let encodedData = document.encoded()
        let data = encodedData.data(using: .utf8)
        try data?.write(to: url)
    }
}
