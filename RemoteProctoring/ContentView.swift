//
//  ContentView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: User
    var body: some View {
        if user.isLoggedIn {
            MainView()
        }
        else {
            UnauthenticatedView()
                .frame(minHeight: 800)
        }
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
