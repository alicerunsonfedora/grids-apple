//
//  PuzzleSetTip.swift
//  Grids
//
//  Created by Marquis Kurt on 07-01-2025.
//

import TipKit
import SwiftUI

struct PuzzleSetTip: Tip {
    let id = "wtt.sidebar.sets"
    var title: Text {
        Text("Manage your puzzles here.")
    }
    
    var message: Text? {
        Text("Create a new puzzle to add to your set, rearrange the puzzle to your desired order, and remove them from the sidebar.")
    }
}
