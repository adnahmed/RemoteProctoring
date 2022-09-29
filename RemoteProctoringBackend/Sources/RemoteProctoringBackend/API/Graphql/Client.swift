//
//  Network.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import Apollo
import ApolloSQLite
import Foundation
import Logging

public class GraphqlClient {
    private(set) public lazy var client: ApolloClient = {
        do {
            let sqliteCache = try SQLiteNormalizedCache(fileURL: URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(
                .applicationSupportDirectory,
                .userDomainMask,
                true).first!).appendingPathComponent("apollo_db_sqlite"))
            let store = ApolloStore(cache: sqliteCache)
            let provider = NetworkInterceptorProvider(store: store, client: URLSessionClient())
            let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: apiEndpoint)
            return ApolloClient(networkTransport: requestChainTransport, store: store)
        } catch {
            let memCache = InMemoryNormalizedCache()
            let store = ApolloStore(cache: memCache)
            let provider = NetworkInterceptorProvider(store: store, client: URLSessionClient())
            let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: apiEndpoint)
            
            return ApolloClient(networkTransport: requestChainTransport, store: store)
        }
    }()
    
    let logger = Logger(label: "API Client")
#if DEBUG
    public let apiEndpoint: URL = URL(string: "http://localhost:4000/graphql")!
#else
    public let apiEndpoint: URL = URL(string:  "https://remoteproctoring.com/api/graphql")!
#endif
    // Shared Instance
    public static let shared = GraphqlClient()
    
    public init() {
    }
}
