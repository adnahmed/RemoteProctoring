//
//  StartView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct UnauthenticatedView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var animationCompletion: CGFloat = 0.0
    var body: some View {
        TabView {
            SigninView()
                .tabItem {
                    Label("Sign In", systemImage: "person.badge.key.fill")
                }
            RegisterView()
                .tabItem {
                    Label("Register", systemImage: "figure.wave")
                }
        }
        .frame(minWidth: 600, minHeight: 650)
    }
}

struct UnauthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        UnauthenticatedView()
    }
}
