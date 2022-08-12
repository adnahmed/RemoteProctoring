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

    @State private var screenPickerPresented = false
    @State private var showConnectionTime = true

    func messageView(_ message: RoomMessage) -> some View {

        let isMe = message.senderSid == room.room.localParticipant?.sid

        return HStack {
            if isMe {
                Spacer()
            }

            //            VStack(alignment: isMe ? .trailing : .leading) {
            //                Text(message.identity)
            Text(message.text)
                .padding(8)
//                .background(isMe ? Color.lkRed : Color.lkGray3)
                .foregroundColor(Color.white)
                .cornerRadius(18)
            //            }
            if !isMe {
                Spacer()
            }
        }.padding(.vertical, 5)
        .padding(.horizontal, 10)
    }

    func scrollToBottom(_ scrollView: ScrollViewProxy) {
        guard let last = room.messages.last else { return }
        withAnimation {
            scrollView.scrollTo(last.id)
        }
    }

//    func messagesView(geometry: GeometryProxy) -> some View {
//
//        VStack(spacing: 0) {
//            ScrollViewReader { scrollView in
//                ScrollView(.vertical, showsIndicators: true) {
//                    LazyVStack(alignment: .center, spacing: 0) {
//                        ForEach(room.messages) {
//                            messageView($0)
//                        }
//                    }
//                    .padding(.vertical, 12)
//                    .padding(.horizontal, 7)
//                }
//                .onAppear(perform: {
//                    // Scroll to bottom when first showing the messages list
//                    scrollToBottom(scrollView)
//                })
//                .onChange(of: room.messages, perform: { _ in
//                    // Scroll to bottom when there is a new message
//                    scrollToBottom(scrollView)
//                })
//                .frame(
//                    minWidth: 0,
//                    maxWidth: .infinity,
//                    minHeight: 0,
//                    maxHeight: .infinity,
//                    alignment: .topLeading
//                )
//            }
//            HStack(spacing: 0) {
//
//                TextField("Enter message", text: $room.textFieldString)
//                    .textFieldStyle(PlainTextFieldStyle())
//                    .disableAutocorrection(true)
//                // TODO: add iOS unique view modifiers
//                // #if os(iOS)
//                // .autocapitalization(.none)
//                // .keyboardType(type.toiOSType())
//                // #endif
//
//                //                    .overlay(RoundedRectangle(cornerRadius: 10.0)
//                //                                .strokeBorder(Color.white.opacity(0.3),
//                //                                              style: StrokeStyle(lineWidth: 1.0)))
//
//                Button {
//                    room.sendMessage()
//                } label: {
//                    Image(systemSymbol: .paperplaneFill)
//                        .foregroundColor(room.textFieldString.isEmpty ? nil : Color.lkRed)
//                }
//                .buttonStyle(.borderless)
//
//            }
//            .padding()
//            .background(Color.lkGray2)
//        }
//        .background(Color.lkGray1)
//        .cornerRadius(8)
//        .frame(
//            minWidth: 0,
//            maxWidth: geometry.isTall ? .infinity : 320
//        )
//    }

    func content(geometry: GeometryProxy) -> some View {

        VStack {

            if showConnectionTime {
                Text("Connected (\([room.room.serverRegion, "\(String(describing: room.room.connectStopwatch.total().rounded(to: 2)))s"].compactMap { $0 }.joined(separator: ", ")))")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
            }

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
//                            .overlay(RoundedRectangle(cornerRadius: 5)
//                                        .stroke(Color.lkRed.opacity(0.7), lineWidth: 5.0))
//                                     in: Text("SELECTED")
                                .font(.system(size: 10))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 2)
//                                .background(Color.lkRed.opacity(0.7))
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
                // Show messages view if enabled
//                if room.showMessagesView {
//                    messagesView(geometry: geometry)
//                }
            }
        }
        .padding(5)
    }

    var body: some View {

        GeometryReader { geometry in
            content(geometry: geometry)
                .toolbar {
                    ToolbarItemGroup(placement: toolbarPlacement) {

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

//                        #if os(macOS)
//                        // Pin on top
//                        Toggle(isOn: $windowAccess.pinned) {
//                            Image(systemSymbol: windowAccess.pinned ? .pinFill : .pin)
//                                .renderingMode(.original)
//                        }
//                        #endif

                        // VideoView mode switcher
                        Picker("Mode", selection: $appCtx.videoViewMode) {
                            Text("Fit").tag(VideoView.LayoutMode.fit)
                            Text("Fill").tag(VideoView.LayoutMode.fill)
                        }
                        .pickerStyle(SegmentedPickerStyle())

                        Spacer()

                        Group {

                            // Toggle camera enabled
                            if !room.cameraTrackState.isPublished || !CameraCapturer.canSwitchPosition() {
                                Button(action: {
                                    room.toggleCameraEnabled()
                                },
                                label: {
//                                    Image(systemSymbol: .videoFill)
//                                        .renderingMode(room.cameraTrackState.isPublished ? .original : .template)
                                })
                                // disable while publishing/un-publishing
                                .disabled(room.cameraTrackState.isBusy)
                            } else {
                                Menu {
                                    Button("Switch position") {
                                        room.switchCameraPosition()
                                    }
                                    Button("Disable") {
                                        room.toggleCameraEnabled()
                                    }
                                } label: {
//                                    Image(systemSymbol: .videoFill)
//                                        .renderingMode(.original)
                                }
                            }

                            // Toggle microphone enabled
                            Button(action: {
                                room.toggleMicrophoneEnabled()
                            },
                            label: {
//                                Image(systemSymbol: .micFill)
//                                    .renderingMode(room.microphoneTrackState.isPublished ? .original : .template)
                            })
                            // disable while publishing/un-publishing
                            .disabled(room.microphoneTrackState.isBusy)

                            #if os(iOS)
                            Button(action: {
                                print("screenshare")
                                //                                room.toggleScreenShareEnabled(screenShareSource: nil)
                            },
                            label: {
//                                Image(systemSymbol: .rectangleFillOnRectangleFill)
//                                    .renderingMode(room.screenShareTrackState.isPublished ? .original : .template)
                            })
                            #elseif os(macOS)
                            Button(action: {
                                if room.screenShareTrackState.isPublished {
                                    // turn off screen share
//                                    room.toggleScreenShareEnabled(screenShareSource: nil)
                                } else {
                                    screenPickerPresented = true
                                }
                            },
                            label: {
//                                Image(systemSymbol: .rectangleFillOnRectangleFill)
//                                    .renderingMode(room.screenShareTrackState.isPublished ? .original : .template)
//                                    .foregroundColor(room.screenShareTrackState.isPublished ? Color.green : Color.white)
                            })
                            .popover(isPresented: $screenPickerPresented) {
//                                ScreenShareSourcePickerView { source in
//                                    room.toggleScreenShareEnabled(screenShareSource: source)
//                                    screenPickerPresented = false
//                                }.padding()
                            }
                            #endif

                            // Toggle messages view (chat example)
                            Button(action: {
                                withAnimation {
                                    room.showMessagesView.toggle()
                                }
                            },
                            label: {
//                                Image(systemSymbol: .messageFill)
//                                    .renderingMode(room.showMessagesView ? .original : .template)
                            })

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
//                            Image(systemSymbol: .gear)
//                                .renderingMode(.original)
                        }

                        // Disconnect
                        Button(action: {
                            roomCtx.disconnect()
                        },
                        label: {
//                            Image(systemSymbol: .xmarkCircleFill)
//                                .renderingMode(.original)
                        })
                    }

                }
        }
//        #if os(macOS)
//        .withHostingWindow { self.windowAccess.set(window: $0) }
//        #endif
        .onAppear {
            //
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                DispatchQueue.main.async {
                    withAnimation {
                        self.showConnectionTime = false
                    }
                }
            }
        }
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        ExamRoomView()
    }
}
