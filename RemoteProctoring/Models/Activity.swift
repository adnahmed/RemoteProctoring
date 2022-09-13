//
//  Activity.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 13/08/2022.
//

import Foundation

struct Activity: Identifiable, Hashable {
    var id: UUID
    var type: ActivityType
    var subject: UserData
    var duration: DateInterval
    var durationHrs: Int {
        return Int(duration.duration) / 3600
    }
    
    var durationMins: Int {
        return Int((Int(duration.duration) - durationHrs * 3600)/60)
    }
    
    var durationSecs: Int {
        return Int(Int(duration.duration) - (durationHrs * 3600 + durationMins * 60))
    }
    
    static let ONE_DAY: TimeInterval = 3600
    static let formatter = {
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
