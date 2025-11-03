import Adwaita
import DocumentKit

extension String: @retroactive Identifiable {
    public var id: String {
        self
    }
}

extension Binding: @retroactive Identifiable where Value: Identifiable {
    public var id: Value.ID {
        wrappedValue.id
    }
}

struct WTPDocumentEditor: View {
    @Binding var document: WTPuzzle
    var app: AdwaitaApp
    var window: AdwaitaWindow
    var documentActions: DocumentActions<WTPuzzle>

    @State private var path = NavigationStack<WTPNavigationPath>()
    @State private var displayMetadataEditor = false
    @State private var metadataEditorMode = WTPEditorMetadataMode.name

    var view: Body {
        NavigationView($path, document.name) { pathEntry in
            switch pathEntry {
            case let .editor(puzzle):
                WTPGridEditor(
                    puzzle: puzzle,
                    path: $path,
                    app: app,
                    window: window,
                    documentActions: documentActions)
            case let .player(puzzle):
                WTPuzzlePreview(puzzle: puzzle)
            }

        } initialView: {
            ScrollView {
                VStack(spacing: 0) {
                    Form {
                        ActionRow()
                            .title(Loc.puzzleName)
                            .subtitle(document.name)
                            .suffix {
                                ButtonContent()
                                     .iconName(Icon.default(icon: .documentEdit).string)
                            }
                            .activatableWidget {
                                Button()
                                    .activate {
                                        metadataEditorMode = .name
                                        displayMetadataEditor.toggle()
                                    }
                            }
                        ActionRow()
                            .title(Loc.puzzleAuthor)
                            .subtitle(document.author)
                            .suffix {
                                ButtonContent()
                                     .iconName(Icon.default(icon: .documentEdit).string)
                            }
                            .activatableWidget {
                                Button()
                                    .activate {
                                        metadataEditorMode = .author
                                        displayMetadataEditor.toggle()
                                    }
                            }
                        ActionRow()
                            .title(Loc.puzzleIcon)
                            .subtitle(document.icon.name)
                            .suffix {
                                ButtonContent()
                                     .iconName(Icon.default(icon: .documentEdit).string)
                            }
                            .activatableWidget {
                                Button()
                                    .activate {
                                        metadataEditorMode = .icon
                                        displayMetadataEditor.toggle()
                                    }
                            }
                    }
                    .padding(20)
                    Text(Loc.puzzleSetHeader)
                        .heading()
                        .halign(.start)
                        .padding(20, [.leading, .trailing, .bottom])
                        .padding(40, .top)
                    List(document.puzzles) { puzzle in
                        puzzleRow($document.puzzles[id: puzzle.id, default: .defaultUndefined])
                    }
                    .boxedList()
                    .valign(.start)
                    .padding(20, [.leading, .trailing, .bottom])
                    .style("boxed-list")
                }
                .frame(maxWidth: 650)
            }
            .topToolbar {
                HeaderBar {
                    Button(Loc.openTruncated) {
                        documentActions.openDocument()
                    }
                    Button(Loc.saveTruncated) {
                        documentActions.saveDocument()
                    }
                } end: {
                    MainMenu(
                        app: app,
                        window: window,
                        documentActions: documentActions)
                }
                .headerBarTitle {
                    WindowTitle(subtitle: document.author, title: document.name)
                }
            }
            .topBarStyle(.raised)
        }
        .dialog(visible: $displayMetadataEditor) {
            WTPEditorMetadataDialog(document: $document, isVisible: $displayMetadataEditor, mode: metadataEditorMode)
        }
    }

    private func puzzleRow(_ puzzle: Binding<WTPuzzlePiece>) -> AnyView {
        ActionRow()
            .title(puzzle.wrappedValue.code)
            .suffix {
                ButtonContent()
                    .iconName(Icon.default(icon: .goNext).string)
            }
            .activatableWidget {
                Button()
                    .activate { path.push(.editor(puzzle)) }
            }
    }
}
