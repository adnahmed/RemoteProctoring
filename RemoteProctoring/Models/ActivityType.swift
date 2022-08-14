//
//  ActivityType.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 13/08/2022.
//

import Foundation
import SwiftUI

enum ActivityType: String {
    case LOOK_LEFT = "looked left",
         LOOK_RIGHT = "looked right",
         LOOK_UP = "looked up",
         LOOK_DOWN = "looked down",
         
         HEAD_LEFT = "moved head left",
         HEAD_RIGHT = "moved head right",
         HEAD_UP = "moved head up",
         HEAD_DOWN = "moved head down",
         
         SPEAK = "spoke"
    
        // Add more cases for detected objects
        // smartphone, tablet, laptop, any digital device
}

extension ActivityType {
    var display: some View {
        switch self {
        case .LOOK_LEFT:
            return HStack {
                Image(systemName: "arrow.left")
                Image(systemName: "eye")
            }
        case .LOOK_RIGHT:
            return HStack {
                Image(systemName: "eye")
                Image(systemName: "arrow.right")
            }
        case .LOOK_UP:
            return HStack {
                Image(systemName: "eye")
                Image(systemName: "arrow.up")
            }
        case .LOOK_DOWN:
            return HStack {
                Image(systemName: "eye")
                Image(systemName: "arrow.down")
            }
        case .HEAD_LEFT:
            return HStack {
                Image(systemName: "arrow.left")
                Image(systemName: "person")
            }
        case .HEAD_RIGHT:
            return HStack {
                Image(systemName: "person")
                Image(systemName: "arrow.right")
            }
        case .HEAD_UP:
            return HStack {
                Image(systemName: "person")
                Image(systemName: "arrow.up")
            }
        case .HEAD_DOWN:
            return HStack {
                Image(systemName: "person")
                Image(systemName: "arrow.up")
            }
        case .SPEAK:
            return HStack {
                Image(systemName: "person")
                Image(systemName: "speaker.wave.2")
            }
        }
    }
}
