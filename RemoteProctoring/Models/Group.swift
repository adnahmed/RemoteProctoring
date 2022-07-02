//
//  Group.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 02/07/2022.
//

import Foundation

struct Examinee: Hashable {}
struct Proctor: Hashable {}

struct Group : Hashable {
    var name: String = "group"
    var examinees: [Examinee] = []
    var proctors: [Proctor] = []
}
