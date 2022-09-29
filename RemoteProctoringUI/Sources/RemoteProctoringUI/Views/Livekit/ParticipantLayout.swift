//
//  ParticipantLayout.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 29/09/2022.
//

import SwiftUI

import LiveKit
import SwiftUI
import OrderedCollections
struct ParticipantLayout<Content: View>: View {

    let views: [AnyView]
    let spacing: CGFloat

    init<Data: RandomAccessCollection>(
        _ data: Data,
        id: KeyPath<Data.Element, Data.Element> = \.self,
        spacing: CGFloat,
        @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.spacing = spacing
        self.views = data.map { AnyView(content($0[keyPath: id])) }
    }


    var body: some View {
        GeometryReader { geometry in
            if views.isEmpty {
                EmptyView()
            } else if geometry.size.width <= 300 {
                grid(axis: .vertical, geometry: geometry)
            } else if geometry.size.height <= 300 {
                grid(axis: .horizontal, geometry: geometry)
            } else {

                let verticalWhenTall: Axis = geometry.isTall ? .vertical : .horizontal
                let horizontalWhenTall: Axis = geometry.isTall ? .horizontal : .vertical

                switch views.count {
                // simply return first view
                case 1: views[0]
                case 3: HorVStack(axis: verticalWhenTall, spacing: spacing) {
                    views[0]
                    HorVStack(axis: horizontalWhenTall, spacing: spacing) {
                        views[1]
                        views[2]
                    }
                }
                case 5: HorVStack(axis: verticalWhenTall, spacing: spacing) {
                    views[0]
                    if geometry.isTall {
                        HStack(spacing: spacing) {
                            views[1]
                            views[2]
                        }
                        HStack(spacing: spacing) {
                            views[3]
                            views[4]

                        }
                    } else {
                        VStack(spacing: spacing) {
                            views[1]
                            views[3]
                        }
                        VStack(spacing: spacing) {
                            views[2]
                            views[4]
                        }
                    }
                }
                //            case 6:
                //                if geometry.isTall {
                //                    VStack {
                //                        HStack {
                //                            views[0]
                //                            views[1]
                //                        }
                //                        HStack {
                //                            views[2]
                //                            views[3]
                //                        }
                //                        HStack {
                //                            views[4]
                //                            views[5]
                //                        }
                //                    }
                //                } else {
                //                    VStack {
                //                        HStack {
                //                            views[0]
                //                            views[1]
                //                            views[2]
                //                        }
                //                        HStack {
                //                            views[3]
                //                            views[4]
                //                            views[5]
                //                        }
                //                    }
                //                }
                default:
                    let c = computeColumn(with: geometry)
                    VStack(spacing: spacing) {
                        ForEach(0...(c.y - 1), id: \.self) { y in
                            HStack(spacing: spacing) {
                                ForEach(0...(c.x - 1), id: \.self) { x in
                                    let index = (y * c.x) + x
                                    if index < views.count {
                                        views[index]
                                    }
                                }
                            }
                        }
                    }

                }
            }
        }
    }
}

// TODO: Create Fake Layout
//struct ParticipantLayout_Previews: PreviewProvider {
//    static var previews: some View {
//        ParticipantLayout() { data in
//
//    }
//}
