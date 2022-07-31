//
//  MainView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct MainView: View {
    @State private var search: String = ""
    @State private var topBar: String = ""
    var body: some View {
        ScrollView {
            VStack {
                TopBarView()
                Divider()
                Spacer()
            }
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
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
                .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .aspectRatio(contentMode: ContentMode.fit)
            Text("Remote Proctoring System")
                .padding(.top)
                .font(Font.system(size: 40,
                                  weight: .thin,
                                  design: .rounded))
                .compatibleThinFont()
                .onTapGesture {
                    
                }
                .onAppear {
                    
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
