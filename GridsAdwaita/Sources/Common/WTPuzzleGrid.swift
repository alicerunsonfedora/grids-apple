import Adwaita
import Foundation
import PuzzleKit

struct WTPuzzleGrid: View {
    private enum Constants {
        static let tileSize = 64
    }

    var puzzle: WTPuzzlePiece

    var tileClicked: ((PKGridCoordinate) -> Void)?

    var view: Body {
        VStack(spacing: 16) {
            ForEach(Array(1...puzzle.data.height)) { y in
                ForEach(Array(1...puzzle.data.width), horizontal: true) { x in
                    let coordinate = PKGridCoordinate(x: x, y: y)
                    Box {
                        if let tile = puzzle.data.tile(at: coordinate), let symbol = tile.symbol {
                           Symbol(icon: .taijiSymbol(symbol))
                            .pixelSize(Constants.tileSize)
                        }

                    }
                    .onClick {
                        tileClicked?(coordinate)
                    }
                    .frame(minWidth: Constants.tileSize, minHeight: Constants.tileSize)
                    .frame(maxWidth: Constants.tileSize)
                    .frame(maxHeight: Constants.tileSize)
                    .padding(12)
                    .style("taiji-tile")
                    .style("active", active: tileActive(at: coordinate))
                    .style("fixed", active: tileFixed(at: coordinate))
                    .style("invisible", active: tileInvisible(at: coordinate))
                }
            }
        }
        .halign(.center)
        .valign(.center)
        .padding()
        .css {
            """
            .taiji-tile {
                background-color: #686868;
                outline: 4px solid #686868;
                outline-offset: 4px;
            }

            .active {
                background: #999999;
                outline-color: #999999;
            }

            .fixed {
                outline-style: dashed;
            }

            .invisible {
                background: transparent;
                outline-color: transparent;
            }
            """
        }
    }

    private func tileActive(at coordinate: PKGridCoordinate) -> Bool {
        guard let tile = puzzle.data.tile(at: coordinate) else { return false }
        return tile.filled
    }

    private func tileFixed(at coordinate: PKGridCoordinate) -> Bool {
        guard let tile = puzzle.data.tile(at: coordinate) else { return false }
        return tile.state == .fixed
    }

    private func tileInvisible(at coordinate: PKGridCoordinate) -> Bool {
        guard let tile = puzzle.data.tile(at: coordinate) else { return false }
        return tile.state == .invisible
    }
}
