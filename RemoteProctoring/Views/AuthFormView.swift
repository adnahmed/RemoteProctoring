//
//  AuthFormView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI

struct AuthFormView: View {
#if os(macOS)
    @Binding var showRegisterView: Bool
#endif
    @EnvironmentObject private var user: User
    @State private var username = ""
    @State private var password = ""
    @State private var recievedError: Bool = false
    @State private var signInPressed: Bool = false
    @State private var errorMessages: [String] = []
    @FocusState private var focusedField: AuthFormField?
    
    var body: some View {
        GeometryReader { g in
            VStack {
                LogoBanner()
                HStack {
                    Spacer()
                    VStack(spacing: 15) {
                        TextField("Username", text: $username)
                            .authTextField()
                            .focused($focusedField, equals: .usernameField)
                            .frame(maxWidth: g.size.width * 0.40)
                            .onChange(of: username) { username in
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
                        Button (action: handleSignIn) {
                            Text("Sign In")
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
                    focusedField = .usernameField
                }
            }
            .frame(minHeight: g.size.height)
        }
        .background(.white)
    }
    
    func handleSignIn() {
        guard !username.isEmpty else {
            focusedField = .usernameField
            return
        }
        guard !password.isEmpty else {
            focusedField = .passwordField
            return
        }
        
        withAnimation {
            signInPressed = true
            recievedError = false
        }
        errorMessages.removeAll()
        Network.shared.client.fetch(
            query: LogInQuery(username: username,password: password)) { res in
                switch res {
                case .success (let gqRes):
                    if let  errors = gqRes.errors {
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
                        Network.shared.token = data.logIn.token
                        if data.logIn.code == 200 {
                            user.userDetails = data.logIn.user?.fragments.userDetails
                            withAnimation {
                                user.isLoggedIn.toggle()
                            }
                        }
                        else if data.logIn.code == 403 {
                            errorMessages.append("Invalid Username or Password")
                        }
                        else {
                            errorMessages.append(data.logIn.message)
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
