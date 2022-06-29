//
//  ContentView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var user = User()
    
    var body: some View {
        if user.isLoggedIn {
                MainView()
        }
        else {
            StartView(isLoggedIn: $user.isLoggedIn)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
