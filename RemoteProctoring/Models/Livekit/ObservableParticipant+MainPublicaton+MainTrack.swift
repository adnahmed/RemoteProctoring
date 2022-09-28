//
//  ObservableParticipant.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/08/2022.
//

import LiveKit
extension ObservableParticipant {

    public var mainVideoPublication: TrackPublication? {
        firstCameraPublication
    }

    public var mainVideoTrack: VideoTrack? {
        firstCameraVideoTrack
    }
}
