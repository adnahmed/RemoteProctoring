//
//  QuestionPapersView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/08/2022.
//

import SwiftUI

struct QuestionPapersView: View {
    fileprivate static let QuestionPapersBannerLabel: String = "Question Papers"
    fileprivate static let QuestionPapersBannerImage: Image? = nil // "QuestionPapersViewBannerImage"
    @EnvironmentObject var bannerData: BannerData<Image>
    
    var body: some View {
        Text("QuestionPapers")
        .onAppear {
            bannerData.BannerLabel = QuestionPapersView.QuestionPapersBannerLabel
            bannerData.BannerImage = QuestionPapersView.QuestionPapersBannerImage
            }
    }
}

struct QuestionPapersView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionPapersView()
    }
}
