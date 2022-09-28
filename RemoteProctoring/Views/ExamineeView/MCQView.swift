//
//  MCQView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 04/09/2022.
//

import SwiftUI

struct MCQView: View {
    @State var mcqs: [McqExam.Question] = []
    var body: some View {
        ForEach(mcqs, id: \.id) { mcq in
            NavigationLink {
                MCQSolutionView(mcq: mcq)
            } label: {
                Text(mcq.question)
            }
        }
        .onAppear {
            // TODO: Fetch mcqs for current exam
        }
    }
    
    struct MCQSolutionView: View {
        var mcq: McqExam.Question
        var body: some View {
            Text(mcq.question)
            ForEach(mcq.choices, id: \.id) { choice in
                Button(choice.statement) {
                    print("selected mcq:" + choice.id)
                }
            }
        }
    }
}
#if DEBUG

struct MCQView_Previews: PreviewProvider {
    static var previews: some View {
        MCQView()
    }
}
#endif
