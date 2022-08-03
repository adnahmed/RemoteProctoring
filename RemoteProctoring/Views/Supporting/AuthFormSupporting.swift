//
//  AuthFormSupporting.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI

enum AuthFormField: Hashable {
    case usernameField, passwordField
}


struct RegisterButtonModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.bottom)
        
    }
}

extension View {
    func registerButton() -> some View {
        modifier(RegisterButtonModifer())
    }
}

struct AuthTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled(true)
            .textFieldStyle(.roundedBorder)
#if os(iOS)
            .textInputAutocapitalization(.never)
#endif
    }
}

extension View {
    func authTextField() -> some View {
        modifier(AuthTextFieldModifier())
    }
}

