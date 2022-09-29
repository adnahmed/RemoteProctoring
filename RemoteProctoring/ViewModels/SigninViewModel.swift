//
//  SigninViewModel.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 29/09/2022.
//

import SwiftUI
import RemoteProctoringModel
import RemoteProctoringBackend

extension SigninView {
    func onPressSignIn() {
#if os(iOS)
        if let match = usernameOrEmail.firstMatch(of: emailPattern) {
            let (wholeMatch, _, _) = match.output
            usernameOrEmail = String(wholeMatch)
            useEmail = true
        }
#else
        if emailPattern.firstMatch(in: usernameOrEmail, options: [], range: NSRange(location: 0, length: usernameOrEmail.count)) != nil {
            // TODO: Use matched value from NSTextCheckingResult
            useEmail = true
        }
        else {
            useEmail = false
        }
#endif
        if useEmail {
            Task { handleSignIn(query: LogInEmailQuery(email: usernameOrEmail, password: password)) }
        }
        else {
            Task { handleSignIn(query: LogInUsernameQuery(username: usernameOrEmail, password: password)) }
        }
    }
    
    func handleSignIn<AuthQueryType>(query: AuthQueryType) where AuthQueryType: GraphQLQuery {
        guard !usernameOrEmail.isEmpty else {
            focusedField = .usernameOrEmailField
            return
        }
        guard !password.isEmpty else {
            focusedField = .passwordField
            return
        }
        withAnimation {
            signInPressed = true
            recievedError = false
            errorMessages.removeAll()
        }
        
        ApiClient.shared.client.fetch(query: query) { res in
            signInPressed = false
            switch res {
            case .success(let gqRes):
                if let errors = gqRes.errors {
                    errorMessages.append("Error occurred while connecting to server, Please try again.")
#if DEBUG
                    for error in errors {
                        if let failureReason = error.failureReason {
                            errorMessages.append(failureReason)
                        }
                        else {
                            errorMessages.append(error.description)
                        }
                    }
#endif
                    withAnimation {
                        recievedError = true
                    }
                }
                if let data = gqRes.data {
                    switch data {
                    case let data as LogInEmailQuery.Data:
                        handleAuthResponseData(data: data.logInEmail.fragments.loginResponse)
                    case let data as LogInUsernameQuery.Data:
                        handleAuthResponseData(data: data.logInUsername.fragments.loginResponse)
                    default:
                        ApiClient.shared.logger.error("Unknown Data Recieved")
                    }
                }
            case .failure(let error):
                errorMessages.append(error.localizedDescription)
                withAnimation {
                    recievedError = true
                }
            }
        }
        func handleAuthResponseData(data: LoginResponse) {
            guard let queryResponse = data.queryResponse else {
#if DEBUG
                errorMessages.append(contentsOf: data.resultMap.values.compactMap { $0.debugDescription })
#endif
                errorMessages.append("Unknown error occurred, Please try again.")
                withAnimation {
                    recievedError = true
                }
                return
            }
            switch queryResponse.code {
            case 200:
                guard let recievedUser = data.user else {
                    errorMessages.append("Unknown error occured, Please try again.")
                    break
                }
                user.data.raw = recievedUser.fragments.userDetails
                withAnimation {
                    SecureStore.shared.token = data.token
                }
                return
            case 403:
                errorMessages.append("Invalid Username or Password")
            case 400:
                errorMessages.append(contentsOf: queryResponse.message.split(separator: "\n").map { substr in String(substr) })
            case 500:
                errorMessages.append("Server error occurred. Please try again later.")
#if DEBUG
                errorMessages.append(queryResponse.message)
#endif
            default:
                errorMessages.append(queryResponse.message)
            }
            withAnimation {
                recievedError = true
            }
        }
    }
}
