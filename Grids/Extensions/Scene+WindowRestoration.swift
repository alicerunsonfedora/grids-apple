//
//  Scene+WindowRestoration.swift
//  Grids
//
//  Created by Marquis Kurt on 08-01-2025.
//

import SwiftUI

extension Scene {
    func withRestorationDisabled() -> some Scene {
        if #available(macOS 15.0, *) {
            return self.restorationBehavior(.disabled)
                .defaultLaunchBehavior(.suppressed)
        } else {
            return self
        }
    }
    
    func setAsWelcomeWindow() -> some Scene {
        if #available(macOS 15.0, *) {
            return self.defaultLaunchBehavior(.presented)
                .windowBackgroundDragBehavior(.enabled)
                .defaultWindowPlacement { content, context in
                    let displayBounds = context.defaultDisplay.visibleRect
                    let size = content.sizeThatFits(.unspecified)
                    let position = CGPoint(
                        x: displayBounds.midX - (size.width / 2),
                        y: displayBounds.minY + 256
                    )
                    return WindowPlacement(position, size: size)
                }
        } else {
            return self
        }
    }
}
