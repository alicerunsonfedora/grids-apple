import Foundation
import PuzzleKit

struct WTPuzzlePiece {
    var code: String
    var data: PKTaijiPuzzle {
        didSet {
            self.code = String(encoding: data)
        }
    }
}

extension WTPuzzlePiece {
    static let defaultUndefined = WTPuzzlePiece(
        code: "1:Tw0",
        data: PKTaijiPuzzle(
            size: CGSize(width: 1, height: 1)
        )
    )
}

extension WTPuzzlePiece: Identifiable {
    var id: String { code }
}

extension WTPuzzlePiece: CustomStringConvertible {
    var description: String { code }
}
