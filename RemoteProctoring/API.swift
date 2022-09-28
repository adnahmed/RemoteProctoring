// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct UserRegisterationInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - username
  ///   - password
  ///   - role
  ///   - prefix
  ///   - givenName
  ///   - middleName
  ///   - lastName
  ///   - email
  ///   - organization
  public init(username: String, password: String, role: Role, `prefix`: Swift.Optional<String?> = nil, givenName: String, middleName: Swift.Optional<String?> = nil, lastName: Swift.Optional<String?> = nil, email: String, organization: String) {
    graphQLMap = ["username": username, "password": password, "role": role, "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "email": email, "organization": organization]
  }

  public var username: String {
    get {
      return graphQLMap["username"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "username")
    }
  }

  public var password: String {
    get {
      return graphQLMap["password"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }

  public var role: Role {
    get {
      return graphQLMap["role"] as! Role
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "role")
    }
  }

  public var `prefix`: Swift.Optional<String?> {
    get {
      return graphQLMap["prefix"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "prefix")
    }
  }

  public var givenName: String {
    get {
      return graphQLMap["givenName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "givenName")
    }
  }

  public var middleName: Swift.Optional<String?> {
    get {
      return graphQLMap["middleName"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "middleName")
    }
  }

  public var lastName: Swift.Optional<String?> {
    get {
      return graphQLMap["lastName"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var organization: String {
    get {
      return graphQLMap["organization"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "organization")
    }
  }
}

public enum Role: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case administrator
  case proctor
  case examinee
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "administrator": self = .administrator
      case "proctor": self = .proctor
      case "examinee": self = .examinee
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .administrator: return "administrator"
      case .proctor: return "proctor"
      case .examinee: return "examinee"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: Role, rhs: Role) -> Bool {
    switch (lhs, rhs) {
      case (.administrator, .administrator): return true
      case (.proctor, .proctor): return true
      case (.examinee, .examinee): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [Role] {
    return [
      .administrator,
      .proctor,
      .examinee,
    ]
  }
}

public final class GetExamQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetExam {
      getExam {
        __typename
        ...Exam
      }
    }
    """

  public let operationName: String = "GetExam"

  public let operationIdentifier: String? = "00e37d786337986755985c32bd807cf4ebe5457410d38de25fd3976cb667d6d9"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + Exam.fragmentDefinition)
    document.append("\n" + Subject.fragmentDefinition)
    return document
  }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getExam", type: .nonNull(.object(GetExam.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getExam: GetExam) {
      self.init(unsafeResultMap: ["__typename": "Query", "getExam": getExam.resultMap])
    }

    public var getExam: GetExam {
      get {
        return GetExam(unsafeResultMap: resultMap["getExam"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "getExam")
      }
    }

    public struct GetExam: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Exam"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("start", type: .nonNull(.scalar(String.self))),
          GraphQLField("end", type: .nonNull(.scalar(String.self))),
          GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, name: String, start: String, end: String, subject: Subject) {
        self.init(unsafeResultMap: ["__typename": "Exam", "id": id, "name": name, "start": start, "end": end, "subject": subject.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var start: String {
        get {
          return resultMap["start"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "start")
        }
      }

      public var end: String {
        get {
          return resultMap["end"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "end")
        }
      }

      public var subject: Subject {
        get {
          return Subject(unsafeResultMap: resultMap["subject"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "subject")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var exam: Exam {
          get {
            return Exam(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct Subject: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Subject"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
            GraphQLField("pictures", type: .list(.nonNull(.object(Picture.selections)))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String, description: String, pictures: [Picture]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Subject", "id": id, "name": name, "description": description, "pictures": pictures.flatMap { (value: [Picture]) -> [ResultMap] in value.map { (value: Picture) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var pictures: [Picture]? {
          get {
            return (resultMap["pictures"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Picture] in value.map { (value: ResultMap) -> Picture in Picture(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Picture]) -> [ResultMap] in value.map { (value: Picture) -> ResultMap in value.resultMap } }, forKey: "pictures")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var subject: Subject {
            get {
              return Subject(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Picture: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["SubjectPictures"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("downloadURL", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(downloadUrl: String) {
            self.init(unsafeResultMap: ["__typename": "SubjectPictures", "downloadURL": downloadUrl])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var downloadUrl: String {
            get {
              return resultMap["downloadURL"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "downloadURL")
            }
          }
        }
      }
    }
  }
}

public final class GetMcqExamQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetMCQExam($exam: UUID!) {
      getMCQExam(exam: $exam) {
        __typename
        queryResponse {
          __typename
          ...QueryResponse
        }
        mcqExam {
          __typename
          ...MCQExam
        }
      }
    }
    """

  public let operationName: String = "GetMCQExam"

  public let operationIdentifier: String? = "a1cc478be54d7abef9ff93b3251e74e0c35f706805be1dc15971ac5f1ae806ee"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + QueryResponse.fragmentDefinition)
    document.append("\n" + McqExam.fragmentDefinition)
    document.append("\n" + McQuestion.fragmentDefinition)
    document.append("\n" + McqChoice.fragmentDefinition)
    return document
  }

  public var exam: String

  public init(exam: String) {
    self.exam = exam
  }

  public var variables: GraphQLMap? {
    return ["exam": exam]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getMCQExam", arguments: ["exam": GraphQLVariable("exam")], type: .nonNull(.object(GetMcqExam.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMcqExam: GetMcqExam) {
      self.init(unsafeResultMap: ["__typename": "Query", "getMCQExam": getMcqExam.resultMap])
    }

    public var getMcqExam: GetMcqExam {
      get {
        return GetMcqExam(unsafeResultMap: resultMap["getMCQExam"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "getMCQExam")
      }
    }

    public struct GetMcqExam: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["MCQExamResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("queryResponse", type: .nonNull(.object(QueryResponse.selections))),
          GraphQLField("mcqExam", type: .object(McqExam.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(queryResponse: QueryResponse, mcqExam: McqExam? = nil) {
        self.init(unsafeResultMap: ["__typename": "MCQExamResponse", "queryResponse": queryResponse.resultMap, "mcqExam": mcqExam.flatMap { (value: McqExam) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var queryResponse: QueryResponse {
        get {
          return QueryResponse(unsafeResultMap: resultMap["queryResponse"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "queryResponse")
        }
      }

      public var mcqExam: McqExam? {
        get {
          return (resultMap["mcqExam"] as? ResultMap).flatMap { McqExam(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "mcqExam")
        }
      }

      public struct QueryResponse: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["QueryResponse"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("code", type: .nonNull(.scalar(Int.self))),
            GraphQLField("message", type: .nonNull(.scalar(String.self))),
            GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(code: Int, message: String, success: Bool) {
          self.init(unsafeResultMap: ["__typename": "QueryResponse", "code": code, "message": message, "success": success])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var code: Int {
          get {
            return resultMap["code"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }

        public var success: Bool {
          get {
            return resultMap["success"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "success")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var queryResponse: QueryResponse {
            get {
              return QueryResponse(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

      public struct McqExam: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["MCQExam"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("questions", type: .nonNull(.list(.nonNull(.object(Question.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, questions: [Question]) {
          self.init(unsafeResultMap: ["__typename": "MCQExam", "id": id, "questions": questions.map { (value: Question) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var questions: [Question] {
          get {
            return (resultMap["questions"] as! [ResultMap]).map { (value: ResultMap) -> Question in Question(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Question) -> ResultMap in value.resultMap }, forKey: "questions")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var mcqExam: McqExam {
            get {
              return McqExam(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Question: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["MCQuestion"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(String.self))),
              GraphQLField("question", type: .nonNull(.scalar(String.self))),
              GraphQLField("choices", type: .nonNull(.list(.nonNull(.object(Choice.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, question: String, choices: [Choice]) {
            self.init(unsafeResultMap: ["__typename": "MCQuestion", "id": id, "question": question, "choices": choices.map { (value: Choice) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var question: String {
            get {
              return resultMap["question"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "question")
            }
          }

          public var choices: [Choice] {
            get {
              return (resultMap["choices"] as! [ResultMap]).map { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Choice) -> ResultMap in value.resultMap }, forKey: "choices")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var mcQuestion: McQuestion {
              get {
                return McQuestion(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }

          public struct Choice: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["MCQChoice"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(String.self))),
                GraphQLField("statement", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: String, statement: String) {
              self.init(unsafeResultMap: ["__typename": "MCQChoice", "id": id, "statement": statement])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: String {
              get {
                return resultMap["id"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var statement: String {
              get {
                return resultMap["statement"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "statement")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var mcqChoice: McqChoice {
                get {
                  return McqChoice(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class LogInEmailQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query LogInEmail($email: EmailAddress!, $password: String!) {
      logInEmail(email: $email, password: $password) {
        __typename
        ...LoginResponse
      }
    }
    """

  public let operationName: String = "LogInEmail"

  public let operationIdentifier: String? = "cb4ea5b762c0f7ddd6965431bef04e9b6dd0bddf46ffcf045392f302e439bcf2"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + LoginResponse.fragmentDefinition)
    document.append("\n" + QueryResponse.fragmentDefinition)
    document.append("\n" + UserDetails.fragmentDefinition)
    return document
  }

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("logInEmail", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .nonNull(.object(LogInEmail.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(logInEmail: LogInEmail) {
      self.init(unsafeResultMap: ["__typename": "Query", "logInEmail": logInEmail.resultMap])
    }

    public var logInEmail: LogInEmail {
      get {
        return LogInEmail(unsafeResultMap: resultMap["logInEmail"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "logInEmail")
      }
    }

    public struct LogInEmail: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AuthenticationResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("queryResponse", type: .object(QueryResponse.selections)),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("user", type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(queryResponse: QueryResponse? = nil, token: String? = nil, user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "AuthenticationResponse", "queryResponse": queryResponse.flatMap { (value: QueryResponse) -> ResultMap in value.resultMap }, "token": token, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var queryResponse: QueryResponse? {
        get {
          return (resultMap["queryResponse"] as? ResultMap).flatMap { QueryResponse(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "queryResponse")
        }
      }

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var loginResponse: LoginResponse {
          get {
            return LoginResponse(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct QueryResponse: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["QueryResponse"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("code", type: .nonNull(.scalar(Int.self))),
            GraphQLField("message", type: .nonNull(.scalar(String.self))),
            GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(code: Int, message: String, success: Bool) {
          self.init(unsafeResultMap: ["__typename": "QueryResponse", "code": code, "message": message, "success": success])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var code: Int {
          get {
            return resultMap["code"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }

        public var success: Bool {
          get {
            return resultMap["success"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "success")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var queryResponse: QueryResponse {
            get {
              return QueryResponse(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("username", type: .nonNull(.scalar(String.self))),
            GraphQLField("prefix", type: .scalar(String.self)),
            GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
            GraphQLField("middleName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("role", type: .nonNull(.scalar(Role.self))),
            GraphQLField("pictures", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, username: String, `prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role, pictures: [String]) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username, "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role, "pictures": pictures])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var username: String {
          get {
            return resultMap["username"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "username")
          }
        }

        public var `prefix`: String? {
          get {
            return resultMap["prefix"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "prefix")
          }
        }

        public var givenName: String {
          get {
            return resultMap["givenName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "givenName")
          }
        }

        public var middleName: String? {
          get {
            return resultMap["middleName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "middleName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var role: Role {
          get {
            return resultMap["role"]! as! Role
          }
          set {
            resultMap.updateValue(newValue, forKey: "role")
          }
        }

        public var pictures: [String] {
          get {
            return resultMap["pictures"]! as! [String]
          }
          set {
            resultMap.updateValue(newValue, forKey: "pictures")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var userDetails: UserDetails {
            get {
              return UserDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class LogInUsernameQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query LogInUsername($username: String!, $password: String!) {
      logInUsername(username: $username, password: $password) {
        __typename
        ...LoginResponse
      }
    }
    """

  public let operationName: String = "LogInUsername"

  public let operationIdentifier: String? = "767f839511879f4afef9bcdd05181a310e044236134274e9577b68f26f21a23f"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + LoginResponse.fragmentDefinition)
    document.append("\n" + QueryResponse.fragmentDefinition)
    document.append("\n" + UserDetails.fragmentDefinition)
    return document
  }

  public var username: String
  public var password: String

  public init(username: String, password: String) {
    self.username = username
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["username": username, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("logInUsername", arguments: ["username": GraphQLVariable("username"), "password": GraphQLVariable("password")], type: .nonNull(.object(LogInUsername.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(logInUsername: LogInUsername) {
      self.init(unsafeResultMap: ["__typename": "Query", "logInUsername": logInUsername.resultMap])
    }

    public var logInUsername: LogInUsername {
      get {
        return LogInUsername(unsafeResultMap: resultMap["logInUsername"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "logInUsername")
      }
    }

    public struct LogInUsername: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AuthenticationResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("queryResponse", type: .object(QueryResponse.selections)),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("user", type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(queryResponse: QueryResponse? = nil, token: String? = nil, user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "AuthenticationResponse", "queryResponse": queryResponse.flatMap { (value: QueryResponse) -> ResultMap in value.resultMap }, "token": token, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var queryResponse: QueryResponse? {
        get {
          return (resultMap["queryResponse"] as? ResultMap).flatMap { QueryResponse(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "queryResponse")
        }
      }

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var loginResponse: LoginResponse {
          get {
            return LoginResponse(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct QueryResponse: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["QueryResponse"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("code", type: .nonNull(.scalar(Int.self))),
            GraphQLField("message", type: .nonNull(.scalar(String.self))),
            GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(code: Int, message: String, success: Bool) {
          self.init(unsafeResultMap: ["__typename": "QueryResponse", "code": code, "message": message, "success": success])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var code: Int {
          get {
            return resultMap["code"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }

        public var success: Bool {
          get {
            return resultMap["success"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "success")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var queryResponse: QueryResponse {
            get {
              return QueryResponse(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("username", type: .nonNull(.scalar(String.self))),
            GraphQLField("prefix", type: .scalar(String.self)),
            GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
            GraphQLField("middleName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("role", type: .nonNull(.scalar(Role.self))),
            GraphQLField("pictures", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, username: String, `prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role, pictures: [String]) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username, "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role, "pictures": pictures])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var username: String {
          get {
            return resultMap["username"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "username")
          }
        }

        public var `prefix`: String? {
          get {
            return resultMap["prefix"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "prefix")
          }
        }

        public var givenName: String {
          get {
            return resultMap["givenName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "givenName")
          }
        }

        public var middleName: String? {
          get {
            return resultMap["middleName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "middleName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var role: Role {
          get {
            return resultMap["role"]! as! Role
          }
          set {
            resultMap.updateValue(newValue, forKey: "role")
          }
        }

        public var pictures: [String] {
          get {
            return resultMap["pictures"]! as! [String]
          }
          set {
            resultMap.updateValue(newValue, forKey: "pictures")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var userDetails: UserDetails {
            get {
              return UserDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class RegisterMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Register($user: UserRegisterationInput!) {
      register(user: $user) {
        __typename
        queryResponse {
          __typename
          ...QueryResponse
        }
        token
        user {
          __typename
          ...UserDetails
        }
      }
    }
    """

  public let operationName: String = "Register"

  public let operationIdentifier: String? = "8a9737291ef6521ee7c9da87d8d59d6d50f84762e53cb9efd2e51bfadb53d7fc"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + QueryResponse.fragmentDefinition)
    document.append("\n" + UserDetails.fragmentDefinition)
    return document
  }

  public var user: UserRegisterationInput

  public init(user: UserRegisterationInput) {
    self.user = user
  }

  public var variables: GraphQLMap? {
    return ["user": user]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("register", arguments: ["user": GraphQLVariable("user")], type: .nonNull(.object(Register.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(register: Register) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "register": register.resultMap])
    }

    public var register: Register {
      get {
        return Register(unsafeResultMap: resultMap["register"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "register")
      }
    }

    public struct Register: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AuthenticationResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("queryResponse", type: .object(QueryResponse.selections)),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("user", type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(queryResponse: QueryResponse? = nil, token: String? = nil, user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "AuthenticationResponse", "queryResponse": queryResponse.flatMap { (value: QueryResponse) -> ResultMap in value.resultMap }, "token": token, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var queryResponse: QueryResponse? {
        get {
          return (resultMap["queryResponse"] as? ResultMap).flatMap { QueryResponse(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "queryResponse")
        }
      }

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public struct QueryResponse: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["QueryResponse"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("code", type: .nonNull(.scalar(Int.self))),
            GraphQLField("message", type: .nonNull(.scalar(String.self))),
            GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(code: Int, message: String, success: Bool) {
          self.init(unsafeResultMap: ["__typename": "QueryResponse", "code": code, "message": message, "success": success])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var code: Int {
          get {
            return resultMap["code"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }

        public var success: Bool {
          get {
            return resultMap["success"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "success")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var queryResponse: QueryResponse {
            get {
              return QueryResponse(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("username", type: .nonNull(.scalar(String.self))),
            GraphQLField("prefix", type: .scalar(String.self)),
            GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
            GraphQLField("middleName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("role", type: .nonNull(.scalar(Role.self))),
            GraphQLField("pictures", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, username: String, `prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role, pictures: [String]) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username, "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role, "pictures": pictures])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var username: String {
          get {
            return resultMap["username"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "username")
          }
        }

        public var `prefix`: String? {
          get {
            return resultMap["prefix"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "prefix")
          }
        }

        public var givenName: String {
          get {
            return resultMap["givenName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "givenName")
          }
        }

        public var middleName: String? {
          get {
            return resultMap["middleName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "middleName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var role: Role {
          get {
            return resultMap["role"]! as! Role
          }
          set {
            resultMap.updateValue(newValue, forKey: "role")
          }
        }

        public var pictures: [String] {
          get {
            return resultMap["pictures"]! as! [String]
          }
          set {
            resultMap.updateValue(newValue, forKey: "pictures")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var userDetails: UserDetails {
            get {
              return UserDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public struct Exam: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment Exam on Exam {
      __typename
      id
      name
      start
      end
      subject {
        __typename
        ...Subject
      }
    }
    """

  public static let possibleTypes: [String] = ["Exam"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("start", type: .nonNull(.scalar(String.self))),
      GraphQLField("end", type: .nonNull(.scalar(String.self))),
      GraphQLField("subject", type: .nonNull(.object(Subject.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, name: String, start: String, end: String, subject: Subject) {
    self.init(unsafeResultMap: ["__typename": "Exam", "id": id, "name": name, "start": start, "end": end, "subject": subject.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var start: String {
    get {
      return resultMap["start"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "start")
    }
  }

  public var end: String {
    get {
      return resultMap["end"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "end")
    }
  }

  public var subject: Subject {
    get {
      return Subject(unsafeResultMap: resultMap["subject"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "subject")
    }
  }

  public struct Subject: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Subject"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("pictures", type: .list(.nonNull(.object(Picture.selections)))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, name: String, description: String, pictures: [Picture]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Subject", "id": id, "name": name, "description": description, "pictures": pictures.flatMap { (value: [Picture]) -> [ResultMap] in value.map { (value: Picture) -> ResultMap in value.resultMap } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }

    public var description: String {
      get {
        return resultMap["description"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "description")
      }
    }

    public var pictures: [Picture]? {
      get {
        return (resultMap["pictures"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Picture] in value.map { (value: ResultMap) -> Picture in Picture(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Picture]) -> [ResultMap] in value.map { (value: Picture) -> ResultMap in value.resultMap } }, forKey: "pictures")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var subject: Subject {
        get {
          return Subject(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }

    public struct Picture: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SubjectPictures"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("downloadURL", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(downloadUrl: String) {
        self.init(unsafeResultMap: ["__typename": "SubjectPictures", "downloadURL": downloadUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var downloadUrl: String {
        get {
          return resultMap["downloadURL"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "downloadURL")
        }
      }
    }
  }
}

public struct LoginResponse: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment LoginResponse on AuthenticationResponse {
      __typename
      queryResponse {
        __typename
        ...QueryResponse
      }
      token
      user {
        __typename
        ...UserDetails
      }
    }
    """

  public static let possibleTypes: [String] = ["AuthenticationResponse"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("queryResponse", type: .object(QueryResponse.selections)),
      GraphQLField("token", type: .scalar(String.self)),
      GraphQLField("user", type: .object(User.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(queryResponse: QueryResponse? = nil, token: String? = nil, user: User? = nil) {
    self.init(unsafeResultMap: ["__typename": "AuthenticationResponse", "queryResponse": queryResponse.flatMap { (value: QueryResponse) -> ResultMap in value.resultMap }, "token": token, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var queryResponse: QueryResponse? {
    get {
      return (resultMap["queryResponse"] as? ResultMap).flatMap { QueryResponse(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "queryResponse")
    }
  }

  public var token: String? {
    get {
      return resultMap["token"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "token")
    }
  }

  public var user: User? {
    get {
      return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "user")
    }
  }

  public struct QueryResponse: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["QueryResponse"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("code", type: .nonNull(.scalar(Int.self))),
        GraphQLField("message", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(code: Int, message: String, success: Bool) {
      self.init(unsafeResultMap: ["__typename": "QueryResponse", "code": code, "message": message, "success": success])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var code: Int {
      get {
        return resultMap["code"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "code")
      }
    }

    public var message: String {
      get {
        return resultMap["message"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "message")
      }
    }

    public var success: Bool {
      get {
        return resultMap["success"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "success")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var queryResponse: QueryResponse {
        get {
          return QueryResponse(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }

  public struct User: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
        GraphQLField("prefix", type: .scalar(String.self)),
        GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
        GraphQLField("middleName", type: .scalar(String.self)),
        GraphQLField("lastName", type: .scalar(String.self)),
        GraphQLField("role", type: .nonNull(.scalar(Role.self))),
        GraphQLField("pictures", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, username: String, `prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role, pictures: [String]) {
      self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username, "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role, "pictures": pictures])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var username: String {
      get {
        return resultMap["username"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "username")
      }
    }

    public var `prefix`: String? {
      get {
        return resultMap["prefix"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "prefix")
      }
    }

    public var givenName: String {
      get {
        return resultMap["givenName"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "givenName")
      }
    }

    public var middleName: String? {
      get {
        return resultMap["middleName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "middleName")
      }
    }

    public var lastName: String? {
      get {
        return resultMap["lastName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "lastName")
      }
    }

    public var role: Role {
      get {
        return resultMap["role"]! as! Role
      }
      set {
        resultMap.updateValue(newValue, forKey: "role")
      }
    }

    public var pictures: [String] {
      get {
        return resultMap["pictures"]! as! [String]
      }
      set {
        resultMap.updateValue(newValue, forKey: "pictures")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var userDetails: UserDetails {
        get {
          return UserDetails(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct McqExam: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment MCQExam on MCQExam {
      __typename
      id
      questions {
        __typename
        ...MCQuestion
      }
    }
    """

  public static let possibleTypes: [String] = ["MCQExam"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("questions", type: .nonNull(.list(.nonNull(.object(Question.selections))))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, questions: [Question]) {
    self.init(unsafeResultMap: ["__typename": "MCQExam", "id": id, "questions": questions.map { (value: Question) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var questions: [Question] {
    get {
      return (resultMap["questions"] as! [ResultMap]).map { (value: ResultMap) -> Question in Question(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: Question) -> ResultMap in value.resultMap }, forKey: "questions")
    }
  }

  public struct Question: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["MCQuestion"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("question", type: .nonNull(.scalar(String.self))),
        GraphQLField("choices", type: .nonNull(.list(.nonNull(.object(Choice.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, question: String, choices: [Choice]) {
      self.init(unsafeResultMap: ["__typename": "MCQuestion", "id": id, "question": question, "choices": choices.map { (value: Choice) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var question: String {
      get {
        return resultMap["question"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "question")
      }
    }

    public var choices: [Choice] {
      get {
        return (resultMap["choices"] as! [ResultMap]).map { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Choice) -> ResultMap in value.resultMap }, forKey: "choices")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var mcQuestion: McQuestion {
        get {
          return McQuestion(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }

    public struct Choice: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["MCQChoice"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("statement", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, statement: String) {
        self.init(unsafeResultMap: ["__typename": "MCQChoice", "id": id, "statement": statement])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var statement: String {
        get {
          return resultMap["statement"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "statement")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var mcqChoice: McqChoice {
          get {
            return McqChoice(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct McqChoice: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment MCQChoice on MCQChoice {
      __typename
      id
      statement
    }
    """

  public static let possibleTypes: [String] = ["MCQChoice"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("statement", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, statement: String) {
    self.init(unsafeResultMap: ["__typename": "MCQChoice", "id": id, "statement": statement])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var statement: String {
    get {
      return resultMap["statement"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "statement")
    }
  }
}

public struct McQuestion: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment MCQuestion on MCQuestion {
      __typename
      id
      question
      choices {
        __typename
        ...MCQChoice
      }
    }
    """

  public static let possibleTypes: [String] = ["MCQuestion"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("question", type: .nonNull(.scalar(String.self))),
      GraphQLField("choices", type: .nonNull(.list(.nonNull(.object(Choice.selections))))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, question: String, choices: [Choice]) {
    self.init(unsafeResultMap: ["__typename": "MCQuestion", "id": id, "question": question, "choices": choices.map { (value: Choice) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var question: String {
    get {
      return resultMap["question"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "question")
    }
  }

  public var choices: [Choice] {
    get {
      return (resultMap["choices"] as! [ResultMap]).map { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) }
    }
    set {
      resultMap.updateValue(newValue.map { (value: Choice) -> ResultMap in value.resultMap }, forKey: "choices")
    }
  }

  public struct Choice: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["MCQChoice"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("statement", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: String, statement: String) {
      self.init(unsafeResultMap: ["__typename": "MCQChoice", "id": id, "statement": statement])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: String {
      get {
        return resultMap["id"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var statement: String {
      get {
        return resultMap["statement"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "statement")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var mcqChoice: McqChoice {
        get {
          return McqChoice(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct QueryResponse: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment QueryResponse on QueryResponse {
      __typename
      code
      message
      success
    }
    """

  public static let possibleTypes: [String] = ["QueryResponse"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("code", type: .nonNull(.scalar(Int.self))),
      GraphQLField("message", type: .nonNull(.scalar(String.self))),
      GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(code: Int, message: String, success: Bool) {
    self.init(unsafeResultMap: ["__typename": "QueryResponse", "code": code, "message": message, "success": success])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var code: Int {
    get {
      return resultMap["code"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "code")
    }
  }

  public var message: String {
    get {
      return resultMap["message"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "message")
    }
  }

  public var success: Bool {
    get {
      return resultMap["success"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "success")
    }
  }
}

public struct Subject: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment Subject on Subject {
      __typename
      id
      name
      description
      pictures {
        __typename
        downloadURL
      }
    }
    """

  public static let possibleTypes: [String] = ["Subject"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("description", type: .nonNull(.scalar(String.self))),
      GraphQLField("pictures", type: .list(.nonNull(.object(Picture.selections)))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, name: String, description: String, pictures: [Picture]? = nil) {
    self.init(unsafeResultMap: ["__typename": "Subject", "id": id, "name": name, "description": description, "pictures": pictures.flatMap { (value: [Picture]) -> [ResultMap] in value.map { (value: Picture) -> ResultMap in value.resultMap } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var description: String {
    get {
      return resultMap["description"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  public var pictures: [Picture]? {
    get {
      return (resultMap["pictures"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Picture] in value.map { (value: ResultMap) -> Picture in Picture(unsafeResultMap: value) } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Picture]) -> [ResultMap] in value.map { (value: Picture) -> ResultMap in value.resultMap } }, forKey: "pictures")
    }
  }

  public struct Picture: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["SubjectPictures"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("downloadURL", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(downloadUrl: String) {
      self.init(unsafeResultMap: ["__typename": "SubjectPictures", "downloadURL": downloadUrl])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var downloadUrl: String {
      get {
        return resultMap["downloadURL"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "downloadURL")
      }
    }
  }
}

public struct UserDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment UserDetails on User {
      __typename
      id
      username
      prefix
      givenName
      middleName
      lastName
      role
      pictures
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("username", type: .nonNull(.scalar(String.self))),
      GraphQLField("prefix", type: .scalar(String.self)),
      GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
      GraphQLField("middleName", type: .scalar(String.self)),
      GraphQLField("lastName", type: .scalar(String.self)),
      GraphQLField("role", type: .nonNull(.scalar(Role.self))),
      GraphQLField("pictures", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: String, username: String, `prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role, pictures: [String]) {
    self.init(unsafeResultMap: ["__typename": "User", "id": id, "username": username, "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role, "pictures": pictures])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return resultMap["id"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var username: String {
    get {
      return resultMap["username"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "username")
    }
  }

  public var `prefix`: String? {
    get {
      return resultMap["prefix"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "prefix")
    }
  }

  public var givenName: String {
    get {
      return resultMap["givenName"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "givenName")
    }
  }

  public var middleName: String? {
    get {
      return resultMap["middleName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "middleName")
    }
  }

  public var lastName: String? {
    get {
      return resultMap["lastName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var role: Role {
    get {
      return resultMap["role"]! as! Role
    }
    set {
      resultMap.updateValue(newValue, forKey: "role")
    }
  }

  public var pictures: [String] {
    get {
      return resultMap["pictures"]! as! [String]
    }
    set {
      resultMap.updateValue(newValue, forKey: "pictures")
    }
  }
}
