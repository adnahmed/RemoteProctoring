//
//  RemoteProctoringApp.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

@main
struct RemoteProctoringApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .commands {
            SidebarCommands()
        }
        #endif
        // TODO: Capture NSWindow and work on blurring
    }
}
