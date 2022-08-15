//
//  RoomMessage.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/08/2022.
//

import Foundation

struct RoomMessage: Identifiable, Equatable, Hashable, Codable {
    var id: String {
        messageId
    }

    let messageId: String

    let senderSid: String
    let senderIdentity: String
    let text: String

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.messageId == rhs.messageId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
}
