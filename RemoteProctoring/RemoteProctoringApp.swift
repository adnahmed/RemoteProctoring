//
//  RemoteProctoringApp.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

@main
struct RemoteProctoringApp: App {
    @StateObject var user: User = User()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
                .frame(minWidth: 800, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity)
        }
    }
}
