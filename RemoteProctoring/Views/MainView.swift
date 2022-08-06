//
//  MainView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
#if os(macOS)
        NavigationView {
            SidebarView()
            MainContentView()
            DetailView()
        }
#else
        NavigationSplitView {
            SidebarView()
        } content: {
            MainContentView()
        } detail: {
            DetailView()
        }
#endif
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
