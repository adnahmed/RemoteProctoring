//
//  ExamSolutionView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/09/2022.
//

import SwiftUI
import LiveKit

struct ExamSolutionView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: MCQView()) {
                Text("Solve MCQs")
            }
            NavigationLink(destination: PDFPaperView()) {
                Text("View Written Exam")
            }
            // TODO: Show Cached activity marked sus from proctor (auto/manual)
        }
        .onAppear {
            // TODO: Keep track of proctors in room and set appropriate track permissions
            Network.shared.room.room.localParticipant?.permissions
            Network.shared.room.room.localParticipant?.setTrackSubscriptionPermissions(allParticipantsAllowed: false, trackPermissions: [ParticipantTrackPermission(participantSid: "", allTracksAllowed: true)])
            Network.shared.room.toggleCameraEnabled()
            Network.shared.room.toggleMicrophoneEnabled()
        }
    }
}

struct ExamSolutionView_Previews: PreviewProvider {
    static var previews: some View {
        ExamSolutionView()
    }
}
