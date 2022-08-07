//
//  ExamineesView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 06/08/2022.
//

import SwiftUI
#if DEBUG
struct Examinee: Identifiable {
    var id: UUID
    var full_name: String
    var picture: String // URL
    var isOnline: Bool
    var lastScene: Date?
}
#endif
struct ExamineesView: View {
    enum DisplayType {
        case List, Card
    }
#if DEBUG
    var examinees: [Examinee] = [
        Examinee(id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-1C247A3E6E5F")!, full_name: "Sulman Ahmed Khan", picture: "pp", isOnline: false, lastScene: Date(timeIntervalSince1970: 1312413212)),
        Examinee(id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!, full_name: "Adnan Ahmed Khan", picture: "pp", isOnline: true, lastScene: nil),
    ]
#endif
    @State private var displayType: DisplayType = .List
    @State private var searchString: String = ""
    var body: some View {
        NavigationStack {
            List(examinees) { examinee in
                ExamineeItemView(examinee: examinee)
            }
            .toolbar {
                Group {
                    Button {
                        withAnimation {
                            displayType = .List
                        }
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                    Button {
                        withAnimation {
                            displayType = .Card
                        }
                    } label: {
                        Image(systemName: "note")
                    }
                }
            }
            .toolbarBackground(.visible, in: ToolbarPlacement.navigationBar)
        }
        .searchable(text: $searchString,placement: .navigationBarDrawer, prompt: "Search Examinees") {
            SuggestionsView()
        }
    }
    
    struct SuggestionsView: View {
        var body: some View {
            Text("suggestionToDisplay").searchCompletion("completedTo")
        }
    }
}

struct ExamineeItemView: View {
    var examinee: Examinee
    var body: some View {
        GeometryReader { g in
            HStack {
                Image(examinee.picture)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: g.size.height * 1.50)
                    .clipShape(Circle())
                    .overlay {
                        Image(systemName: "circle")
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                            .imageScale(.small)
                            .foregroundColor(examinee.isOnline ? .green : .red)
                            .offset(CGSize(width: -20, height: g.size.height * -0.7))
                    }
                VStack(alignment: .leading) {
                    Text(examinee.full_name)
                        .fontWeight(.thin)
                    // TODO: Support for since n hours ago formatting if lastScene < 12 hours
                    Text(examinee.lastScene?.formatted(date: .complete, time: .standard) ?? "Active")
                        .font(.system(.caption, design: .monospaced, weight: .thin))
                }
                Spacer()
                Image(systemName: "timelapse")
                    .foregroundColor(.blue)
                    .padding(.trailing)
                Image(systemName: "bolt.horizontal")
                    .symbolVariant(.circle)
                    .foregroundColor(examinee.isOnline ? .blue : .gray)
                    .padding(.trailing)
                
            }
        }
        .padding()
    }
}
struct ExamineesView_Previews: PreviewProvider {
    static var previews: some View {
        ExamineesView()
    }
}
