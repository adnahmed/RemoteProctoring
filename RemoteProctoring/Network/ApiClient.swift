//
//  Network.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import Apollo
import ApolloSQLite
import Foundation
import LiveKit
import Logging

class ApiClient {
    private(set) public var apiEndpoint: URL
    let logger = Logger(label: "API Client")
    
    // Shared Instance
    static let shared = ApiClient()
    
    init() {
#if DEBUG
        apiEndpoint = URL(string: "http://localhost:4001/graphql")!
#else
        apiEndpoint = URL(string: "https://remoteproctoring.com/api/graphql")!
#endif
    }
    
    init(apiEndpoint: URL) {
        self.apiEndpoint = apiEndpoint
    }
    
    private(set) lazy var client: ApolloClient = {
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
    
    struct NetworkInterceptorProvider: InterceptorProvider {
        private let store: ApolloStore
        private let client: URLSessionClient
        init(store: ApolloStore, client: URLSessionClient) {
            self.store = store
            self.client = client
        }

        func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation: GraphQLOperation {
            return [
                MaxRetryInterceptor(),
                CacheReadInterceptor(store: store),
                UserManagementInterceptor(),
                RequestLoggingInterceptor(),
                NetworkFetchInterceptor(client: client),
                RequestLoggingInterceptor(),
                ResponseCodeInterceptor(),
                JSONResponseParsingInterceptor(cacheKeyForObject: store.cacheKeyForObject),
                AutomaticPersistedQueryInterceptor(),
                CacheWriteInterceptor(store: store)
            ]
        }
    }
}
