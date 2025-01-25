//
//  NavigatorItem.swift
//  GridsCore
//
//  Created by Marquis Kurt on 25-01-2025.
//

import Foundation

/// A protocol used to describe items for a navigator.
public protocol NavigatorItem: Identifiable, Equatable, Hashable {
    /// The SF Symbol name for the icon to be used in pickers, such as ``NavigatorGroup``.
    var symbol: String { get }

    /// The navigator item's name.
    var name: String { get }

    /// The navigator item's tooltip text.
    var help: String { get }
}
