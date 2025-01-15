//
//  IssueView.swift
//  Grids
//
//  Created by Marquis Kurt on 13-01-2025.
//

import SwiftUI

/// A view that displays an issue in the issue navigator.
public struct IssueView: View {
    /// The issue that will be displayed in this view.
    public var issue: Issue

    public init(issue: Issue) {
        self.issue = issue
    }
    
    public var body: some View {
        if let description = issue.description {
            DisclosureGroup {
                Text(description)
                    .lineLimit(9)
            } label: {
                baseLabel
            }

        } else {
            baseLabel
        }
    }

    private var baseLabel: some View {
        Label {
            Text(issue.text)
                .fontWeight(.medium)
                .lineLimit(3)
        } icon: {
            Image(systemName: symbol)
                .foregroundStyle(symbolColor)
        }
    }

    private var symbol: String {
        switch issue.severity {
        case .warning:
            "exclamationmark.triangle.fill"
        case .error:
            "xmark.octagon.fill"
        case .runtimeWarning:
            "exclamationmark.shield.fill"
        }
    }

    private var symbolColor: Color {
        switch issue.severity {
        case .warning:
            Color.yellow
        case .error:
            Color.red
        case .runtimeWarning:
            Color.purple
        }
    }
}

#Preview {
    @Previewable @State var issues: [Issue] = [
        .layoutInaccessible,
        .layoutExceedsSize(.init(width: 99, height: 99)),
        Issue(
            "This puzzle is incompatible with Taiji.",
            id: "compat.basegame",
            severity: .error)
    ]

    List {
        ForEach(issues) { issue in
            IssueView(issue: issue)
        }
    }
    .listStyle(.sidebar)
}
