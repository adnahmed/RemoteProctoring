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
    var body: some View {
        Label {
            Text(message)
                .font(.body)
                .padding([.trailing,.top,.bottom])
        } icon: {
            Image(systemName: "exclamationmark.triangle.fill")
                .symbolRenderingMode(.multicolor)
                .padding(.leading)
        }
        .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
        .eraseToAnyView()
    }
    
#if DEBUG
    @ObservedObject var iO = injectionObserver
#endif
    
}

struct ErrorMessagesView: View {
    @Binding var errorMessages: [String]
    @Binding var recievedError: Bool
    var body: some View {
        VStack {
            ForEach(errorMessages, id: \.self) { error in
                ErrorView(message: error)
                    .animation(.easeInOut(duration: 2), value: recievedError)
                    .transition(.asymmetric(insertion: .slide, removal: .move(edge: .bottom)))
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Error Occurred")
    }
}

struct ErrorMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessagesView(errorMessages: .constant(["Error Recieved 1", "Error Recieved 2"]), recievedError: .constant(true))
    }
}
