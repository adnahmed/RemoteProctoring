//
//  RoomContext.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/08/2022.
//

import Foundation
import Promises
import LiveKit
import SwiftUI

final class RoomContext: ObservableObject {
    
    @Published var shouldShowError: Bool = false
    public var latestError: Error?

    public let room = ExamObservableRoom()
    
    @Published var token: String = ""

    public init() {
        room.room.add(delegate: self)
        #if os(iOS)
        UIApplication.shared.isIdleTimerDisabled = true
        #endif
    }

    deinit {
        #if os(iOS)
        UIApplication.shared.isIdleTimerDisabled = false
        #endif
        print("RoomContext.deinit")
    }

    func connect() -> Promise<Room> {

        let connectOptions = ConnectOptions(
        )

        let roomOptions = RoomOptions (
        )

        return room.room.connect(Livekit.shared.Endpoint,
                                 token,
                                 connectOptions: connectOptions,
                                 roomOptions: roomOptions)
    }

    func disconnect() {
        room.room.disconnect()
    }
}
