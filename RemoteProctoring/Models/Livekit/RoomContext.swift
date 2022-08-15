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

    private let perf: Preferences

    @Published var shouldShowError: Bool = false
    public var latestError: Error?

    public let room = ExamObservableRoom()

    @Published var url: String = ""

    @Published var token: String = ""

    @Published var simulcast: Bool = true

    @Published var adaptiveStream: Bool = false

    @Published var dynacast: Bool = false

    @Published var reportStats: Bool = false

    @Published var autoSubscribe: Bool = true

    @Published var publish: Bool = false

    public init(perf: Preferences) {
        self.perf = perf
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
            autoSubscribe: !publish && autoSubscribe,
            publishOnlyMode: publish ? "publish_\(UUID().uuidString)" : nil
        )

        let roomOptions = RoomOptions (
            defaultVideoPublishOptions: VideoPublishOptions(
                simulcast: publish ? false : simulcast
            ),
            adaptiveStream: adaptiveStream,
            dynacast: dynacast,
            reportStats: reportStats
        )

        return room.room.connect(url,
                                 token,
                                 connectOptions: connectOptions,
                                 roomOptions: roomOptions)
    }

    func disconnect() {
        room.room.disconnect()
    }
}

extension RoomContext: RoomDelegate {

    func room(_ room: Room, didUpdate connectionState: ConnectionState, oldValue: ConnectionState) {

        print("Did update connectionState \(connectionState) \(room.connectionState)")

        if let error = connectionState.disconnectedWithError {
            latestError = error
            DispatchQueue.main.async {
                self.shouldShowError = true
            }
        }

        DispatchQueue.main.async {
            withAnimation {
                self.objectWillChange.send()
            }
        }
    }
}
