//
//  AuthFormView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import Apollo
import Neumorphic
import RegexBuilder
import SwiftUI

struct SigninView: View {
    @EnvironmentObject var user: User
    @State private var usernameOrEmail = ""
    @State private var password = ""
    @State private var recievedError: Bool = false
    @State private var signInPressed: Bool = false
    @State private var errorMessages: [String] = []
    @FocusState private var focusedField: SigninFormField?
    @State var useEmail: Bool = false

    var body: some View {
        VStack {
            Group {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(RoundedRectangle(cornerRadius: 55.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
                    .frame(minHeight: 200, maxHeight: 300)
                    .padding()
                Form {
                    TextField("Username or Email", text: $usernameOrEmail)
                        .authTextField()
                        .focused($focusedField, equals: .usernameOrEmailField)
                        .onChange(of: usernameOrEmail) { _ in
                            withAnimation {
                                errorMessages.removeAll()
                            }
                        }
                        .padding()
                    SecureField("Password", text: $password)
                        .authTextField()
                        .focused($focusedField, equals: .passwordField)
                        .onChange(of: password) { _ in
                            withAnimation {
                                errorMessages.removeAll()
                            }
                        }
                        .padding()
                }
                .frame(minHeight: 230, maxHeight: 230)
                .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
                Button("Sign In", action: onPressSignIn)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
            }
            .frame(minWidth: 350, maxWidth: 550)
            if signInPressed {
                ProgressView()
            }
            if recievedError {
                ErrorMessagesView(errorMessages: $errorMessages, recievedError: $recievedError)
                    .padding(.top)
            }
        }
        .padding()
        .onAppear {
            focusedField = .usernameOrEmailField
        }
        .eraseToAnyView()
    }

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
        #if DEBUG
        @ObservedObject var iO = injectionObserver
        #endif
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
