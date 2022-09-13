//
//  ExamsView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/09/2022.
//

import SwiftUI
import LiveKit
struct ExamsView: View {

    var body: some View {
        ExamListView()
    }
    
    struct ExamListView: View {
        @State private var exams: [ExamData] = []
        var body: some View {
            ForEach(exams) { exam in
                ExamItemView(exam: exam)
            }
            .onAppear {
            }
        }
    }
    
    struct ExamItemView: View {
        @EnvironmentObject var user: User
        var exam: ExamData
        var body: some View {
            HStack {
                Text(exam.name)
                Spacer()
                if (DateInterval(start: exam.startDate, end: exam.endDate).contains(.now) && user.data.role != .administrator) {
                    NavigationLink {
                        if user.data.role == .proctor {
                            ProctorExamView()
                        } else {
                            ExamSolutionView()
                        }
                    } label: {
                        Text(user.data.role == .proctor ? "Start" : "Join")
                    }
                    .environmentObject(Exam(data: exam))
                }
            }
        }
    }
    
    
}

#if DEBUG
class Exam: ObservableObject  {
    var data: ExamData
    @Published var startDate: Date = .now
    var token: String = ""
    init(data: ExamData) {
        self.data = data
        connect()
    }
    private func connect()  {
        // TODO: Fetch Token with query
        Network.shared.room.room.connect(Network.shared.lkEndpoint, token)
    }
    
    deinit {
        // TODO: perform cleanup for exam end queries
    }
}

struct ExamData: Identifiable, Hashable {
    var id: String
    var name: String
    var subject: String
    var startDate: Date, endDate: Date
}

struct ExamsView_Previews: PreviewProvider {
    static var previews: some View {
        ExamsView()
    }
}
#endif
