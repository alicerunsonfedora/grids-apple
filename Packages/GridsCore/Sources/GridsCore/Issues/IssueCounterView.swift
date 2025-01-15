//
//  IssueCounterView.swift
//  Grids
//
//  Created by Marquis Kurt on 13-01-2025.
//

import SwiftUI

/// A view that displays the number of issues, organized by severity.
public struct IssueCounterView: View {
    /// The issues that will be counted in this view.
    public var issues: Set<Issue>

    /// Creates an issue counter view for the current issue set.
    public init(issues: Set<Issue>) {
        self.issues = issues
    }

    private var errors: Int { issues.count {$0.severity == .error} }
    private var warnings: Int { issues.count {$0.severity == .warning} }
    private var runtimeWarnings: Int { issues.count {$0.severity == .runtimeWarning} }
    
    public var body: some View {
        HStack(spacing: 2) {
            if warnings > 0 {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.yellow)
                    .imageScale(.large)
                Text(warnings, format: .number)
                    .bold()
                    .padding(.trailing, 6)
            }
            if errors > 0 {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundStyle(.red)
                    .imageScale(.large)
                Text(errors, format: .number)
                    .bold()
                    .padding(.trailing, 6)
            }
            if runtimeWarnings > 0 {
                Image(systemName: "exclamationmark.shield.fill")
                    .foregroundStyle(.purple)
                    .imageScale(.large)
                Text(runtimeWarnings, format: .number)
                    .bold()
                    .padding(.trailing, 6)
            }
        }
    }
}

#Preview {
    IssueCounterView(issues: [
        .layoutInaccessible,
        .layoutExceedsSize(.init(width: 99, height: 99)),
        .unevenDiamonds
    ])
    .padding()
}
