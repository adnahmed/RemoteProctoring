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

    override init(_ room: Room = Room()) {
        super.init(room)
        room.add(delegate: self)
    }

    @discardableResult
    func unpublishAll() -> Promise<Void> {
        Promise(on: queue) { () -> Void in
            guard let localParticipant = self.room.localParticipant else { return }
            try awaitPromise(localParticipant.unpublishAll())
            DispatchQueue.main.async {
                self.cameraTrackState = .notPublished()
                self.microphoneTrackState = .notPublished()
                self.screenShareTrackState = .notPublished()
            }
        }
    }

    // MARK: - RoomDelegate

    override func room(_ room: Room, didUpdate connectionState: ConnectionState, oldValue: ConnectionState) {

        super.room(room, didUpdate: connectionState, oldValue: oldValue)

        if case .disconnected = connectionState {
            DispatchQueue.main.async {
                // Reset state
                self.focusParticipant = nil
                self.textFieldString = ""
                self.objectWillChange.send()
            }
        }
    }

    override func room(_ room: Room,
                       participantDidLeave participant: RemoteParticipant) {
        DispatchQueue.main.async {
            if let focusParticipant = self.focusParticipant,
               focusParticipant.sid == participant.sid {
                self.focusParticipant = nil
            }
            self.objectWillChange.send()
        }
    }
}
