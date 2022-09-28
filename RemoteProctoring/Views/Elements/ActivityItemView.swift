//
//  ActivityItemView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 18/08/2022.
//

import SwiftUI

struct ActivityItemView: View {
    var activity: Activity
    var body: some View {
        HStack {
            activity.type.display
            // TODO: Add Navigation to Subject Here
            Text(activity.subject.fullName ?? "")
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

#if DEBUG
struct ActivityItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityItemView(activity: activities[0])
    }
}
#endif
