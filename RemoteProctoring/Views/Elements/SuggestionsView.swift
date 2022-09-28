//
//  SuggestionsView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 18/08/2022.
//

import SwiftUI

struct SuggestionsView: View {
    var body: some View {
        Text("suggestionToDisplay").searchCompletion("completedTo")
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

#if DEBUG
struct SuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsView()
    }
}
#endif
