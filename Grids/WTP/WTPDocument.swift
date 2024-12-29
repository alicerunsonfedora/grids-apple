//
//  WTPDocument.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import PuzzleKit

struct WTPDocument {
    enum FileIcon: Int, Identifiable {
        case generic = 1
        case gardens = 2
        case mill = 3
        case mines = 4
        case shrine = 5
        case challenge = 7
        case set = 9
        case tutorial = 10

        var name: String {
            switch self {
            case .generic:
                "Generic"
            case .gardens:
                "Gardens"
            case .mill:
                "Mill"
            case .mines:
                "Mines"
            case .shrine:
                "Shrine"
            case .challenge:
                "Challenge"
            case .set:
                "Puzzle Set"
            case .tutorial:
                "Tutorial"
            }
        }

        var id: Int {
            self.rawValue
        }
    }
    var name: String
    var author: String
    var icon: FileIcon
    var puzzleCodes: [String]
    var timer: Int = 0
}

extension WTPDocument.FileIcon: CaseIterable {}

extension WTPDocument {
    init(reading contents: String) {
        var puzzleCodes = [String]()
        var icon: FileIcon = .generic
        var name: String = ""
        var author: String = ""
        var timer = 0

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
                icon = FileIcon(rawValue: iconID ?? 0) ?? .generic
            case "puzzle":
                let puzzles = value.components(separatedBy: ";")
                puzzleCodes.append(contentsOf: puzzles)
            case "timer":
                timer = Int(value) ?? 0
            default:
                break
            }
        }

        self.name = name
        self.author = author
        self.icon = icon
        self.puzzleCodes = puzzleCodes
        self.timer = timer
    }

    func encoded() -> String {
        var file =
        """
        name=\(self.name)
        author=\(self.author)
        icon=\(self.icon.rawValue)
        """

        if timer > 0 {
            file += "\ntimer=\(timer)"
        }
        
        let puzzlecode = puzzleCodes.joined(separator: ";")
        file += "\npuzzle=\(puzzlecode)"
        
        return file
    }
}
