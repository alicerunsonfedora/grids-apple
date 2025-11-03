import Adwaita
import Foundation
import PuzzleKit

enum WTPNavigationPath {
    case editor(Binding<WTPuzzlePiece>)
    case player(WTPuzzlePiece)
}

extension WTPNavigationPath: Identifiable {
    var id: String { description }
}

extension WTPNavigationPath: CustomStringConvertible {
    var description: String {
        switch self {
        case let .editor(puzzle):
            return "Editing: \(puzzle.data)"
        case let .player(puzzle):
            return "Playing: \(puzzle.data)"
        }
    }
}