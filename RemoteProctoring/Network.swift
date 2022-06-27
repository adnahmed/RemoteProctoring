//
//  Network.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    private(set) lazy var basicApollo = ApolloClient(url: URL(string: "http://localhost:3001/graphql")!)
}
