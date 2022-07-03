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

enum ClientTypes {
    case `default`, authenticated
}

class Network {
    static let shared = Network()
    let log = Logger(subsystem: "Procted", category: "Network")
    let sqliteFileURL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(
        .applicationSupportDirectory,
        .userDomainMask,
        true).first!).appendingPathComponent("apollo_db_sqlite")
    private var keychain = Keychain(service: "rps")
    private(set) var client: ApolloClient
    private var type: ClientTypes = .default
    init(to ApolloURL: URL = URL(string: "http://127.0.0.1:3001/graphql")!, for: ClientTypes = .default){
        do {
            // Instantiate SQLite Cache
            let sqliteCache = try SQLiteNormalizedCache(fileURL: sqliteFileURL)
            let store = ApolloStore(cache: sqliteCache)
            client = ApolloClient(networkTransport: RequestChainNetworkTransport(interceptorProvider: DefaultInterceptorProvider(store: store), endpointURL: ApolloURL), store: store)
        } catch {
            log.warning("Sqllite cache was not initialized. Creating basic Apollo Client.")
            client = ApolloClient(url: ApolloURL)
        }
    }
    
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
//                UserManagementInterceptor(),
//                RequestLoggingInterceptor,
                NetworkFetchInterceptor(client: self.client),
//                RequestLoggingInterceptor(),
                ResponseCodeInterceptor(),
                JSONResponseParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
                AutomaticPersistedQueryInterceptor(),
                CacheWriteInterceptor(store: self.store)
            ]
        }
    }
    
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
    
