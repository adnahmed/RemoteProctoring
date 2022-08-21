//
//  ExamineesView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 06/08/2022.
//

import SwiftUI

struct ExamineesView: View {
    var body: some View {
#if os(iOS)
        NavigationSplitView {
          ExamineeListView()
        } detail: {
          RecentActivityView()
                .navigationBarTitleDisplayMode(.inline)
        }
#else
        NavigationView {
            ExamineeListView()
            RecentActivityView()
        }
#endif
        
    }
}

#if DEBUG
struct Examinee: Identifiable, Hashable {
    var id: UUID
    var full_name: String
    var username: String
    var picture: String // URL
    var isOnline: Bool
    var lastSeen: Date?
}

let examinees: [Examinee] = [
    Examinee(id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-1C247A3E6E5F")!, full_name: "Sulman Ahmed Khan", username:"adnaahm", picture: "pp", isOnline: false, lastSeen: Date(timeIntervalSince1970: 1312413212)),
    Examinee(id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!, full_name: "Adnan Ahmed Khan", username: "sulmanahm", picture: "pp", isOnline: true, lastSeen: nil),
]

struct ExamineesView_Previews: PreviewProvider {
    static var previews: some View {
        ExamineesView()
    }
}
#endif
