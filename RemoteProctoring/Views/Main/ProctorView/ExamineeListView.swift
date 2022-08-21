//
//  ExamineeListView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 18/08/2022.
//

import SwiftUI

struct ExamineeListView: View {
    @State private var multiSelection: Set<Examinee> = Set<Examinee>()
    @State private var searchString: String = ""
    var body: some View {
        List(examinees, id: \.self, selection: $multiSelection) { examinee in
            ExamineeItemView(examinee: examinee)
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

struct ExamineeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExamineeListView()
    }
}
