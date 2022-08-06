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
    #if os(macOS)
    @StateObject private var subViewNavigation: SubViewNavigation = SubViewNavigation()
#endif
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
                    HSplitView {
                        NavGrid()
                            .frame(minWidth: geometryProxy.size.width * 0.30, maxWidth: geometryProxy.size.width * 0.40)
                        SubView()
                    }
                    .environmentObject(subViewNavigation)
#endif
                Spacer()
            }
#if os(iOS)
            .overlay(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(Gradient(colors: [.red, .blue, .green, .yellow]))
            )
#endif
            .padding()
            .background(.white)
        }
        .environmentObject(self.bannerData)
    }
}

#if os(macOS)
// MARK: Dirty MacOS NavigationView Hack
struct SubView: View {
    @EnvironmentObject var subViewNavigation: SubViewNavigation
    var body: some View {
        switch subViewNavigation.selection {
        case .PreferencesView:
            PreferencesView()
        case .RecentActivityView:
            RecentActivityView()
        case .ExaminationsView:
            ExaminationsView()
        case .ProctorsView:
            ProctorsView()
        case .ExamineeView:
            ExamineesView()
        case .QustionPapersView:
            QuestionPapersView()
        default:
            MainViewDefault()
        }
    }
}

struct MainViewDefault: View {
    var body: some View {
        Text("Welcome to RPS, select any option from right side of Window to get started.")
    }
}
class SubViewNavigation: ObservableObject {
    @Published var selection: MainSubView? = nil
    enum MainSubView {
        case PreferencesView, RecentActivityView, ProctorsView, ExamineeView, ExaminationsView, QustionPapersView
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
#endif

struct OtherGridRow: View {
    @EnvironmentObject var subViewNavigation: SubViewNavigation
    var body: some View {
        HStack {
            #if os(iOS)
            MainViewButton(Destination: PreferencesView(), Label: "Preferences", Background: Image("PreferencesButton"))
            MainViewButton(Destination: RecentActivityView(), Label: "Recent Activity", Background: Image("RecentActivityButton"))
            #else
            MainViewButton(Label: "Preferences", Background: Image("PreferencesButton"))
                .onTapGesture {
                    subViewNavigation.selection = .PreferencesView
                }
            MainViewButton(Label: "Recent Activity", Background: Image("RecentActivityButton"))
                .onTapGesture {
                    subViewNavigation.selection = .RecentActivityView
                }
        #endif
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
