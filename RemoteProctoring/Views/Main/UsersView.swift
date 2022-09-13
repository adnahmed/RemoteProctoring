//
//  ExamineesView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 06/08/2022.
//

import SwiftUI

struct UsersView: View {
    @State private var activities: [Activity] = []
    var body: some View {
#if os(iOS)
        NavigationSplitView {
          UsersListView()
        } detail: {
          RecentActivityView(activities: activities)
                .navigationBarTitleDisplayMode(.inline)
        }
#else
        NavigationView {
            UsersListView()
            RecentActivityView(activities: activities)
        }
#endif
        // TODO: On appear fetch recent activities subscription
    }
}

#if DEBUG
let users: [UserData] = [
    UserData(raw: UserDetails(id: "E621E1F8-C36C-495A-93FC-1C247A3E6E5F", username: "adnaahm", givenName: "Adnan Ahmed Khan", role: .examinee, pictures: [])),
    UserData(raw: UserDetails(id: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F", username: "sulmanahm", givenName: "Sulman Ahmed Khan", role: .examinee, pictures: [])),
]

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
#endif
