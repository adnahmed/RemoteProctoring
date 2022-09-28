//
//  User.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 28/06/2022.
//

import Foundation

class User: ObservableObject {
    var data: UserData = UserData()
    var isLoggedIn: Bool {
        return SecureStore.shared.token != nil
    }
}

struct UserData: Identifiable, Hashable {
    
    static func == (lhs: UserData, rhs: UserData) -> Bool {
        return lhs.id == rhs.id
    }
    
    var raw: UserDetails? = nil
    
    var fullName: String? {
        get {
            PersonNameComponents(namePrefix: raw?.prefix,
                                 givenName: raw?.givenName,
                                 middleName: raw?.middleName,
                                 familyName: raw?.lastName)
            .formatted()
        }
    }
    
    var id: UUID? {
        get {
            return UUID(uuidString: raw?.id ?? "")
        }
        set {
            raw?.id = newValue?.uuidString ?? ""
        }
    }
    
}

