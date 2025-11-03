import Adwaita
import Foundation
import PuzzleKit

struct WTPuzzlePreview: View {
    @State var puzzle: WTPuzzlePiece

    @State private var displayValidation = false
    @State private var validationMessage: String = ""
    @State private var solveState: Bool?

    var view: Body {
        VStack {
            Banner(validationMessage, visible: displayValidation)
            WTPuzzleGrid(puzzle: puzzle) { coordinate in
                puzzle.data = puzzle.data.flippingTile(at: coordinate)
            }
            .vexpand()
        }
        .topToolbar {
            HeaderBar.end {
                Button(Loc.checkPuzzle, icon: .custom(name: "check-plain")) {
                    validate()
                }
            }
            .headerBarTitle {
                Text("<b>\(Loc.previewPuzzle)</b>")
                    .useMarkup()
            }
        }
    }

    private func validate() {
        displayValidation = false
        let validator = PKTaijiPuzzleValidator(puzzle: puzzle.data)
        let result = validator.validate()
        switch result {
        case .success:
            validationMessage = Loc.solutionCorrect
        case .failure(let error):
            print(error)
            validationMessage = Loc.solutionIncorrect
        }
        displayValidation = true
    }
}
