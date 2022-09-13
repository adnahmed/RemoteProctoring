//
//  ErrorView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI
import Neumorphic

struct ErrorView: View {
    var message: String
    @Binding var animateWhen: Bool
    var body: some View {
        Label {
            Text(message)
                .font(.body)
        } icon: {
            Image(systemName: "exclamationmark.triangle.fill")
                .symbolRenderingMode(.multicolor)
        }
        .animation(.easeInOut(duration: 2), value: animateWhen)
        .transition(.asymmetric(insertion: .slide, removal: .move(edge: .bottom)))
        .eraseToAnyView()
    }
    
#if DEBUG
    @ObservedObject var iO = injectionObserver
#endif
    
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Error Occurred", animateWhen: .constant(true))
    }
}
