//
//  MainViewSupporting.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 03/08/2022.
//

import SwiftUI

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
struct BannerView: View {
    var geometry: GeometryProxy
    @EnvironmentObject var bannerData: BannerData<Image>
    var body: some View {
        HStack {
            Spacer()
            if let BannerImage = bannerData.BannerImage {
                BannerImage
                    .resizable()
                    .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
                    .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.20,
                           height: geometry.size.height * 0.10,
                           alignment: .trailing)
            }
            Text(bannerData.BannerLabel)
                .font(Font.system(size: 40,
                                  weight: .thin,
                                  design: .rounded))
                .compatibleThinFont()
                .onTapGesture {
                   // TODO: Add Jump Animation
                }
                .onAppear {
                   // TODO: Add Moving Gradient Animation
                }
            Spacer()
        }
        .padding(.top)
    }
}

struct CompatibleMonospacedThinFont: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, macOS 13.0, *) {
            content
                .font(.system(.largeTitle, design: .monospaced, weight: .thin))
        } else {
            content
                .font(.system(size: 16, weight: .thin, design: .monospaced))
        }
    }
}

extension View {
    func menuButtonFont() -> some View {
        modifier(CompatibleMonospacedThinFont())
    }
}

class BannerData<T: View>: ObservableObject {
    @Published var BannerLabel: String
    @Published var BannerImage: T?
    init(label: String, image: T) {
        BannerLabel = label
        BannerImage = image
    }
    init(label: String) {
        BannerLabel = label
        BannerImage = nil
    }
}
