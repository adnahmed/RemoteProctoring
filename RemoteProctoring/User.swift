//
//  User.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 28/06/2022.
//

import Foundation

class User: ObservableObject {
    @Published var isLoggedIn: Bool = false
    init() {
        if Network.shared.token != nil {
            isLoggedIn = true
        }
    }
}
