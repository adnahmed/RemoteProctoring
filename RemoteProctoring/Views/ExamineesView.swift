//
//  ExamineesView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/08/2022.
//

import SwiftUI
struct ExamineesView: View {
    fileprivate static let ExamineesBannerLabel: String = "Examinees"
    fileprivate static let ExamineesBannerImage: Image? = nil // "ExamineesViewBannerImage"
    @EnvironmentObject var bannerData: BannerData<Image>
    var body: some View {
        Text("Examinees")
            .onAppear {
                bannerData.BannerLabel = ExamineesView.ExamineesBannerLabel
                bannerData.BannerImage = ExamineesView.ExamineesBannerImage
            }
    }
}

struct ExamineesView_Previews: PreviewProvider {
    static var previews: some View {
        ExamineesView()
    }
}
