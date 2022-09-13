//
//  AuthFormView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI
import RegexBuilder
import Apollo
import Neumorphic

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
                        .onChange(of: usernameOrEmail) { usernameOrEmail in
                            withAnimation {
                                errorMessages.removeAll()
                            }
                        }
                        .padding()
                    SecureField("Password", text: $password)
                        .authTextField()
                        .focused($focusedField, equals: .passwordField)
                        .onChange(of: password) { password in
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
            signInPressed = false
            switch res {
            case .success (let gqRes):
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
        }
        func handleAuthResponseData(data: LoginResponse) {
            if data.queryResponse?.code == 200 {
                user.data.raw = data.user?.fragments.userDetails
                withAnimation {
                    Network.shared.token = data.token
                }
            }
            else if data.queryResponse?.code == 403 {
                errorMessages.append("Invalid Username or Password")
            }
            else if data.queryResponse?.code == 400 {
                errorMessages.append(contentsOf: data.queryResponse!.message.split(separator: "\n").map {substr in return String(substr)} )
            }
            else if data.queryResponse!.code == 500 {
                errorMessages.append("Server error occurred. Please try again later.")
                #if DEBUG
                errorMessages.append(data.queryResponse!.message)
                #endif

            }
            else {
                errorMessages.append(data.queryResponse!.message)
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
