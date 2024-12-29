//
//  GridsApp.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI

@main
struct GridsApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: WTPFile()) { file in
            GridEditor(file: file.$document)
        }
    }
}
