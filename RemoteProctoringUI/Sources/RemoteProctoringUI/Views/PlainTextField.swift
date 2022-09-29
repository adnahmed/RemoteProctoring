//
//  AuthFormSupporting.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI

struct PlainTextField: ViewModifier {
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
    public func noSideEffects() -> some View {
        modifier(PlainTextField())
    }
}

