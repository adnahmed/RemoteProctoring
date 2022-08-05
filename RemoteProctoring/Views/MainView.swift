//
//  MainView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

struct MainView: View {
    fileprivate static let MainBannerLabel: String = "Remote Proctoring System"
    fileprivate static let MainBannerImage: Image = Image("logo")
    @EnvironmentObject private var user: User
    @StateObject private var bannerData: BannerData = BannerData(label: MainView.MainBannerLabel, image: MainView.MainBannerImage)
    var body: some View {
        GeometryReader { geometryProxy in
            VStack {
                BannerView(geometry: geometryProxy)
                Divider()
                Spacer()
#if os(iOS)
                NavigationStack {
                    Grid {
                        GridRow {
                            ExamGridRow()
                        }
                        GridRow {
                            SubjectGridRow()
                        }
                        GridRow {
                            OtherGridRow()
                        }
                    }
                    .onAppear {
                        bannerData.BannerLabel = MainView.MainBannerLabel
                        bannerData.BannerImage = MainView.MainBannerImage
                    }
                }
#else
                NavigationView {
                    NavGrid()
                        .frame(minWidth: geometryProxy.size.width * 0.40, maxWidth: geometryProxy.size.width * 0.80)
                }
#endif
                Spacer()
            }
#if os(iOS)
            .overlay(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(Gradient(colors: [.red, .blue, .green, .yellow]))
            )
#else
            .overlay(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(.blue)
            )
#endif
            .padding()
            .background(.white)
        }
        .environmentObject(self.bannerData)
    }
}

struct NavGrid: View {
    var body: some View {
        VStack {
            ExamGridRow()
            SubjectGridRow()
            OtherGridRow()
            
        }
    }
}
struct OtherGridRow: View {
    var body: some View {
        HStack {
            MainViewButton(Destination: PreferencesView(), Label: "Preferences", Background: Image("PreferencesButton"))
            MainViewButton(Destination: RecentActivityView(), Label: "Recent Activity", Background: Image("RecentActivityButton"))
        }
    }
}

struct SubjectGridRow: View {
    var body: some View {
        HStack {
            MainViewButton(Destination: ProctorsView(), Label: "Proctors", Background: Image("ProctorsButton"))
            MainViewButton(Destination: ExamineesView(), Label: "Examinees" , Background: Image("ExamineesButton"))
        }
    }
}
struct ExamGridRow: View {
    var body: some View {
        HStack {
            MainViewButton(Destination: ExaminationsView(), Label: "Exams", Background: Image("ExaminationsButton"))
            MainViewButton(Destination: QuestionPapersView(), Label: "Question Papers", Background: Image("QuestionPapersButton"))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
