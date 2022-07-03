//
//  StartView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 27/06/2022.
//

import SwiftUI

enum Field : Hashable {
    case usernameField, passwordField, administatorUsernameField
}

struct StartView: View {
    #if os(macOS)
    @State private var showRegisterView: Bool = false
    #endif
    var body: some View {
        #if os(iOS)
            NavigationStack {
                startView()
            }
        #else
        if showRegisterView {
            RegisterView(for: .administrator)
        }
        else {
            startView(showRegisterView: $showRegisterView)
        }
        #endif
        
    }
    struct startView: View {
        #if os(macOS)
        @Binding var showRegisterView: Bool
        #endif
        
        @EnvironmentObject private var user: User;
        @State private var username = ""
        @State private var password = ""
        @State private var administratorUsername = ""
        @State private var recievedError: Bool = false
        @State private var signInPressed: Bool = false
        @State private var errorMessages = [String]()
        @State private var role: Role = .administrator
        @FocusState private var focusedField: Field?
        
        var body: some View {
            GeometryReader { g in
                VStack {
                    Image("Banner-Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    HStack {
                        Spacer()
                        VStack(spacing: 15) {
                            
                            TextField("Username", text: $username)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(.none)
                                .focused($focusedField, equals: .usernameField)
                            
                                .frame(maxWidth: g.size.width * 0.40)
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(.none)
                                .focused($focusedField, equals: .passwordField)
                            
                                .frame(maxWidth: g.size.width * 0.40)
                            
                            if role != .administrator {
                                
                                TextField("Administrator Username", text: $administratorUsername)
                                        .textFieldStyle(.roundedBorder)
                                        .disableAutocorrection(.none)
                                        .focused($focusedField, equals: .administatorUsernameField)
                                
                                        .frame(maxWidth: g.size.width * 0.50)
                            }
                            
                            Picker("Choose a Role", selection: $role) {
                                ForEach(Role.allCases) { role in
                                    Text(role.rawValue.capitalized).tag(role)
                                }
                            }
                            
                            .frame(maxWidth: g.size.width * 0.40)
                            
                            Button ("Sign In") {
                                if username.isEmpty {
                                    focusedField = .usernameField
                                } else if password.isEmpty {
                                    focusedField = .passwordField
                                } else if role != .administrator && administratorUsername.isEmpty {
                                    focusedField = .administatorUsernameField
                                } else {
                                    signInPressed = true
                                    Task {
                                        handleSignIn()
                                    }
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Divider()
                            
                                .frame(maxWidth: g.size.width * 0.60)
                            
                            #if os(iOS)
                            NavigationLink("Register as Administrator") {
                                RegisterView(for: .administrator)
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .padding(.bottom)
                            #else
                            Button("Register as Administrator") {
                                withAnimation {
                                    showRegisterView.toggle()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .padding(.bottom)
                            #endif

                            if signInPressed {
                                ProgressView()
                            }
                            
                            if recievedError {
                                ForEach(errorMessages, id: \.self) { error in
                                    ErrorView(message: error)
                                        .animation(.easeInOut(duration: 3), value: recievedError)
                                        .transition(.asymmetric(insertion: .slide, removal: .move(edge: .bottom)))
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
            withAnimation {
                recievedError = false
            }
            errorMessages.removeAll()
            Network.shared.client.fetch(
                query: AuthenticationQuery(username: username,password: password,role: role.rawValue)) { res in
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
                            if data.loginUser.code == 200 {
                                Network.shared.token = data.loginUser.token
                                withAnimation {
                                    user.isLoggedIn.toggle()
                                }
                            }
                            else if data.loginUser.code == 403 {
                                errorMessages.append("Invalid Username or Password")
                            }
                            else {
                                errorMessages.append(data.loginUser.message)
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
        struct ErrorView: View {
            var message: String
            var body: some View {
                Label {
                    Text(message)
                        .font(.body)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.7)
                        .foregroundColor(.red)
                } icon: {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .symbolRenderingMode(.multicolor)
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.red, lineWidth: 3)
                        .opacity(0.5)
                    
                }
                .transition(.asymmetric(insertion: .slide, removal: .move(edge: .bottom)))
            }
        }
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
