//
//  MCQ.swift
//  RemoteProctoring-iPad
//
//  Created by Adnan Ahmed Khan on 15/09/2022.
//

import SwiftUI
import Apollo

struct MCQ: View {
//    let query: GetMcqExamQuery
//    let exam: McqExam
//    init() {
//        query = GetMcqExamQuery(exam: exam.id)
//    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func fetchMCQExam() {
        ApiClient.shared.client.fetch(query: GetMcqExamQuery(exam: "exam.id")) { res in
            switch res {
            case .success(let data):
                if let errors = data.errors {
                    for err in errors {
#if DEBUG
                        if let message = err.message {
                            ApiClient.shared.logger.error("\(message)")
                        }
                        else {
//                            ApiClient.shared.logger.error("Field Error Occurred while executing:  \(query.operationDefinition)")
                        }
                        
#endif
                        return
                    }
                }
            case .failure(let _):
                return
            }
        }
    }
}

#if DEBUG
struct MCQ_Previews: PreviewProvider {
    static var previews: some View {
        MCQ()
    }
}
#endif
