import Adwaita
import DocumentKit
import Foundation
import PuzzleKit

struct WTPGridEditor: View {
    enum Tool {
        case tileFlipper
        case symbolPainter
        case layoutManager
        case tileDecorator
        case symbolEraser

        var hasOptions: Bool {
            switch self {
            case .symbolEraser, .tileFlipper:
                return false
            default:
                return true
            }
        }
    }

    @Binding var puzzle: WTPuzzlePiece
    @Binding var path: NavigationStack<WTPNavigationPath>

    @State private var showInspector = true
    @State private var currentTool = Tool.symbolPainter

    @State private var currentSymbol = WTPSymbol.flower
    @State private var currentDecoration = WTPTileDecoration.normal
    @State private var symbolValue = 1
    @State private var symbolAlt = false

    var app: AdwaitaApp
    var window: AdwaitaWindow
    var documentActions: DocumentActions<WTPuzzle>

    var view: Body {
        WTPuzzleGrid(puzzle: puzzle) { point in
            activateTool(for: point)
        }
        .hexpand()
        .topToolbar {
            VStack {
                HeaderBar {
                    Button(icon: .custom(name: "checkerboard")) {
                        currentTool = .tileFlipper
                    }
                    .tooltip(Loc.tileFlipper)
                    Button(icon: .custom(name: "shapes")) {
                        currentTool = .symbolPainter
                    }
                    .raised(currentTool == .symbolPainter)
                    .tooltip(Loc.symbolPainter)
                    Button(icon: .default(icon: .viewGrid)) {
                        currentTool = .layoutManager
                    }
                    .raised(currentTool == .layoutManager)
                    .tooltip(Loc.layoutManager)
                    Button(icon: .custom(name: "selection-opaque-2")) {
                        currentTool = .tileDecorator
                    }
                    .raised(currentTool == .tileDecorator)
                    .tooltip(Loc.tileDecorator)
                    Button(icon: .custom(name: "eraser")) {
                        currentTool = .symbolEraser
                    }
                    .raised(currentTool == .symbolEraser)
                    .tooltip(Loc.symbolEraser)
                } end: {
                    MainMenu(app: app, window: window, documentActions: documentActions)
                    Button(icon: .default(icon: .mediaPlaybackStart)) {
                        path.push(.player(puzzle))
                    }
                    .tooltip(Loc.previewPuzzle)
                }
                .headerBarTitle {
                    Text("<b>\(Loc.editPuzzle)</b>")
                        .useMarkup()
                }
                if currentTool.hasOptions {
                    HStack {
                        WTPGridInspector(
                            tool: currentTool,
                            currentSymbol: $currentSymbol,
                            symbolValue: $symbolValue,
                            symbolAlt: $symbolAlt,
                            decoration: $currentDecoration,
                            puzzle: $puzzle.data)
                            .halign(.start)
                    }
                    .padding(10, [.leading, .trailing])
                    .style("toolbar")
                    .transition(.slideUpDown)
                }
            }
        }
        .topBarStyle(.raised)
        .navigationTitle(Loc.editPuzzle)
    }

    private func activateTool(for gridCoordinate: PKGridCoordinate) {
        switch currentTool {
        case .symbolPainter:
            switch currentSymbol {
            case .diamond:
                puzzle.data = puzzle.data.replacingSymbol(at: gridCoordinate, with: .diamond)
            case .slashdash:
                puzzle.data = puzzle.data.replacingSymbol(at: gridCoordinate, with: .slashdash(rotates: symbolAlt))
            case .flower:
                puzzle.data = puzzle.data.replacingSymbol(at: gridCoordinate, with: .flower(petals: symbolValue))
            case .dice:
                puzzle.data = puzzle.data.replacingSymbol(
                    at: gridCoordinate,
                    with: .dot(value: symbolValue, additive: !symbolAlt))
            }
        case .tileDecorator:
            switch currentDecoration {
            case .normal:
                puzzle.data = puzzle.data.applyingState(at: gridCoordinate, with: .normal)
            case .fixed:
                puzzle.data = puzzle.data.applyingState(at: gridCoordinate, with: .fixed)
            case .invisible:
                puzzle.data = puzzle.data.applyingState(at: gridCoordinate, with: .invisible)
            }
        case .symbolEraser:
            puzzle.data = puzzle.data.replacingSymbol(at: gridCoordinate, with: nil)
        case .tileFlipper:
            puzzle.data = puzzle.data.flippingTile(at: gridCoordinate)
        default:
            break
        }
    }
}
