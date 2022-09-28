//
//  RoomDelegate.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 14/09/2022.
//

import Foundation
import SwiftUI
import LiveKit

extension RoomContext: RoomDelegate {

    func room(_ room: Room, didUpdate connectionState: ConnectionState, oldValue: ConnectionState) {

        print("Did update connectionState \(oldValue) -> \(connectionState)")

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

