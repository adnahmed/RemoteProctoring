//
//  ProctorsView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/08/2022.
//

import SwiftUI
struct ProctorsView: View {
    fileprivate static let ProctorsBannerLabel: String = "Proctors"
    fileprivate static let ProctorsBannerImage: Image? =  nil // "ProctorsViewBannerImage"
    @EnvironmentObject var bannerData: BannerData<Image>
    var body: some View {
        Text("Proctors")
            .onAppear {
                bannerData.BannerLabel = ProctorsView.ProctorsBannerLabel
                bannerData.BannerImage = ProctorsView.ProctorsBannerImage
            }
    }
}

struct ProctorsView_Previews: PreviewProvider {
    static var previews: some View {
        ProctorsView()
    }
}
