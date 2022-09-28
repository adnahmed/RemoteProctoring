import SwiftUI
import LiveKit
import SFSafeSymbols

struct ExamParticipantView: View {
    
    @ObservedObject var participant: ObservableParticipant
    
    var videoViewMode: VideoView.LayoutMode = .fit
    
    func bgView(systemSymbol: SFSymbol, geometry: GeometryProxy) -> some View {
        Image(systemSymbol: systemSymbol)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.gray)
            .frame(width: min(geometry.size.width, geometry.size.height) * 0.3)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
    }
    
    var body: some View {
                // Background color
//                Color.gray
//                    .ignoresSafeArea()
                // VideoView for the Participant
                if let publication = participant.mainVideoPublication, !publication.muted, let track = publication.track as? VideoTrack, let remotePub = publication as? RemoteTrackPublication {
                    SwiftUIVideoView(track, layoutMode: videoViewMode)
                }
                //                if let publication = participant.mainVideoPublication as? RemoteTrackPublication, case .notAllowed = publication.subscriptionState {
                //                    // Show no permission icon
                //                    bgView(systemSymbol: .exclamationmarkCircle, geometry: geometry)
                //                }
                //                VStack(alignment: .trailing, spacing: 0) {
                //                    // Bottom user info bar
                //                    HStack {
                //                        Text("\(participant.identity)") //  (\(participant.publish ?? "-"))
                //                            .lineLimit(1)
                //                            .truncationMode(.tail)
                //
                //                        if participant.connectionQuality == .excellent {
                //                            Image(systemSymbol: .wifi)
                //                                .foregroundColor(.green)
                //                        } else if participant.connectionQuality == .good {
                //                            Image(systemSymbol: .wifi)
                //                                .foregroundColor(Color.orange)
                //                        } else if participant.connectionQuality == .poor {
                //                            Image(systemSymbol: .wifiExclamationmark)
                //                                .foregroundColor(Color.red)
                //                        }
                //
                //                    }.padding(5)
                //                    .frame(minWidth: 0, maxWidth: .infinity)
                //                    .background(Color.black.opacity(0.5))
                //                }
                //            }
                //            .cornerRadius(8)
            }
    }
