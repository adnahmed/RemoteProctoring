//
//  PreferencesView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/08/2022.
//

import SwiftUI
struct PreferencesView: View {
    fileprivate static let PreferencesBannerLabel: String = "Preferences"
    fileprivate static let PreferencesBannerImage: Image = Image(systemName: "gear.circle.fill")
    @EnvironmentObject var bannerData: BannerData<Image>
    var body: some View {
        Text("Preferences")
            .onAppear {
                bannerData.BannerLabel = PreferencesView.PreferencesBannerLabel
                bannerData.BannerImage = PreferencesView.PreferencesBannerImage
            }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}


