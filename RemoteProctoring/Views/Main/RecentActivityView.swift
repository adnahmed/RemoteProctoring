//
//  RecentActivityView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 13/08/2022.
//

import SwiftUI



struct RecentActivityView: View {
    var activities: [Activity]
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
    }
}

#if DEBUG
let activities: [Activity] = [
    Activity(id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-1C347A3E6E5F")!, type: .LOOK_LEFT, subject: users[0], duration: DateInterval(start: .now - 23312, end: .now - 3143)),
    Activity(id: UUID(uuidString: "E521E1F8-C36C-495A-93FC-1C347A3E6E5F")!, type: .SPEAK, subject: users[1], duration: DateInterval(start: .now - 32323123, end: .now))
]
struct RecentActivityView_Previews: PreviewProvider {
    static var previews: some View {
        RecentActivityView(activities: activities)
    }
}
#endif
