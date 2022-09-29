//
//  EffectView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/09/2022.
//
import SwiftUI

#if os(macOS)
public struct AcrylicMaterialEffectView: NSViewRepresentable {
    private let material: NSVisualEffectView.Material
    private let blendingMode: NSVisualEffectView.BlendingMode
    private let emphasized: Bool
    public init(
        _ material: NSVisualEffectView.Material = .headerView,
        blendingMode: NSVisualEffectView.BlendingMode = .withinWindow,
        emphasized: Bool = false
    ) {
        self.material = material
        self.blendingMode = blendingMode
        self.emphasized = emphasized
    }

    public func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.isEmphasized = emphasized
        view.state = .followsWindowActiveState
        return view
    }

    public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
    }

    @ViewBuilder
    public static func selectionBackground(_ condition: Bool = true) -> some View {
        if condition {
            AcrylicMaterialEffectView(.selection, blendingMode: .withinWindow, emphasized: true)
        } else {
            Color.clear
        }
    }
}

#if DEBUG
struct AcrylicMaterialEffectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle().fill(.red)
                .frame(width: 500, height: 500)
            
        }
    }
}
#endif
#endif
