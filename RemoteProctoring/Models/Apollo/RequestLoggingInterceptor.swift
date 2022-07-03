//
//  RequestLoggingInterceptor.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 03/07/2022.
//

import Apollo

class RequestLoggingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation>(chain: RequestChain, request: HTTPRequest<Operation>, response: HTTPResponse<Operation>?, completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
        NetworkLogger.debug("Outgoint Request: \(request.debugDescription)")
        chain.proceedAsync(request: request, response: response, completion: completion)
    }
}
