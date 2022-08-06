//
//  MainViewButton.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/08/2022.
//

import SwiftUI

struct MainViewButton<T> : View where T: View {
    #if os(iOS)
    var Destination: T
    #endif
    var Label: String
    var Background: T? = nil
    @State private var opacity: Double = 0.0
    var body : some View {
#if os(iOS)
        NavigationLink(destination: Destination) {
            MainButtonLabel
        }
#else
        MainButtonLabel
#endif
        
    }
    @ViewBuilder private var MainButtonLabel: some View {
        GeometryReader { g in
            ZStack {
                Color.white
                    .opacity(opacity)
                if let Background = Background {
                    Background
                }
                Text(Label)
                    .tracking(3.0)
                    .foregroundColor(.white)
                    .menuButtonFont()
            }
            .modifier(MainButtonViewModifier(opacity: $opacity))
            .frame(width: g.size.width * 0.9, height: g.size.height * 0.9, alignment: .center)
        }
    }
    private struct MainButtonViewModifier : ViewModifier {
        @Binding var opacity: Double
        func body(content: Content) -> some View {
            content
                .buttonStyle(.borderless)
                .background(.black)
                .padding()
                .onHover { inFrame in
                    withAnimation {
                        if inFrame {
                            opacity = 0.2
                        }
                        else {
                            opacity = 0.0
                        }
                    }
                }
        }
    }
}

#if DEBUG
struct MainViewButton_Previews: PreviewProvider {
    static var previews: some View {
        MainViewButton(Destination: Text("Hello"), Label: "Destination")
    }
}
#endif
