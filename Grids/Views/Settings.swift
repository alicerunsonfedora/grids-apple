//
//  Settings.swift
//  Grids
//
//  Created by Marquis Kurt on 13-01-2025.
//

import SwiftUI
import TipKit

struct SettingsView: View {
    @AppStorage("run.ignorevalidation") var ignoreValidation = false
    @AppStorage("build.showlive") var showLiveIssues = true

    var body: some View {
        TabView {
            Form {
                Section {
                    Toggle("Show live issues", isOn: $showLiveIssues)
                    Toggle("Continue running after errors", isOn: $ignoreValidation)
                }

                Section {
                    Button {
                        do {
                            try Tips.resetDatastore()
                        } catch {}
                    } label: {
                        Text("Reset Tips...")
                    }
                }
            }
            .padding()
            .tabItem {
                Label("General", systemImage: "gearshape")
            }
        }
        
    }
}

#Preview {
    SettingsView()
}
