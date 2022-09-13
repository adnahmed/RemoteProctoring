//
//  UserDetails+Hashable.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/09/2022.
//

import Foundation

extension UserDetails: Hashable {
    public static func == (lhs: UserDetails, rhs: UserDetails) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.username)
        hasher.combine(self.givenName)
        hasher.combine(self.role)
    }
}
