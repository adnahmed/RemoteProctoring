//
//  Examinee.swift
//  RemoteProctoring-iPad
//
//  Created by Adnan Ahmed Khan on 15/09/2022.
//

import PDFKit
import SwiftUI
import Apollo

struct Examinee: View {
    let exam: Exam
    private let timer = Timer()
    var body: some View {
        NavigationStack {
            NavigationLink("View PDF Paper") {
                PDF()
            }
            NavigationLink("View MCQ Exam") {
                MCQ()
            }
        }
    }
    
    func fetchMCQExam(exam: Exam) -> McqExam {
        return McqExam(id: "1", questions: [])
    }
    
}

extension McqExam.Question.Choice: Equatable {
    public static func == (lhs: McqExam.Question.Choice, rhs: McqExam.Question.Choice) -> Bool {
        return lhs.id == rhs.id
    }
}

extension McqExam.Question.Choice: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.statement)
    }
}

extension McqExam.Question: Equatable {
    public static func == (lhs: McqExam.Question, rhs: McqExam.Question) -> Bool {
        return lhs.id == rhs.id
    }
}

extension McqExam.Question: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.question)
        hasher.combine(self.choices)
    }
}

extension McqExam: Equatable {
    public static func == (lhs: McqExam, rhs: McqExam) -> Bool {
        return lhs.id == rhs.id
    }
}

extension McqExam: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.questions)
    }
}

#if DEBUG
var preview_Exam = Exam(id: "1", name: "MATH 101", start: "10-10-2022:01:03:04", end: "10-10-2022:01:03:04",
                         subject:
                            Exam.Subject(id: "1", name: "Math", description: "Mathematics is the most fundamental science. It governs all the imaginable and unimaginable universe."))
struct Examinee_Previews: PreviewProvider {
    static var previews: some View {
        Examinee(exam: preview_Exam)
    }
}
#endif
