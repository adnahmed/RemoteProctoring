//
//  ExamParticipantView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/08/2022.
//

import SwiftUI
import LiveKit

struct ExamParticipantView: View {

    @ObservedObject var participant: ObservableParticipant
    @EnvironmentObject var appCtx: LiveKitContext

    var videoViewMode: VideoView.LayoutMode = .fill
    var onTap: ((_ participant: ObservableParticipant) -> Void)?

    @State private var isRendering: Bool = false
    @State private var dimensions: Dimensions?
    @State private var trackStats: TrackStats?

    var body: some View {
        GeometryReader { geometry in

            ZStack(alignment: .bottom) {
                // Background color
                Color.lkGray1
                    .ignoresSafeArea()

                // VideoView for the Participant
                if let publication = participant.mainVideoPublication,
                   !publication.muted,
                   let track = publication.track as? VideoTrack,
                   appCtx.videoViewVisible {
                    ZStack(alignment: .topLeading) {
                        SwiftUIVideoView(track,
                                         layoutMode: videoViewMode,
                                         mirrorMode: appCtx.videoViewMirrored ? .mirror : .auto,
                                         debugMode: appCtx.showInformationOverlay,
                                         // isRendering: $isRendering,
                                         dimensions: $dimensions,
                                         trackStats: $trackStats)
                                          if appCtx.showInformationOverlay {
                            HStack(alignment: .top, spacing: 5) {

                  
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Video")
                                        .fontWeight(.bold)

                                    HStack(alignment: .top, spacing: 3) {
                                        if let dimensions = dimensions {
                                            Text("\(dimensions.width)x\(dimensions.height)")
                                        }
                                        if let codecName = trackStats?.codecName {
                                            HStack(spacing: 3) {
                                                Text(codecName)
                                                    .fontWeight(.bold)
                                            }
                                        }
                                    }

                                    if let trackStats = trackStats, trackStats.bpsSent != 0 {
                                        HStack(spacing: 3) {
                                            Image(systemSymbol: .arrowUpCircle)
                                            Text(trackStats.formattedBpsSent())
                                        }
                                    }
                                    if let trackStats = trackStats, trackStats.bpsReceived != 0 {
                                        HStack(spacing: 3) {
                                            Image(systemSymbol: .arrowDownCircle)
                                            Text(trackStats.formattedBpsReceived())
                                        }
                                    }
                                }
                                .font(.system(size: 10))
                                .foregroundColor(Color.white)
                                .padding(5)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(8)
                            }
                            .padding(5)
                        }
                    }
                } else if let publication = participant.mainVideoPublication as? RemoteTrackPublication,
                          case .notAllowed = publication.subscriptionState {
                } else {
                }

                VStack(alignment: .trailing, spacing: 0) {
                    // Show the sub-video view
                    if let subVideoTrack = participant.subVideoTrack {
                        SwiftUIVideoView(subVideoTrack,
                                         layoutMode: .fill,
                                         mirrorMode: appCtx.videoViewMirrored ? .mirror : .auto
                        )
                        .background(Color.black)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: min(geometry.size.width, geometry.size.height) * 0.3)
                        .cornerRadius(8)
                        .padding()
                    }

                    // Bottom user info bar
                    HStack {
                        Text("\(participant.identity)") //  (\(participant.publish ?? "-"))
                            .lineLimit(1)
                            .truncationMode(.tail)

                        if let publication = participant.mainVideoPublication,
                           !publication.muted {

                            // is remote
                            if let remotePub = publication as? RemoteTrackPublication {
                                Menu {
                                    if case .subscribed = remotePub.subscriptionState {
                                        Button {
                                            remotePub.set(subscribed: false)
                                        } label: {
                                            Text("Unsubscribe")
                                        }
                                    } else if case .unsubscribed = remotePub.subscriptionState {
                                        Button {
                                            remotePub.set(subscribed: true)
                                        } label: {
                                            Text("Subscribe")
                                        }

                                    }
                                } label: {
                                    if case .subscribed = remotePub.subscriptionState {
                                        Image(systemSymbol: .videoFill)
                                            .foregroundColor(Color.green)
                                    } else if case .notAllowed = remotePub.subscriptionState {
                                        Image(systemSymbol: .exclamationmarkCircle)
                                            .foregroundColor(Color.red)
                                    } else {
                                        Image(systemSymbol: .videoSlashFill)
                                    }
                                }
                                #if os(macOS)
                                .menuStyle(BorderlessButtonMenuStyle(showsMenuIndicator: true))
                                #elseif os(iOS)
                                .menuStyle(BorderlessButtonMenuStyle())
                                #endif
                                .fixedSize()
                            } else {
                                // local
                                Image(systemSymbol: .videoFill)
                                    .foregroundColor(Color.green)
                            }

                        } else {
                            Image(systemSymbol: .videoSlashFill)
                                .foregroundColor(Color.white)
                        }

                        if let publication = participant.firstAudioPublication,
                           !publication.muted {

                            // is remote
                            if let remotePub = publication as? RemoteTrackPublication {
                                Menu {
                                    if case .subscribed = remotePub.subscriptionState {
                                        Button {
                                            remotePub.set(subscribed: false)
                                        } label: {
                                            Text("Unsubscribe")
                                        }
                                    } else if case .unsubscribed = remotePub.subscriptionState {
                                        Button {
                                            remotePub.set(subscribed: true)
                                        } label: {
                                            Text("Subscribe")
                                        }

                                    }
                                } label: {
                                    if case .subscribed = remotePub.subscriptionState {
                                        Image(systemSymbol: .micFill)
                                            .foregroundColor(Color.orange)
                                    } else if case .notAllowed = remotePub.subscriptionState {
                                        Image(systemSymbol: .exclamationmarkCircle)
                                            .foregroundColor(Color.red)
                                    } else {
                                        Image(systemSymbol: .micSlashFill)
                                    }
                                }
                                #if os(macOS)
                                .menuStyle(BorderlessButtonMenuStyle(showsMenuIndicator: true))
                                #elseif os(iOS)
                                .menuStyle(BorderlessButtonMenuStyle())
                                #endif
                                .fixedSize()
                            } else {
                                // local
                                Image(systemSymbol: .micFill)
                                    .foregroundColor(Color.orange)
                            }

                        } else {
                            Image(systemSymbol: .micSlashFill)
                                .foregroundColor(Color.white)
                        }

                        if participant.connectionQuality == .excellent {
                            Image(systemSymbol: .wifi)
                                .foregroundColor(.green)
                        } else if participant.connectionQuality == .good {
                            Image(systemSymbol: .wifi)
                                .foregroundColor(Color.orange)
                        } else if participant.connectionQuality == .poor {
                            Image(systemSymbol: .wifiExclamationmark)
                                .foregroundColor(Color.red)
                        }

                    }.padding(5)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.black.opacity(0.5))
                }
            }
            .cornerRadius(8)
            // Glow the border when the participant is speaking
            .overlay(
                participant.isSpeaking ?
                    RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 5.0)
                    : nil
            )
        }.gesture(TapGesture()
                    .onEnded { _ in
                        // Pass the tap event
                        onTap?(participant)
                    })
    }
}


