//
//  ExamineeItemView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 18/08/2022.
//

import SwiftUI

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

#if DEBUG
struct ExamineeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ExamineeItemView(examinee: examinees[0])
    }
}
#endif
