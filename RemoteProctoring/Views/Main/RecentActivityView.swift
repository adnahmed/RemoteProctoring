//
//  RecentActivityView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 13/08/2022.
//

import SwiftUI

struct RecentActivityView: View {
    var body: some View {
        Text("Recent Activity")
            .font(.title)
        List {
            ForEach(activities, id: \.self) { activity in
                NavigationLink {
                    Text("Activity View + Examinee")
                } label: {
                    ActivityItemView(activity: activity)
                }
                .buttonStyle(.borderedProminent)
            }
            NavigationLink {
              Text("Stat & Activity View + All Examinees")
            } label: {
              Text("See More")
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.blue)
        }
//        .navigationBarTitleDisplayMode(.inline)
    }
}
struct RecentActivityView_Previews: PreviewProvider {
    static var previews: some View {
        RecentActivityView()
    }
}
