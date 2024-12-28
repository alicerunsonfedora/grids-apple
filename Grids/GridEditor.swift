//
//  GridEditor.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI

struct GridEditor: View {
    @Binding var document: WTPFile

    var body: some View {
        Text("Hello, world!")
            .font(.largeTitle)
            .navigationTitle(document.document.name)
            .navigationSubtitle([document.document.name, document.document.author].joined(separator: " - "))
            .toolbar {
                Button(action: {}) {
                    Label("Hi", systemImage: "square.and.pencil")
                }
            }
    }
}
