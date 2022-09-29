//
//  BackButton.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 29/09/2022.
//

import SwiftUI

public struct BackButton: View {
    var showCurrentView: Binding<Bool>
    public var body: some View {
        HStack {
            Button {
                withAnimation {
                    showCurrentView.wrappedValue = false
                }
            } label: {
                Image(systemName: "chevron.backward.circle")
                    .imageScale(.large)
            }
            Spacer()
        }
    }
}

#if DEBUG
struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(showCurrentView: .constant(true))
    }
}
#endif
