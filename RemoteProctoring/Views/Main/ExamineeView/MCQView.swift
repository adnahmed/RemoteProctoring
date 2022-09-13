//
//  MCQView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/09/2022.
//

import SwiftUI

struct MCQView: View {
    var body: some View {
        MCQQuestionList()
    }
    struct MCQQuestionList: View {
        @State private var mcqs: [MCQ] = []
        var body: some View {
            ForEach(mcqs) { mcq in
                NavigationLink {
                    MCQSolutionView(mcq: mcq)
                } label: {
                    Text(mcq.questionStatement)
                }
            }
        }
        // TODO: Fetch mcqs for current exam
    }
    
    struct MCQSolutionView: View {
        var mcq: MCQ
        var body: some View {
            Text(mcq.questionStatement)
            ForEach(mcq.options) { option in
                Button(option.statement) {
                    print("selected mcq:" + option.id.uuidString)
                }
            }
        }
    }
}
#if DEBUG
struct MCQ: Identifiable, Hashable {
    var id: UUID
    var questionStatement: String
    var options: [MCQOption]
    struct MCQOption: Identifiable, Hashable {
        var statement: String
        var id: UUID
    }
}

struct MCQView_Previews: PreviewProvider {
    static var previews: some View {
        MCQView()
    }
}
#endif
