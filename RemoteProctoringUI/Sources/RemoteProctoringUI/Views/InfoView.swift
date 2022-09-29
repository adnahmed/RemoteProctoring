//
//  RegisterViewSupporting.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 01/08/2022.
//

import SwiftUI
import RegexBuilder

public struct InfoView: View {
    private var InfoText: Binding<String>
    private var showInfo: Binding<Bool>
    public init(InfoText: Binding<String>, showInfo: Binding<Bool>) {
        self.InfoText = InfoText
        self.showInfo = showInfo
    }
    // TODO: Add animation on Appearence
   public var body: some View {
        Label {
            Text(InfoText.wrappedValue)
                .lineLimit(4)
                .allowsTightening(true)
                .font(.body)
        } icon: {
            if showInfo.wrappedValue {
                Image(systemName: "x.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .red)
                    .imageScale(.large)
                    .onTapGesture {
                        withAnimation {
                            showInfo.wrappedValue.toggle()
                        }
                }
            }
        }
        
    }

}

#if DEBUG
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(InfoText: .constant("InfoText"), showInfo: .constant(true))
    }
}
#endif
