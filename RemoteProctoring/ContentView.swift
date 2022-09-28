//
//  ContentView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if SecureStore.shared.token != nil {
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
