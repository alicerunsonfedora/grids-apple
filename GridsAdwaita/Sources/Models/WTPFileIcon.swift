import Foundation

enum WTPFileIcon: Int, Identifiable, Sendable, CaseIterable {
    case generic = 1
    case gardens = 2
    case mill = 3
    case mines = 4
    case shrine = 5
    case challenge = 7
    case `set` = 9
    case tutorial = 10

    public var name: String {
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

    public var id: Int {
        self.rawValue
    }
}