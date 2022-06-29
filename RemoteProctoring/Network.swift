//
//  Network.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import Foundation
import Apollo
import KeychainAccess

class Network : ObservableObject {
    static let shared = Network()
    private(set) lazy var basicApollo = ApolloClient(url: URL(string: "http://127.0.0.1:3001/graphql")!)
    var keychain = Keychain(service: "rps")
    
    var token : String? {
        set {
            do {
                if newValue == nil {
                    try keychain.remove("token")
                }
                else {
                    try keychain.set(newValue!, key: "token")
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
    
