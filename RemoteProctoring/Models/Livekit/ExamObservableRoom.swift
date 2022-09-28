//
//  ExamObservableRoom.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/08/2022.
//

import Foundation
import Combine
import Promises
import LiveKit
import SwiftUI

class ExamObservableRoom: ObservableRoom {
    
    let queue = DispatchQueue(label: "exam.observableroom")
    
    @Published var focusParticipant: ObservableParticipant?
    @Published var textFieldString: String = ""
    @Published var messages: [RoomMessage] = []
    
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    override init(_ room: Room = Room()) {
        super.init(room)
    }
    
    func sendMessage() {

        guard let localParticipant = room.localParticipant else {
            print("LocalParticipant doesn't exist")
            return
        }

        // Make sure the message is not empty
        guard !textFieldString.isEmpty else { return }

        let roomMessage = RoomMessage(messageId: UUID().uuidString,
                                             senderSid: localParticipant.sid,
                                             senderIdentity: localParticipant.identity,
                                             text: textFieldString)
        textFieldString = ""
        messages.append(roomMessage)

        do {
            let json = try jsonEncoder.encode(roomMessage)
            localParticipant.publishData(data: json).then {
                print("did send data")
            }.catch { error in
                print("failed to send data \(error)")
            }
        } catch let error {
            print("Failed to encode data \(error)")
        }
    }

    @discardableResult
    func unpublishAll() -> Promise<Void> {
        Promise(on: queue) { () -> Void in
            guard let localParticipant = self.room.localParticipant else { return }
            try awaitPromise(localParticipant.unpublishAll())
            DispatchQueue.main.async {
                self.cameraTrackState = .notPublished()
                self.microphoneTrackState = .notPublished()
            }
        }
    }
}
