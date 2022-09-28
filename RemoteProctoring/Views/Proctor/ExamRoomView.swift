//
//  RoomView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/08/2022.
//

import LiveKit
import OrderedCollections
import SwiftUI

#if !os(macOS)
let adaptiveMin = 170.0
let toolbarPlacement: ToolbarItemPlacement = .bottomBar
#else
let adaptiveMin = 300.0
let toolbarPlacement: ToolbarItemPlacement = .primaryAction
#endif

class ObservableRoomExample: ObservableObject {
    public let room: ObservableRoom = ObservableRoom()
    public func connect(role: Role, token: String) {
        let connectOptions = ConnectOptions(
            autoSubscribe: true,
            publishOnlyMode: nil
        )
        room.room.connect(Livekit.shared.Endpoint, token, connectOptions: connectOptions)
    }
}

struct ExamRoomView: View {
    private func connectExaminee() {
            room.connect(role: .examinee, token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjMxNzU1OTYsImlzcyI6IkFQSXRyUFJwdzkzV29pVyIsIm5hbWUiOiJleGFtaW5lZSIsIm5iZiI6MTY2MzA4OTE5Niwic3ViIjoiZXhhbWluZWUiLCJ2aWRlbyI6eyJyb29tIjoibXktZmlyc3Qtcm9vbSIsInJvb21Kb2luIjp0cnVlfX0.qCIYEN-NgT4ahjixj64enXr2PULriaRkJsOtLyJqpFU")
    }
    private func connectProctor() {
            room.connect(role: .proctor, token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjMxNzU1OTIsImlzcyI6IkFQSXRyUFJwdzkzV29pVyIsIm5hbWUiOiJwcm9jdG9yIiwibmJmIjoxNjYzMDg5MTkyLCJzdWIiOiJwcm9jdG9yIiwidmlkZW8iOnsicm9vbSI6Im15LWZpcnN0LXJvb20iLCJyb29tSm9pbiI6dHJ1ZX19.WP_b-a7yXRqIRJ-0pOrHJsUL1JRUxpJs9GnPYExvU34")
    }
    let room = ObservableRoomExample()
    @State private var screenPickerPresented = false
    @EnvironmentObject var roomCtx: RoomContext
    
#if os(macOS)
    @ObservedObject private var windowAccess = WindowAccess()
#endif
    var body: some View {
        GeometryReader { geometry in
            content(geometry: geometry)
        }
    }
}

struct ExamRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ExamRoomView()
    }
}
