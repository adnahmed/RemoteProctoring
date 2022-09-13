//
//  Network.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import Foundation
import os
import Apollo
import ApolloSQLite
import KeychainAccess
import LiveKit

let NetworkLogger = Logger(subsystem: "Procted", category: "Network")
class Network {
    static let shared = Network()
    private let sqliteFileURL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(
        .applicationSupportDirectory,
        .userDomainMask,
        true).first!).appendingPathComponent("apollo_db_sqlite")
    private let urlSessionClient = URLSessionClient()
    public let room: ObservableRoom = ObservableRoom()
    #if DEBUG
    private var keychain = Keychain(accessGroup: "com.biit.remoteProctoring")
    #else
    // TODO: Set Production Keychain Service
    private var keychain = Keychain(accessGroup: "production.com.biit.remoteProctoring")
    #endif
    var token : String? {
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
    
#if DEBUG
    public let apiEndpoint = URL(string: "http://localhost:4001/graphql")!
    public let lkEndpoint = "ws://localhost:8880"
#else
    // TODO: Set Production URL
    public let apiEndpoint = URL(string: "<production-url>")!
    public let lkEndpoint = "wss://<production-url>"
#endif
    
    private(set) lazy var client: ApolloClient = {
        do {
            let sqliteCache = try SQLiteNormalizedCache(fileURL: sqliteFileURL)
            let store = ApolloStore(cache: sqliteCache)
            let provider = NetworkInterceptorProvider(store: store, client: urlSessionClient)
            let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: apiEndpoint)
            return ApolloClient(networkTransport: requestChainTransport, store: store)
        } catch {
            let memCache = InMemoryNormalizedCache()
            let store = ApolloStore(cache: memCache)
            let provider = NetworkInterceptorProvider(store: store, client: urlSessionClient)
            let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: apiEndpoint)
            
            return ApolloClient(networkTransport: requestChainTransport, store: store)
        }
    }()
    
    struct NetworkInterceptorProvider: InterceptorProvider {
        private let store: ApolloStore
        private let client: URLSessionClient
        init(store: ApolloStore, client: URLSessionClient) {
            self.store = store
            self.client = client
        }
        func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
            return [
                MaxRetryInterceptor(),
                CacheReadInterceptor(store: self.store),
                UserManagementInterceptor(),
                RequestLoggingInterceptor(),
                NetworkFetchInterceptor(client: self.client),
                RequestLoggingInterceptor(),
                ResponseCodeInterceptor(),
                JSONResponseParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
                AutomaticPersistedQueryInterceptor(),
                CacheWriteInterceptor(store: self.store)
            ]
        }
    }
    
}

