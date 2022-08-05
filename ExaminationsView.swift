//
//  ExaminationsView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/08/2022.
//

import SwiftUI

struct ExaminationsView: View {
    fileprivate static let ExaminationsBannerLabel: String = "Examinations"
    fileprivate static let ExaminationsBannerImage: Image? = nil // "ExaminationsViewBannerImage"
    @EnvironmentObject var bannerData: BannerData<Image>
    var body: some View {
        Text("Examinations")
            .onAppear {
                bannerData.BannerLabel = ExaminationsView.ExaminationsBannerLabel
                bannerData.BannerImage = ExaminationsView.ExaminationsBannerImage
            }
    }
}

struct ExaminationsView_Previews: PreviewProvider {
    static var previews: some View {
        ExaminationsView()
    }
}
