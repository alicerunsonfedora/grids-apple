//
//  Color+Background.swift
//  Grids
//
//  Created by Marquis Kurt on 02-01-2025.
//

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

import SwiftUI

extension Color {
    #if os(iOS)
    /// The color for the main background of your interface.
    static var systemBackground = Color(uiColor: .systemBackground)
    #endif
    
    #if os(macOS)
    /// The color to use for the window background.
    static var systemBackground = Color(nsColor: .windowBackgroundColor)
    #endif
}
