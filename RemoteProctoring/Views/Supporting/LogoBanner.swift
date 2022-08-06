//
//  LogoBanner.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 31/07/2022.
//

import SwiftUI

struct LogoBanner: View {
    var body: some View {
        Image("Banner-Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct LogoBanner_Previews: PreviewProvider {
    static var previews: some View {
        LogoBanner()
    }
}
