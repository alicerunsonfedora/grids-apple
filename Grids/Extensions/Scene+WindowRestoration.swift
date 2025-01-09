//
//  Scene+WindowRestoration.swift
//  Grids
//
//  Created by Marquis Kurt on 08-01-2025.
//

import SwiftUI

extension Scene {
    func withRestorationDisabled() -> some Scene {
        #if os(macOS)
        if #available(macOS 15.0, *) {
            return self.restorationBehavior(.disabled)
        } else {
            return self
        }
        #else
        return self
        #endif
    }
}
