//
//  MainViewButton.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/08/2022.
//

import SwiftUI

struct MainViewButton<T> : View where T: View {
    var Destination: T
    var Label: String
    var Background: Image? = nil
    @State private var opacity: Double = 0.0
    var body : some View {
        GeometryReader { g in
            ZStack {
                Color.white
                    .opacity(opacity)
                if let Background = Background {
                    Background
                }
                NavigationLink {
                    Destination
                } label: {
                    Text(Label)
                        .tracking(3.0)
                        .foregroundColor(.white)
                        .menuButtonFont()
                        .padding()
                }
                .buttonStyle(.borderless)
            }
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
            .frame(width: g.size.width, height: g.size.height, alignment: .center)
            .background(.gray)
        }
    }
}

struct MainViewButton_Previews: PreviewProvider {
    static var previews: some View {
        MainViewButton(Destination: Text("Hello"), Label: "Destination")
    }
}

