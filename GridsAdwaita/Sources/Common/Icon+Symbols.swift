import Adwaita
import PuzzleKit

extension Icon {
    static func taijiSymbol(_ taijiSymbol: PKTaijiTileSymbol) -> Self {
        switch taijiSymbol {
        case let .flower(petals):
            return .custom(name: "taiji-flower-\(petals)")
        case let .dot(value, additive):
            return .custom(name: additive ? "taiji-dice-plus-\(value)" : "taiji-dice-minus-\(value)")
        case let .slashdash(rotates):
            return .custom(name: rotates ? "taiji-slash" : "taiji-dash")
        case .diamond:
            return .custom(name: "taiji-diamond")
        }
    }
}