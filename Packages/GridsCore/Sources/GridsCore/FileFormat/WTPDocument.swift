//
//  WTPDocument.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI

/// A structure representing the What the Taiji?! puzzle file format (.wtp).
///
/// WTP files are typically stored as plain-text files with simple key-value pairs:
/// ```
/// name=Geschlossene Erinnerungen
/// author=Lorelei Weiss
/// icon=2
/// puzzle=6:644+B26Tw640Uw22644+B2
/// ```
///
/// This structure can be treated as if it were a `Codable` struct. For the file type that is handled with SwiftUI,
/// see ``WTPFile``.
public struct WTPDocument: Sendable {
    /// An enumeration representing the various icon types available.
    public enum FileIcon: Int, Identifiable, Sendable, CaseIterable {
        /// A generic file icon.
        case generic = 1
        
        /// A flower icon representing the Gardens section of Taiji.
        case gardens = 2
        
        /// A slashdash icon representing the Mill section of Taiji.
        case mill = 3
        
        /// A diamond icon representing the Mines section of Taiji.
        case mines = 4
        
        /// A five dot icon representing the Shrine section of Taiji.
        case shrine = 5
        
        /// A race flag representing a puzzle challenge.
        case challenge = 7
        
        /// A set of curly braces representing a puzzle set.
        case set = 9
        
        /// A graduation cap representing a tutorial.
        case tutorial = 10
        
        /// The human-friendly name of the icon.
        public var name: LocalizedStringKey {
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
        
        /// The file icon's unique identifier.
        public var id: Int {
            self.rawValue
        }
    }

    /// The file's name.
    public var name: String

    /// The author that created the puzzle.
    public var author: String

    /// The icon that appears in the puzzle picker.
    public var icon: FileIcon

    /// The Taiji puzzle codes that consist of this puzzle file.
    public var puzzleCodes: [String]

    /// The duration for the challenge timer.
    ///
    /// When set to 0, the timer will be off.
    public var timer: Int = 0
}

public extension WTPDocument {
    /// Creates a document from a string value.
    /// - Parameter contents: The contents of the string value to decode from.
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

    /// Encodes the current document into a string value.
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
