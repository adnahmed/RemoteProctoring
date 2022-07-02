//
//  Store.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 02/07/2022.
//

import Foundation

final class Store : ObservableObject {
    @Published var groups: [Group]
    init() {
       groups = []
    }
}
