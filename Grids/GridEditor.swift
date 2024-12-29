//
//  GridEditor.swift
//  Grids
//
//  Created by Marquis Kurt on 28-12-2024.
//

import SwiftUI

struct GridEditor: View {
    @Binding var document: WTPFile
    @State private var openDocInspector: Bool = false

    var body: some View {
        Text("Hello, world!")
            .font(.largeTitle)
            .navigationTitle(document.document.name)
        #if os(macOS)
            .navigationSubtitle([document.document.name, document.document.author].joined(separator: " - "))
        #endif
            .toolbar {
                Button(action: { openDocInspector.toggle() }) {
                    Label("Hi", systemImage: "sidebar.right")
                }
            }
            .inspector(isPresented: $openDocInspector) {
                Form {
                    Section("Metadata") {
                        TextField("Name", text: $document.document.name)
                        TextField("Author", text: $document.document.author)

                        Picker("Icon", selection: $document.document.icon) {
                            ForEach(WTPDocument.FileIcon.allCases) { icon in
                                Text(icon.name).tag(icon, includeOptional: true)
                            }
                        }
                    }
                }
            }
    }
}

#Preview {
    struct EditorPreview: View {
        @State private var file = WTPFile()
        
        var body: some View {
            GridEditor(document: $file)
        }
    }
    
    return EditorPreview()
}
