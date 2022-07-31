//
//  ErrorView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI

struct ErrorView: View {
    var message: String
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
        .transition(.asymmetric(insertion: .slide, removal: .move(edge: .bottom)))
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Error Occurred")
    }
}
