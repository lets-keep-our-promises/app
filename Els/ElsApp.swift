//
//  ElsApp.swift
//  Els
//
//  Created by Boseok Son on 9/11/24.
//

import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            self.window = window
            window.title = "Blur Window"
            window.isOpaque = false
            window.backgroundColor = .white
        }
    }
}

@main
struct ElsApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ConnectView()
                .frame(width: 750, height: 500)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
