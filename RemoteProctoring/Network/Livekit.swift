//
//  Livekit.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 28/09/2022.
//

import Foundation

struct Livekit {
    public static var shared: Livekit = Livekit()
#if DEBUG
    let Endpoint: String = "ws://192.168.1.2:7880"
#else
    let Endpoint: String = "ws://<production-url>:7880"
#endif
}
