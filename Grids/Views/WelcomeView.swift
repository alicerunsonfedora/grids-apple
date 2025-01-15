//
//  WelcomeView.swift
//  Grids
//
//  Created by Marquis Kurt on 14-01-2025.
//

import GridsCore
import SwiftUI

struct WelcomeView: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.newDocument) private var newDocument
    @Environment(\.openDocument) private var openDocument

    private var version: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                        ?? "0.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
        return "\(version) (\(build))"
    }

    private var recentDocuments: [URL] {
        NSDocumentController.shared.recentDocumentURLs
    }

    var body: some View {
        HStack(spacing: 0) {
            mainWindow
                .frame(width: 350, height: 400)
                .overlay(alignment: .topLeading) {
                    Button {
                        dismissWindow()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .offset(x: 24, y: -8)
                }
            recentDocumentsList
                .frame(width: 350, height: 400)
        }
        .frame(width: 700, height: 400)
    }

    private var mainWindow: some View {
        VStack(spacing: 32) {
            VStack {
                Image("GridsAppIcon")
                    .resizable()
                    .shadow(color: .accent.opacity(0.5), radius: 16)
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                Text("Welcome to Grids")
                    .font(.largeTitle)
                    .bold()
                Text(version)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            VStack(alignment: .leading, spacing: 24) {
                Button {
                    newDocument(contentType: .wtp)
                    dismissWindow()
                } label: {
                    Label("Create New Puzzle", image: "square.grid.3x3.fill.badge.plus")
                }
                Button {
                    let openPanel = NSOpenPanel()
                    openPanel.allowsMultipleSelection = false
                    openPanel.allowedContentTypes = [.wtp]
                    openPanel.begin { resp in
                        if resp == .OK, let url = openPanel.url {
                            openDocument(at: url)
                        }
                    }
                } label: {
                    Label("Open Puzzle...", systemImage: "folder")
                }
            }
            .controlSize(.extraLarge)
            .buttonStyle(.borderless)
            .font(.title3)
            .bold()
        }
        .padding()
    }
    
    private var recentDocumentsList: some View {
        List {
            ForEach(recentDocuments, id: \.self) { url in
                Button {
                    openDocument(at: url)
                    
                } label: {
                    HStack {
                        Image(systemName: "document")
                            .imageScale(.large)
                        VStack(alignment: .leading) {
                            Text(url.lastPathComponent)
                                .font(.headline)
                            Text(url.standardizedFileURL.relativePath)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .listStyle(.sidebar)
        .background(.thinMaterial)
    }

    private func openDocument(at url: URL) {
        Task {
            do {
                try await openDocument(at: url)
                dismissWindow()
            } catch {}
        }
    }
}

#Preview {
    WelcomeView()
}
