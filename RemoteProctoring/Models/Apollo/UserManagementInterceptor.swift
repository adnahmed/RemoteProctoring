//
//  UserManagementInterceptor.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 03/07/2022.
//

import Apollo

class UserManagementInterceptor: ApolloInterceptor {
    private func addTokenAndProceed<Operation: GraphQLOperation>(
        _ token: String,
        to request: HTTPRequest<Operation>,
        chain: RequestChain,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            request.addHeader(name: "Authorization", value: token)
            chain.proceedAsync(request: request, response: response, completion: completion)
        }
    
    func interceptAsync<Operation>(chain: RequestChain, request: HTTPRequest<Operation>, response: HTTPResponse<Operation>?, completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation : GraphQLOperation {
        guard let token = Network.shared.token else {
            // If no token is present, just proceed with the request
            chain.proceedAsync(request: request, response: response, completion: completion)
            return
        }
        self.addTokenAndProceed(token, to: request, chain: chain, response: response, completion: completion)
    }
}
