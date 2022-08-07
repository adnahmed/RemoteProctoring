//
//  MainView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct MainView: View {
#if os(iOS)
    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic
#endif
    var body: some View {
        GeometryReader { g in
#if os(macOS)
            NavigationView {
                SidebarView()
                MainContentView()
            }
#else
            NavigationSplitView(columnVisibility: $columnVisibility) {
                SidebarView()
                    .navigationSplitViewColumnWidth(g.size.width * 0.40)
            } detail: {
                MainContentView()
                    .navigationSplitViewColumnWidth(
                        ideal: g.size.width * 0.50)
            }
#endif
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
    