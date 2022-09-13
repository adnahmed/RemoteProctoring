//
//  ProctorExamView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/09/2022.
//

import LiveKit
import SwiftUI

struct ProctorExamView: View {
    var body: some View {
        // TODO: Timer please
        // TODO: Advanced Sidebar
        ParticipantLayout(Network.shared.room.allParticipants.values, spacing: 5) { participant in
            ExamParticipantView(participant: participant)
        }
    }
}

struct ProctorExamView_Previews: PreviewProvider {
    static var previews: some View {
        ProctorExamView()
    }
}
