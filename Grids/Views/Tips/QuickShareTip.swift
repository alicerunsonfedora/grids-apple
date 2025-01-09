//
//  QuickShareTip.swift
//  Grids
//
//  Created by Marquis Kurt on 07-01-2025.
//

import TipKit
import SwiftUI

struct QuickShareTip: Tip {
    let id = "wtt.toolbar.quickshare"

    var title: Text {
        Text("Share your puzzle with others.")
    }
    
    var message: Text? {
        Text("Share the current puzzle you're working on with friends via a quick link.")
    }
    
    var image: Image? {
        Image("square.and.arrow.up.badge.sparkles")
    }
}
