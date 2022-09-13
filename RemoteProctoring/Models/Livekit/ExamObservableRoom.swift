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
