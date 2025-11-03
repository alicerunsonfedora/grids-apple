import Foundation
import PuzzleKit

enum WTPSymbol {
    case flower
    case dice
    case slashdash
    case diamond

    var hasAlternateValue: Bool {
        switch self {
        case .dice, .slashdash:
            return true
        default:
            return false
        }
    }

    var hasVariableValue: Bool {
        switch self {
        case .dice, .flower:
            return true
        default:
            return false
        }
    }

    var localizedName: String {
        switch self {
        case .flower: "Flower"
        case .dice: "Dice"
        case .slashdash: "Slash/Dash"
        case .diamond: "Diamond"
        }
    }

    var alternateStyleName: String {
        switch self {
        case .dice: "Subtractive"
        case .slashdash: "Rotatable"
        default: "Alternate Style"
        }
    }

    var variableMinValue: Int {
        switch self {
        case .flower:
            return 0
        case .dice:
            return 1
        default:
            return 0
        }
    }

    var variableMaxValue: Int {
        switch self {
        case .flower:
            return 4
        case .dice:
            return 9
        default:
            return 0
        }
    }
}

extension WTPSymbol: CaseIterable, Identifiable {
    var id: Self { self }
}


extension WTPSymbol {
    init(taijiSymbol: PKTaijiTileSymbol) {
        switch taijiSymbol {
        case .flower:
            self = .flower
        case .dot:
            self = .dice
        case .diamond:
            self = .diamond
        case .slashdash:
            self = .slashdash
        }
    }
}