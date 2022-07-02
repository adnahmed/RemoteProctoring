//
//  User.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 28/06/2022.
//

import Foundation

enum Role: String, CaseIterable, Identifiable {
    var id: Self { self }
    case administrator, proctor, examinee
}

class User: ObservableObject {
    @Published var isLoggedIn: Bool = false
    init() {
        if Network.shared.token != nil {
            isLoggedIn = true
        }
    }
}
