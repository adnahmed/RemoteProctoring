//
//  User.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 28/06/2022.
//

import Foundation

class User : ObservableObject {
    @Published var isLoggedIn: Bool = false
    var userDetails: UserDetails? = nil
    var name: String {
        get {
            PersonNameComponents(namePrefix: userDetails?.prefix ?? "",
                                 givenName: userDetails?.givenName ?? "",
                                 middleName: userDetails?.middleName ?? "",
                                 familyName: userDetails?.lastName ?? "")
            .formatted()
        }
    }
    init() {
        guard Network.shared.token != nil else { return }
        isLoggedIn = true
    }
}


