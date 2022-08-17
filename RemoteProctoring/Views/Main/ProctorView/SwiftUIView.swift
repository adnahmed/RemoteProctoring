//
//  SwiftUIView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 16/08/2022.
//

import SwiftUI

struct SwiftUIView: View {
    @EnvironmentObject var appCtx: LiveKitContext
    @EnvironmentObject var room: ExamObservableRoom
        var body: some View {
        ParticipantLayout(room.allParticipants.values, spacing: 5) { participant in
            ExamParticipantView(participant: participant,
                                videoViewMode: appCtx.videoViewMode) { participant in
                room.focusParticipant = participant
                
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
