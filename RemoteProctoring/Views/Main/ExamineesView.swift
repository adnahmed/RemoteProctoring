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

enum ActivityType: String {
    case LOOK_LEFT = "looked left",
         LOOK_RIGHT = "looked right",
         LOOK_UP = "looked up",
         LOOK_DOWN = "looked down",
         
         HEAD_LEFT = "moved head left",
         HEAD_RIGHT = "moved head right",
         HEAD_UP = "moved head up",
         HEAD_DOWN = "moved head down",
         
         SPEAK = "spoke"
    
    var display: some View {
        switch self {
        case .LOOK_LEFT:
            return HStack {
                Image(systemName: "arrow.left")
                Image(systemName: "eye")
            }
        case .LOOK_RIGHT:
            return HStack {
                Image(systemName: "eye")
                Image(systemName: "arrow.right")
            }
        case .LOOK_UP:
            return HStack {
                Image(systemName: "eye")
                Image(systemName: "arrow.up")
            }
        case .LOOK_DOWN:
            return HStack {
                Image(systemName: "eye")
                Image(systemName: "arrow.down")
            }
        case .HEAD_LEFT:
            return HStack {
                Image(systemName: "arrow.left")
                Image(systemName: "person")
            }
        case .HEAD_RIGHT:
            return HStack {
                Image(systemName: "person")
                Image(systemName: "arrow.right")
            }
        case .HEAD_UP:
            return HStack {
                Image(systemName: "person")
                Image(systemName: "arrow.up")
            }
        case .HEAD_DOWN:
            return HStack {
                Image(systemName: "person")
                Image(systemName: "arrow.up")
            }
        case .SPEAK:
            return HStack {
                Image(systemName: "person")
                Image(systemName: "speaker.wave.2")
            }
        }
    }
}

struct Activity: Identifiable, Hashable {
    var id: UUID
    var type: ActivityType
    var subject: Examinee
    var duration: DateInterval
    var durationHrs: Int {
        return Int(duration.duration) / 3600
    }
    
    var durationMins: Int {
        return Int((Int(duration.duration) - durationHrs * 3600)/60)
    }
    
    var durationSecs: Int {
        return Int(Int(duration.duration) - (durationHrs + durationMins))
    }
    
    static let ONE_DAY: TimeInterval = 3600
    static let formatter = {
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
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
struct RecentActivityView: View {
    var body: some View {
        Text("Activity")
            .font(.title)
        List(activities, id: \.self) { activity in
            ActivityItemView(activity: activity)
            NavigationLink {
                Text("Activity View")
            } label: {
                Text("See More")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
struct ExamineeListView: View {
    @State private var multiSelection: Set<Examinee> = Set<Examinee>()
    @State private var searchString: String = ""
    var body: some View {
        List(examinees, id: \.self, selection: $multiSelection) { examinee in
            ExamineeItemView(examinee: examinee)
        }
        
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
    }
}

struct ExamineesView: View {
    var body: some View {
#if os(iOS)
        NavigationSplitView(sidebar: ExamineeListView(), detail: RecentActivityView())
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
                Text("(\(activity.durationHrs != 0 ? "\(activity.durationHrs)hr" : "") \(activity.durationMins != 0 ? "\(activity.durationMins)min" : "") \(activity.durationSecs)sec")
            }
            .font(.monospaced(.caption)())
        }
    }
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
    }
}

struct ExamineesView_Previews: PreviewProvider {
    static var previews: some View {
        ExamineesView()
    }
}
