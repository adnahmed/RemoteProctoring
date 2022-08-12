//
//  Preferences.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/08/2022.
//

import Foundation
import LiveKit

struct Preferences: Codable, Equatable {
#if DEBUG
    static let url = "ws://localhost:7880"
#else
    static let url = "ws://<production-livekit-host>:7880"
#endif
    
    var token = ""
    
    // Connect options
    var autoSubscribe = true
    var publishMode = false
    
    // Room options
    var simulcast = true
    var adaptiveStream = true
    var dynacast = true
    var reportStats = true
    
    // Settings
    var videoViewVisible = true
    var showInformationOverlay = false
    var preferMetal = true
    var videoViewMode: VideoView.LayoutMode = .fit
    var videoViewMirrored = false
    
}

final class LiveKitContext: ObservableObject {
    
    private let perf: Preferences
    
    @Published var videoViewVisible: Bool = true
    @Published var showInformationOverlay: Bool = false
    @Published var preferMetal: Bool = true
    @Published var videoViewMode: VideoView.LayoutMode = .fit
    @Published var videoViewMirrored: Bool = false
    
    public init(perf: Preferences) {
        self.perf = perf
    }
}
