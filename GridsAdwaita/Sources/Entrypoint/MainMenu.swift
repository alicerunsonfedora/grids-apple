import Adwaita
import DocumentKit
import Foundation

struct MainMenu: View {
    @State private var displayAbout = false

    var app: AdwaitaApp
    var window: AdwaitaWindow
    var documentActions: DocumentActions<WTPuzzle>

    var view: Body {
        DocumentMainMenu(actions: documentActions, app: app, window: window)
            .additionalMenuContent {
                MenuSection {
                    MenuButton(Loc.about, window: false) {
                        displayAbout.toggle()
                    }
                }
            }
            .aboutDialog(
                visible: $displayAbout,
                app: Loc.appName,
                developer: "Marquis Kurt",
                version: "dev",
                icon: .custom(name: "net.marquiskurt.grids"),
                website: URL(string: "https://marquiskurt.itch.io/grids")!)
    }
}
