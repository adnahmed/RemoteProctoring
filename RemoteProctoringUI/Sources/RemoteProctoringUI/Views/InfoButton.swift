//
//  InfoButton.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 29/09/2022.
//

import SwiftUI

public struct InfoButton: View {
    private var showInfo: Binding<Bool>
    public init(showInfo: Binding<Bool>) {
        self.showInfo = showInfo
    }
    public var body: some View {
        Image(systemName:"info.circle")
            .onTapGesture {
                withAnimation {
                    showInfo.wrappedValue.toggle()
                }
            }
            .symbolRenderingMode(.multicolor)
    }
}

#if DEBUG
struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton(showInfo: .constant(true))
    }
}
#endif
