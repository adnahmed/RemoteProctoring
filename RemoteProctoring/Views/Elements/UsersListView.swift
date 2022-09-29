//
//  ExamineeListView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 18/08/2022.
//

import SwiftUI

struct UsersListView: View {
    @State private var multiSelection: Set<UserData> = Set<UserData>()
    @State private var searchString: String = ""
    var body: some View {
        List(users, id: \.self, selection: $multiSelection) { user in
            UserListItemView(user: user)
        }
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
        .toolbar {
#if os(iOS)
            EditButton()
#endif
            NavigationLink {
                
            } label: {
                Image(systemName: "timelapse")
                    .imageScale(.large)
                    .foregroundColor(.indigo)
            }
            .disabled(multiSelection.count < 1)
            NavigationLink {
                Text("Chat")
            } label: {
                Image(systemName: "bolt.horizontal")
                    .symbolVariant(.circle)
                    .imageScale(.large)
                    .foregroundColor(.blue)
            }
            .disabled(multiSelection.count < 1)
        }
        .searchable(text: $searchString, prompt: "Search Examinees") {
            SuggestionsView()
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
