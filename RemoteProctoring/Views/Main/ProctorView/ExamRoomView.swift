//
//  RoomView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 11/08/2022.
//

import SwiftUI
import LiveKit

#if !os(macOS)
let adaptiveMin = 170.0
let toolbarPlacement: ToolbarItemPlacement = .bottomBar
#else
let adaptiveMin = 300.0
let toolbarPlacement: ToolbarItemPlacement = .primaryAction
#endif
struct ExamRoomView: View {
    @EnvironmentObject var appCtx: LiveKitContext
    @EnvironmentObject var roomCtx: RoomContext
    @EnvironmentObject var room: ExamObservableRoom
    
    func content(geometry: GeometryProxy) -> some View {
        
        VStack {
            
            if case .reconnecting = room.room.connectionState {
                Text("Re-connecting...")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
            }
            
            HorVStack(axis: geometry.isTall ? .vertical : .horizontal, spacing: 5) {
                
                Group {
                    if let focusParticipant = room.focusParticipant {
                        ZStack(alignment: .bottomTrailing) {
                            ExamParticipantView(participant: focusParticipant,
                                                videoViewMode: appCtx.videoViewMode) { _ in
                                room.focusParticipant = nil
                            }
                                                .font(.system(size: 10))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.white)
                                                .padding(.horizontal, 5)
                                                .padding(.vertical, 2)
                                                .cornerRadius(8)
                                                .padding(.vertical, 35)
                                                .padding(.horizontal, 10)
                        }
                        
                    } else {
                        ParticipantLayout(room.allParticipants.values, spacing: 5) { participant in
                            ExamParticipantView(participant: participant,
                                                videoViewMode: appCtx.videoViewMode) { participant in
                                room.focusParticipant = participant
                                
                            }
                        }
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity
                )
            }
        }
        .padding(5)
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            content(geometry: geometry)
                .toolbar { ToolbarItemGroup(placement: toolbarPlacement) {
                    
                    Text("(\(room.room.remoteParticipants.count)) ")
                    
#if os(macOS)
                    if let name = room.room.name {
                        Text(name)
                            .fontWeight(.bold)
                    }
                    
                    if let identity = room.room.localParticipant?.identity {
                        Text(identity)
                    }
#endif
                    
                    Picker("Mode", selection: $appCtx.videoViewMode) {
                        Text("Fit").tag(VideoView.LayoutMode.fit)
                        Text("Fill").tag(VideoView.LayoutMode.fill)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Spacer()
                    
                    Group {
                        if !room.cameraTrackState.isPublished || !CameraCapturer.canSwitchPosition() {
                            Button(action: {
                                room.toggleCameraEnabled()
                            },
                                   label: {
                            }
                            )}
                        else {
                            Menu {
                                Button("Switch position") {
                                    room.switchCameraPosition()
                                }
                                Button("Disable") {
                                    room.toggleCameraEnabled()
                                }
                            } label: {
                            }
                        }
                    }
                    
                    Spacer()
                    Menu {
#if os(macOS)
                        Button {
                            if let url = URL(string: "livekit://") {
                                NSWorkspace.shared.open(url)
                            }
                        } label: {
                            Text("New window")
                        }
                        
                        Divider()
#endif
                        Toggle("Show info overlay", isOn: $appCtx.showInformationOverlay)
                        Divider()
                        Group {
                            Toggle("VideoView visible", isOn: $appCtx.videoViewVisible)
                            Toggle("VideoView preferMetal", isOn: $appCtx.preferMetal)
                            Toggle("VideoView flip", isOn: $appCtx.videoViewMirrored)
                        }
                        
                        Divider()
                        
                        Button {
                            roomCtx.room.unpublishAll()
                        } label: {
                            Text("Unpublish all")
                        }
                        
                        Divider()
                        
                        Menu {
                            Button {
                                roomCtx.room.room.sendSimulate(scenario: .nodeFailure)
                            } label: {
                                Text("Node failure")
                            }
                            
                            Button {
                                roomCtx.room.room.sendSimulate(scenario: .serverLeave)
                            } label: {
                                Text("Server leave")
                            }
                            
                            Button {
                                roomCtx.room.room.sendSimulate(scenario: .migration)
                            } label: {
                                Text("Migration")
                            }
                            
                            Button {
                                roomCtx.room.room.sendSimulate(scenario: .speakerUpdate(seconds: 3))
                            } label: {
                                Text("Speaker update")
                            }
                            
                        } label: {
                            Text("Simulate scenario")
                        }
                        
                        Menu {
                            Button {
                                roomCtx.room.room.localParticipant?.setTrackSubscriptionPermissions(allParticipantsAllowed: true)
                            } label: {
                                Text("Allow all")
                            }
                            
                            Button {
                                roomCtx.room.room.localParticipant?.setTrackSubscriptionPermissions(allParticipantsAllowed: false)
                            } label: {
                                Text("Disallow all")
                            }
                        } label: {
                            Text("Track permissions")
                        }
                        
                    } label: {
                    }
                    
                    Button(action: {
                        roomCtx.disconnect()
                    },
                           label: {
                    })
                }
                } } }
}
struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        ExamRoomView()
    }
}
