// The Swift Programming Language
// https://docs.swift.org/swift-book

import Adwaita
import DocumentKit
import Foundation

@main
struct Grids: App {
    let app = AdwaitaApp(id: "net.marquiskurt.grids")

    var scene: Scene {
        Window(id: "main") { window in
           RawDocumentGroup(newDocument: WTPuzzle(named: Loc.untitledPuzzle)) { file, actions in
                WTPDocumentEditor(
                    document: file.$document,
                    app: app,
                    window: window,
                    documentActions: actions)
           }
        }
        .defaultSize(width: 800, height: 600)
        #if DEBUG
            .devel()
        #endif
    }
}
