//
//  RemoteProctoringApp.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

@main
struct RemoteProctoringApp: App {
    @StateObject private var store = Store()
    @StateObject private var user = User()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(user)
        }
    }
}
