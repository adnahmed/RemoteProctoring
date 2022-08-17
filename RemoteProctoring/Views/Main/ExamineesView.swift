//
//  ExamineesView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 06/08/2022.
//

import SwiftUI
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
let activities: [Activity] = [
    Activity(id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-1C347A3E6E5F")!, type: .LOOK_LEFT, subject: examinees[0], duration: DateInterval(start: .now - 23312, end: .now - 3143)),
    Activity(id: UUID(uuidString: "E521E1F8-C36C-495A-93FC-1C347A3E6E5F")!, type: .SPEAK, subject: examinees[1], duration: DateInterval(start: .now - 32323123, end: .now))
]
#endif

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

struct SuggestionsView: View {
    var body: some View {
        Text("suggestionToDisplay").searchCompletion("completedTo")
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct ExamineesView: View {
    var body: some View {
#if os(iOS)
        NavigationSplitView {
          ExamineeListView()
        } detail: {
          RecentActivityView()
        }
#else
        NavigationView {
            ExamineeListView()
            RecentActivityView()
        }
#endif
        
    }
}

struct ActivityItemView: View {
    var activity: Activity
    var body: some View {
        HStack {
            activity.type.display
            // TODO: Add Navigation to Subject Here
            Text(activity.subject.full_name)
            Text("\(activity.type.rawValue).")
            Spacer()
            Group {
                Text(Activity.formatter.string(from: activity.duration.start, to: activity.duration.end))
                Text("(\(activity.durationHrs != 0 ? "\(activity.durationHrs)hr" : "") \(activity.durationMins != 0 ? "\(activity.durationMins)min" : "") \(activity.durationSecs)sec)")
            }
            .font(.monospaced(.caption)())
        }
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct ExamineeItemView: View {
    var examinee: Examinee
    var body: some View {
        HStack {
            Image(examinee.picture)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 60, idealWidth: 80, maxWidth: 100, minHeight: 60,idealHeight: 80, maxHeight: 100, alignment: .leading)
                .clipShape(Circle())
                .overlay {
                    GeometryReader { g in
                        Image(systemName: "circle")
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                            .foregroundColor(examinee.isOnline ? .green : .red)
                    }
                }
            VStack(alignment: .leading) {
                HStack {
                    Text(examinee.full_name)
                        .fontWeight(.thin)
                        .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Text("@" + examinee.username)
                        .font(.monospaced(.caption)())
                        .fontWeight(.bold)
                        .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                }
                if let lastSeen = examinee.lastSeen {
                    Text(lastSeen.distance(to: .now) < Activity.ONE_DAY ? RelativeDateTimeFormatter().localizedString(for: lastSeen, relativeTo: .now) : lastSeen.formatted())
                        .fontWeight(.thin)
                        .font(.monospaced(.caption)())
                }
                else {
                    Text("Active")
                        .fontWeight(.thin)
                        .font(.monospaced(.caption)())
                }
            }
        }
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct ExamineesView_Previews: PreviewProvider {
    static var previews: some View {
        ExamineesView()
    }
}
