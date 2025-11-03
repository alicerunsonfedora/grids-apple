import DocumentKit
import Foundation
import PuzzleKit

struct WTPuzzle: Document {
    static var readableContentExtensions: [String] { ["wtp"] }

    var name: String
    var author: String
    var icon: WTPFileIcon
    var puzzles: [WTPuzzlePiece]
    var timer: Int = 0

    init(named name: String) {
        self.name = name
        self.author = "Author"
        self.icon = .generic
        self.puzzles = [
            WTPuzzlePiece(code: "1:0", data: PKTaijiPuzzle(size: CGSize(width: 1, height: 1)))
        ]
        self.timer = 0
    }

    init(url: URL) throws {
        var name = ""
        var author = ""
        var icon = WTPFileIcon.generic
        var timer = 0
        var puzzlesCodes = [String]()
        let data = try Data(contentsOf: url)

        guard let textContents = String(data: data, encoding: .utf8) else {
            throw CocoaError(.fileReadInapplicableStringEncoding)
        }
        let lines = textContents.components(separatedBy: "\n")
        for line in lines {
            if line.starts(with: ";") || line.isEmpty { continue }
            let kvPair = line.components(separatedBy: "=")
            guard kvPair.count == 2, let key = kvPair.first, let value = kvPair.last else {
                throw CocoaError(.fileReadCorruptFile)
            }
            switch key {
            case "name":
                name = value
            case "author":
                author = value
            case "icon":
                let iconID = Int(value) ?? 0
                icon = WTPFileIcon(rawValue: iconID) ?? .generic
            case "puzzle":
                let codes = value.components(separatedBy: ";")
                puzzlesCodes.append(contentsOf: codes)
            case "timer":
                timer = Int(value) ?? 0
            default:
                continue
            }
        }
        self.name = name
        self.author = author
        self.icon = icon
        self.timer = timer

        self.puzzles = puzzlesCodes.compactMap { code in
            guard let puzzle = try? PKTaijiPuzzle(decoding: code) else { return nil }
            return WTPuzzlePiece(code: code, data: puzzle)
        }
    }

    func write(to url: URL) throws {
        var textContent =
            """
            name=\(self.name)
            author=\(self.author)
            icon=\(self.icon.rawValue)
            """

        if timer > 0 {
            textContent += "\ntimer=\(timer)"
        }
        let codes = self.puzzles.map(\.code).joined(separator: ";")
        textContent += "\n\(codes)"

        let data = textContent.data(using: .utf8)
        try data?.write(to: url)
    }
}