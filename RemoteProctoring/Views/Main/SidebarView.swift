//
//  SidebarView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 06/08/2022.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            NavigationLink {
                MainContentView()
            } label: {
                Label {
                    Text("Home")
                        .allowsTightening(true)
                } icon: {
                    Image(systemName: "house")
                        .symbolVariant(.fill)
                        .symbolRenderingMode(.multicolor)
                }
            }
            Section("People") {
                NavigationLink {
                    ExamineesView()
                } label: {
                    Label {
                        Text("Examinees")
                            .allowsTightening(true)
                    } icon: {
                        Image(systemName: "person")
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .padding([.top, .bottom])
        Spacer()
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
