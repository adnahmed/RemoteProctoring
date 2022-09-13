//
//  ExamineeItemView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 18/08/2022.
//

import SwiftUI

struct UserItemView: View {
    var user: UserData
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
//                .overlay {
//                    GeometryReader { g in
//                        Image(systemName: "circle")
//                            .symbolVariant(.fill)
//                            .symbolRenderingMode(.multicolor)
//                            .foregroundColor(user.isOnline ? .green : .red)
//                    }
                }
            VStack(alignment: .leading) {
                HStack {
                    Text(user.fullName ?? "")
                        .fontWeight(.thin)
                        .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Text("@" + (user.raw?.username ?? ""))
                        .font(.monospaced(.caption)())
                        .fontWeight(.bold)
                        .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                }
//                if let lastSeen = user.lastSeen {
//                    Text(lastSeen.distance(to: .now) < Activity.ONE_DAY ? RelativeDateTimeFormatter().localizedString(for: lastSeen, relativeTo: .now) : lastSeen.formatted())
//                        .fontWeight(.thin)
//                        .font(.monospaced(.caption)())
//                }
//                else {
//                    Text("Active")
//                        .fontWeight(.thin)
//                        .font(.monospaced(.caption)())
//                }
//            }
        }
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

#if DEBUG
struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemView(user: users[0])
    }
}
#endif
