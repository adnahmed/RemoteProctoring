//
//  TickCross.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 29/09/2022.
//

import SwiftUI

public struct TickCross: View {
    var value: Binding<Bool>
    public init(value: Binding<Bool>) {
        self.value = value
    }
    // TODO: Add animation on change
    public var body: some View {
        if value.wrappedValue {
            Image(systemName: "checkmark")
                .symbolVariant(.circle)
                .foregroundStyle(.green)
                .symbolRenderingMode(.multicolor)
        }
        else {
            Image(systemName: "x")
                .foregroundColor(.red)
                .symbolVariant(.circle)
                .symbolRenderingMode(.multicolor)
        }
    }
}

#if DEBUG
struct TickCross_Previews: PreviewProvider {
    static var previews: some View {
        TickCross(value: .constant(true))
        TickCross(value: .constant(false))
    }
}

#endif
