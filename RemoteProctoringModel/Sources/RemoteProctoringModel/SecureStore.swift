//
//  SecureStore.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 14/09/2022.
//

import Foundation
import KeychainAccess
import os

public class SecureStore {
    private let logger = Logger(subsystem: "SecureStore", category: "Keychain")
    public static let shared: SecureStore = SecureStore()
    private var keychain = Keychain(accessGroup: "com.biit.remoteProctoring")
    
    public init() {
        
    }
    
    public var token : String? {
        set(newToken) {
            do {
                if newToken == nil {
                    try keychain.remove("token")
                }
                else {
                    try keychain.set(newToken!, key: "token")
                }
            } catch {
                print("Keychain Value not modified")
            }
        }
        get {
            return try? keychain.get("token")
        }
    }
}
