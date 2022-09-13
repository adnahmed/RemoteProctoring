//
//  ExamParticipantView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/08/2022.
//

import LiveKit
import SwiftUI

struct ExamParticipantView: View {
    @ObservedObject var participant: ObservableParticipant

    var body: some View {
        if let vpublication = participant.mainVideoPublication as? RemoteTrackPublication, // is remote?
           !vpublication.muted,
           let apublication = participant.firstAudioPublication as? RemoteTrackPublication,
           !apublication.muted,
           let track = vpublication.track as? VideoTrack
        {
            SwiftUIVideoView(track)
                .onAppear {
                    vpublication.set(subscribed: true) // subscribe to video
                    apublication.set(subscribed: true) // subscribe to audio
                }
                .eraseToAnyView()
        }
    }

    #if DEBUG
        @ObservedObject var iO = injectionObserver
    #endif
}
