//
//  ExamRoomView+Content.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 14/09/2022.
//

import Foundation
import SwiftUI

extension ExamRoomView {
    func content(geometry: GeometryProxy) -> some View {
        HorVStack(axis: geometry.isTall ? .vertical : .horizontal, spacing: 5) {
            ParticipantLayout(sortedParticipants(), spacing: 5) { participant in
                ExamParticipantView(participant: participant, videoViewMode: .fit)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .padding(5)
    }
}
