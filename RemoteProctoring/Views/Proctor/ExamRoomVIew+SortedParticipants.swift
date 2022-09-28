//
//  ExamRoomVIew+SortedParticipants.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 14/09/2022.
//

import Foundation
import LiveKit

extension ExamRoomView {
    func sortedParticipants() -> [ObservableParticipant] {
        room.room.remoteParticipants.values.sorted { p1, p2 in
            return (p1.participant.joinedAt ?? Date()) < (p2.participant.joinedAt ?? Date())
        }
    }
}
