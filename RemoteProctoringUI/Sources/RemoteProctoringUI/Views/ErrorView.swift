//
//  ErrorView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI
import Neumorphic
import Pow

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
    }
    
}

public struct ErrorMessagesView: View {
    public var errorMessages: Binding<[String]>
    public var recievedError: Binding<Bool>
    
    public init(errorMessages: Binding<[String]>, recievedError: Binding<Bool>) {
        self.errorMessages = errorMessages
        self.recievedError = recievedError
    }
    
    public var body: some View {
        VStack {
            ForEach(errorMessages, id: \.self) { error in
                ErrorView(message: error.wrappedValue)
                    .transition(.movingParts.anvil)
            }
        }
    }
}

#if DEBUG
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
#endif
