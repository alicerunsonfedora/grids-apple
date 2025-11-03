import Adwaita
import Foundation
import PuzzleKit

struct IntSize {
    var width: Int
    var height: Int
}

struct WTPGridInspector: View {
    var tool: WTPGridEditor.Tool

    @Binding var currentSymbol: WTPSymbol
    @Binding var symbolValue: Int
    @Binding var symbolAlt: Bool
    @Binding var decoration: WTPTileDecoration
    @Binding var puzzle: PKTaijiPuzzle

    @State private var symbVal = "0"

    var view: Body {
         switch tool {
            case .symbolPainter:
                symbolInspector
            case .layoutManager:
                layoutInspector
            case .tileDecorator:
                decoratorInspector
            default:
                Button(Loc.noOptions) {}
                    .insensitive(true)
                    .flat()
        }
    }

    private var symbolInspector: AnyView {
        HStack(spacing: 32) {
            HStack(spacing: 8) {
                Text("<b>\(Loc.puzzleSymbol)</b>: ")
                    .useMarkup()
                Menu(currentSymbol.localizedName) {
                    MenuButton(WTPSymbol.flower.localizedName, window: false) {
                        currentSymbol = .flower
                        symbolValue = min(4, symbolValue)
                    }
                    MenuButton(WTPSymbol.dice.localizedName, window: false) {
                        currentSymbol = .dice
                    }
                    MenuButton(WTPSymbol.slashdash.localizedName, window: false) {
                        currentSymbol = .slashdash
                    }
                    MenuButton(WTPSymbol.diamond.localizedName, window: false) {
                        currentSymbol = .diamond
                    }
                }
            }
            HStack(spacing: 8) {
                Text("<b>\(Loc.puzzleSymbolValue)</b>: ")
                    .useMarkup()
                HStack(spacing: 4) {
                    Text("\(symbolValue)")
                        .padding(4, [.trailing])
                    HStack {
                        Button(icon: .custom(name: "minus")) {
                            symbolValue = max(currentSymbol.variableMinValue, symbolValue - 1)
                        }
                        .insensitive(symbolValue == currentSymbol.variableMinValue)
                        Button(icon: .custom(name: "plus")) {
                            symbolValue = min(currentSymbol.variableMaxValue, symbolValue + 1)
                        }
                        .insensitive(symbolValue == currentSymbol.variableMaxValue)
                    }
                    .style("linked")
                }
                .numeric()
                .raised()
            }
            .insensitive(!currentSymbol.hasVariableValue)
            CheckButton()
                .active($symbolAlt)
                .label(currentSymbol.alternateStyleName)
                .insensitive(!currentSymbol.hasAlternateValue)
        }
    }

    private var layoutInspector: AnyView {
        HStack(spacing: 32) {
            HStack(spacing: 8) {
                Text("<b>\(Loc.sizeWidth)</b>: ")
                    .useMarkup()
                Stepper(value: .constant(puzzle.width), min: 1, max: 13)
                    .callbackPerformsEditing()
                    .onIncrement { _ in
                        puzzle = puzzle.appendingColumn()
                    }
                    .onDecrement { _ in
                        puzzle = puzzle.removingLastColumn()
                    }
            }
            HStack(spacing: 8) {
                Text("<b>\(Loc.sizeHeight)</b>: ")
                    .useMarkup()
                Stepper(value: .constant(puzzle.height), min: 1, max: 8)
                    .callbackPerformsEditing()
                    .onIncrement { _ in
                        puzzle = puzzle.appendingRow()
                    }
                    .onDecrement { _ in
                        puzzle = puzzle.removingLastRow()
                    }
            }
        }
    }

    private var decoratorInspector: AnyView {
        HStack(spacing: 32) {
            HStack(spacing: 8) {
                Text("<b>\(Loc.puzzleDecorationStyle)</b>: ")
                    .useMarkup()
                Menu(decoration.localizedName) {
                    MenuButton(WTPTileDecoration.normal.localizedName, window: false) {
                        decoration = .normal
                    }
                    MenuButton(WTPTileDecoration.fixed.localizedName, window: false) {
                        decoration = .fixed
                    }
                    MenuButton(WTPTileDecoration.invisible.localizedName, window: false) {
                        decoration = .invisible
                    }
                }
            }
        }
    }
}
