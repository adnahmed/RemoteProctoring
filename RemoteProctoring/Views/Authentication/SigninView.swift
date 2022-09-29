//
//  AuthFormView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import Apollo
import Neumorphic
import RemoteProctoringUI
import RemoteProctoringModel
import SwiftUI

struct SigninView: View {
    @EnvironmentObject var user: User
    @State var usernameOrEmail = ""
    @State var password = ""
    @State var recievedError: Bool = false
    @State var signInPressed: Bool = false
    @State var errorMessages: [String] = []
    @FocusState var focusedField: SigninFormField?
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
                        .noSideEffects()
                        .focused($focusedField, equals: .usernameOrEmailField)
                        .onChange(of: usernameOrEmail) { _ in
                            withAnimation {
                                errorMessages.removeAll()
                            }
                        }
                        .padding()
                    SecureField("Password", text: $password)
                        .noSideEffects()
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
    
#if DEBUG
    @ObservedObject var iO = injectionObserver
#endif
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
