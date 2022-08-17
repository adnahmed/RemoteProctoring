//
//  AuthFormView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI
import RegexBuilder
import Apollo

struct AuthFormView: View {
#if os(macOS)
    @Binding var showRegisterView: Bool
#endif
    @EnvironmentObject private var user: User
    @State private var usernameOrEmail = ""
    @State private var password = ""
    @State private var recievedError: Bool = false
    @State private var signInPressed: Bool = false
    @State private var errorMessages: [String] = []
    @FocusState private var focusedField: AuthFormField?
    @State var useEmail: Bool = false
    
    var body: some View {
        GeometryReader { g in
            VStack {
                LogoBanner()
                HStack {
                    Spacer()
                    VStack(spacing: 15) {
                        TextField("Username/Email", text: $usernameOrEmail)
                            .authTextField()
                            .focused($focusedField, equals: .usernameOrEmailField)
                            .frame(maxWidth: g.size.width * 0.40)
                            .onChange(of: usernameOrEmail) { usernameOrEmail in
                                withAnimation {
                                    errorMessages.removeAll()
                                }
                            }
                        SecureField("Password", text: $password)
                            .authTextField()
                            .focused($focusedField, equals: .passwordField)
                            .frame(maxWidth: g.size.width * 0.40)
                            .onChange(of: password) { password in
                                withAnimation {
                                    errorMessages.removeAll()
                                }
                            }
                        Button ("Sign In") {
                            #if os(iOS)
                            if let match = usernameOrEmail.firstMatch(of: emailPattern) {
                                let (wholeMatch, _, _) = match.output
                                self.usernameOrEmail = String(wholeMatch)
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
                        .buttonStyle(.borderedProminent)
                        Divider()
                            .frame(maxWidth: g.size.width * 0.60)
#if os(iOS)
                        NavigationLink("Register") {
                            RegisterView()
                        }
                        .registerButton()
#else
                        Button("Register") {
                            withAnimation {
                                showRegisterView.toggle()
                            }
                        }
                        .registerButton()
#endif
                        if signInPressed {
                            ProgressView()
                        }
                        if recievedError {
                            ForEach(errorMessages, id: \.self) { error in
                                AuthenticationErrorView(message: error, animateWhen: $recievedError)
                            }
                        }
                    }
                    Spacer()
                }
                .onAppear {
                    focusedField = .usernameOrEmailField
                }
            }
            .frame(minHeight: g.size.height)
        }
        .background(.white)
        .eraseToAnyView()
    }
    
    func handleSignIn<AuthQueryType>(query: AuthQueryType) where AuthQueryType:GraphQLQuery {
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
        
        Network.shared.client.fetch(query: query) {  res in
            switch res {
            case .success (let gqRes):
                if let errors = gqRes.errors {
                    for error in errors {
                        if let failureReason = error.failureReason {
                            errorMessages.append(failureReason)
                        }
                        else {
                            errorMessages.append(error.description)
                        }
                    }
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
                        NetworkLogger.error("Unknown Data Recieved")
                    }
                    withAnimation {
                        recievedError = true
                    }
                }
            case .failure(let error):
                errorMessages.append(error.localizedDescription)
                withAnimation {
                    recievedError = true
                }
            }
            signInPressed = false
        }
    }
    func handleAuthResponseData(data: LoginResponse) {
        Network.shared.token = data.token
        if data.code == 200 {
            user.userDetails = data.user?.fragments.userDetails
            withAnimation {
                user.isLoggedIn.toggle()
            }
        }
        else if data.code == 403 {
            errorMessages.append("Invalid Username or Password")
        }
        else {
            errorMessages.append(data.message)
        }
    }
#if DEBUG
  @ObservedObject var iO = injectionObserver
  #endif
}


struct AuthFormView_Previews: PreviewProvider {
    static var previews: some View {
#if os(macOS)
        AuthFormView(showRegisterView: .constant(false))
#else
        AuthFormView()
#endif
    }
}
