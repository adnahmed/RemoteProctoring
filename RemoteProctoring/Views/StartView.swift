//
//  StartView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct StartView: View {
#if os(macOS)
    @State private var showRegisterView: Bool = false
#endif
    var body: some View {
#if os(macOS)
        if showRegisterView {
            RegisterView(showRegisterView: $showRegisterView)
        }
        else {
            AuthFormView(showRegisterView: $showRegisterView)
        }
#else
        NavigationStack {
            AuthFormView()
        }
#endif
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
