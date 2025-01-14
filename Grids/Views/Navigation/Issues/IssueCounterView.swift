//
//  IssueCounterView.swift
//  Grids
//
//  Created by Marquis Kurt on 13-01-2025.
//

import SwiftUI

struct IssueCounterView: View {
    var issues: Set<Issue>

    var errors: Int { issues.count {$0.severity == .error} }
    var warnings: Int { issues.count {$0.severity == .warning} }
    var runtimeWarnings: Int { issues.count {$0.severity == .runtimeWarning} }
    
    var body: some View {
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
