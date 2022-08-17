//
//  ErrorView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI

struct AuthenticationErrorView: View {
    var message: String
    @Binding var animateWhen: Bool
    var body: some View {
        Label {
            Text(message)
                .font(.body)
                .allowsTightening(true)
                .minimumScaleFactor(0.7)
                .foregroundColor(.red)
        } icon: {
            Image(systemName: "exclamationmark.triangle.fill")
                .symbolRenderingMode(.multicolor)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 40)
                .stroke(.red, lineWidth: 3)
                .opacity(0.5)
            
        }
        .animation(.easeInOut(duration: 3), value: animateWhen)
        .transition(.asymmetric(insertion: .slide, removal: .move(edge: .bottom)))
        .padding(.bottom)
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
    
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationErrorView(message: "Error Occurred", animateWhen: .constant(true))
    }
}
