//
//  WTPDocument.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import PuzzleKit

struct WTPDocument {
    enum FileIcon: Int {
        case generic = 1
        case gardens = 2
    }
    var name: String
    var author: String
    var icon: FileIcon?
    var puzzleCodes: [String]
}

extension WTPDocument {
    init(reading contents: String) {
        var puzzleCodes = [String]()
        var icon: FileIcon? = nil
        var name: String = ""
        var author: String = ""

        let lines = contents.components(separatedBy: "\n")
        for line in lines {
            if line.starts(with: ";") { continue }
            let kvPairs = line.components(separatedBy: "=")
            guard kvPairs.count == 2, let key = kvPairs.first, let value = kvPairs.last else {
                continue
            }
            switch key {
            case "name":
                name = value
            case "author":
                author = value
            case "icon":
                let iconID = Int(value)
                icon = FileIcon(rawValue: iconID ?? 0)
            default:
                break
            }
        }

        self.name = name
        self.author = author
        self.icon = icon
        self.puzzleCodes = puzzleCodes
    }
}
