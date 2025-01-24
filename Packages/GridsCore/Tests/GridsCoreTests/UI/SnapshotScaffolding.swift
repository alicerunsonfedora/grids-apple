//
//  SnapshotScaffolding.swift
//  GridsCore
//
//  Created by Marquis Kurt on 24-01-2025.
//

//import SnapshotTesting
//import SwiftUI
//
//extension SwiftUI.View {
//    #if os(macOS)
//    func toViewController() -> NSViewController {
//        let controller = NSHostingController(rootView: self)
//        controller.view.frame = NSScreen.main?.frame ?? .zero
//        return controller
//    }
//    
//    func toViewController(frame: CGRect) -> NSViewController {
//        let controller = NSHostingController(rootView: self)
//        controller.view.frame = frame
//        return controller
//    }
//    #elseif os(iOS)
//    func toViewController() -> UIViewController {
//        let controller = UIViewController(rootView: self)
//        controller.view.frame = UIScreen.main.bounds
//        return controller
//    }
//    
//    func toViewController(frame: CGRect) -> UIViewController {
//        let controller = UIViewController(rootView: self)
//        controller.view.frame = frame
//        return controller
//    }
//    #endif
//}
