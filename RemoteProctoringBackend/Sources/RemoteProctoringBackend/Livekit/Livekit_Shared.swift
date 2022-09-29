//
//  File.swift
//  
//
//  Created by Adnan Ahmed Khan on 29/09/2022.
//

import LiveKit

struct LivekitClient {
    public static var shared: LivekitClient = LivekitClient()
#if DEBUG
    let Endpoint: String = "ws://192.168.1.2:7880"
#else
    let Endpoint: String = "ws://<production-url>:7880"
#endif
}
