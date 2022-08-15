//
//  ExamRoomViewSupporting.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 15/08/2022.
//

import SwiftUI

// We don't need it but keeping it for future ref.
struct MessageView : View {
    var message: RoomMessage
    var body() -> some View {
        let isMe = message.senderSid == room.room.localParticipant?.sid
        
        return HStack {
            if isMe {
                Spacer()
            }
            Text(message.text)
                .padding(8)
                .foregroundColor(Color.white)
                .cornerRadius(18)
            if !isMe {
                Spacer()
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
    }
}


struct ExamRoomViewSupporting: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ExamRoomViewSupporting_Previews: PreviewProvider {
    static var previews: some View {
        ExamRoomViewSupporting()
    }
}
