//
//  MainView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var user: User
    @State private var search: String = ""
    @State private var topBarLabel: String = "Remote Proctoring System"
    @State private var topBarImage: String = "logo"
    var body: some View {
        GeometryReader { g in
        ScrollView {
            VStack {
                    TopBarView(geometry: g,
                               image: $topBarImage,
                               label: $topBarLabel)
                    Divider()
                    Spacer()
                }
            }
        }
        .background(.white)
        .onAppear {
            
        }
    }
}

struct CompatibleThinTextFontWeightModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, macOS 13.0, *) {
            content
                .fontWeight(.thin)
        } else {
            content
        }
    }
}
extension View {
    func compatibleThinFont() -> some View {
        modifier(CompatibleThinTextFontWeightModifier())
    }
}
struct TopBarView: View {
    var geometry: GeometryProxy
    @Binding var image: String
    @Binding var label: String
    var body: some View {
            HStack {
                Spacer()
                Image(image)
                    .resizable()
                    .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
                    .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.20,
                           height: geometry.size.height * 0.10,
                           alignment: .trailing)
                Text(label)
                    .font(Font.system(size: 40,
                                      weight: .thin,
                                      design: .rounded))
                    .compatibleThinFont()
                    .onTapGesture {
                        
                    }
                    .onAppear {
                        
                    }
                Spacer()
            }
            .padding(.top)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
