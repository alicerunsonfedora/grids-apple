//
//  GridsApp.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import GridsCore
import SwiftUI
import TipKit
import PuzzleKit

@main
struct GridsApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: WTPFile()) { file in
            GridEditor(file: file.$document)
                .toolbarRole(.automatic)
        }

        WindowGroup {
            if #available(macOS 15.0, *) {
                WelcomeView()
                    .toolbarVisibility(.hidden, for: .windowToolbar)
            } else {
                WelcomeView()
            }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .setAsWelcomeWindow()
        
        // TODO: Why does having another WindowGroup cause the DocumentGroup's "New Document" button to disappear? WTF?
        WindowGroup(id: "player", for: PKTaijiPuzzle.self) { puzzle in
            NavigationStack {
                GridPlayer(puzzle: puzzle)
                #if os(iOS)
                    .navigationBarTitleDisplayMode(.inline)
                #endif
            }
        }
        .withRestorationDisabled()
        .defaultPosition(.center)
        .defaultSize(width: 300, height: 200)
        
        Settings {
            SettingsView()
        }
    }
    
    init() {
        do {
            try Tips.configure()
#if DEBUG
            Tips.showAllTipsForTesting()
#endif
        } catch {
            print(error)
        }
    }
}
