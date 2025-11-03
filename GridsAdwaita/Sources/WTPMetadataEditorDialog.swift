import Adwaita
import Foundation

enum WTPEditorMetadataMode {
    case name
    case author
    case icon
}

struct WTPEditorMetadataDialog: View {
    @Binding var document: WTPuzzle
    @Binding var isVisible: Bool

    var mode: WTPEditorMetadataMode

    var view: Body {
        VStack {
            switch mode {
            case .name:
                VStack(spacing: 16) {
                    Text(Loc.metadataNameDescription)
                        .wrap()
                    Entry(Loc.puzzleName, text: $document.name)
                }
            case .author:
                VStack(spacing: 16) {
                    Text(Loc.metadataAuthorDescription)
                        .wrap()
                    Entry(Loc.puzzleAuthor, text: $document.author)
                }
            case .icon:
                ScrollView {
                    Text(Loc.metadataIconDescription)
                        .wrap()
                        .padding(16, .bottom)
                    List(WTPFileIcon.allCases) { icon in
                        ActionRow()
                            .title(icon.name)
                            .subtitle(document.icon == icon ? Loc.selectedState: "")
                            .prefix {
                                Symbol(icon: .custom(name: "fileicon-type-\(icon.rawValue)"))
                                    .pixelSize(32)
                            }
                            .activatableWidget {
                                Button()
                                    .activate {
                                        document.icon = icon
                                    }
                            }
                    }
                    .boxedList()
                    .valign(.start)
                    .style("boxed-list")
                }
                .frame(minHeight: 300)
            }
        }
        .hexpand()
        .valign(.start)
        .frame(minWidth: 340, minHeight: 76)
        .frame(maxWidth: 500)
        .frame(maxHeight: 450)
        .padding()
        .topToolbar {
            HeaderBar.end {
                Button(Loc.doneButton) {
                    isVisible.toggle()
                }
                .suggested()
            }
            .showEndTitleButtons(false)
            .showStartTitleButtons(false)
            .headerBarTitle {
                switch mode {
                case .name:
                    WindowTitle(subtitle: "", title: Loc.metadataNameTitle)
                case .author:
                    WindowTitle(subtitle: "", title: Loc.metadataAuthorTitle)
                case .icon:
                    WindowTitle(subtitle: "", title: Loc.metadataIconTitle)
                }
            }
        }
        .topBarStyle(.raisedBorder)
    }
}
