//
//  AuthFormSupporting.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI

enum SigninFormField: Hashable {
    case usernameOrEmailField, passwordField
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

