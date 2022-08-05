//
//  RecentActivityView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/08/2022.
//

import SwiftUI

struct RecentActivityView: View {
    fileprivate static let RecentActivityBannerLabel: String = "Recent Activity"
    fileprivate static let RecentActivityBannerImage: Image? = nil // "RecentActivityViewBannerImage"
    @EnvironmentObject private var bannerData: BannerData<Image>
    var body: some View {
        Text("Recent Activity")
            .onAppear {
                bannerData.BannerLabel = RecentActivityView.RecentActivityBannerLabel
                bannerData.BannerImage = RecentActivityView.RecentActivityBannerImage
            }
    }
}

struct RecentActivityView_Previews: PreviewProvider {
    static var previews: some View {
        RecentActivityView()
    }
}
