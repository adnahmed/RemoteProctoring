// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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

public final class LogInQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query LogIn($username: String!, $password: String!) {
      logIn(username: $username, password: $password) {
        __typename
        code
        token
        message
        success
        user {
          __typename
          ...UserDetails
        }
      }
    }
    """

  public let operationName: String = "LogIn"

  public let operationIdentifier: String? = "6924731d69286d00c479d181f39c5bc76249182aed83db11f67868d28d2abcc0"

  public var queryDocument: String {
    var document: String = operationDefinition
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
        GraphQLField("logIn", arguments: ["username": GraphQLVariable("username"), "password": GraphQLVariable("password")], type: .nonNull(.object(LogIn.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(logIn: LogIn) {
      self.init(unsafeResultMap: ["__typename": "Query", "logIn": logIn.resultMap])
    }

    public var logIn: LogIn {
      get {
        return LogIn(unsafeResultMap: resultMap["logIn"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "logIn")
      }
    }

    public struct LogIn: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AuthenticationResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .nonNull(.scalar(Int.self))),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
          GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("user", type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: Int, token: String? = nil, message: String, success: Bool, user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "AuthenticationResponse", "code": code, "token": token, "message": message, "success": success, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
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

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
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

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("prefix", type: .scalar(String.self)),
            GraphQLField("given_name", type: .nonNull(.scalar(String.self))),
            GraphQLField("middle_name", type: .scalar(String.self)),
            GraphQLField("last_name", type: .scalar(String.self)),
            GraphQLField("role", type: .nonNull(.scalar(Role.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(`prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role) {
          self.init(unsafeResultMap: ["__typename": "User", "prefix": `prefix`, "given_name": givenName, "middle_name": middleName, "last_name": lastName, "role": role])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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
            return resultMap["given_name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "given_name")
          }
        }

        public var middleName: String? {
          get {
            return resultMap["middle_name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "middle_name")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["last_name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "last_name")
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
    mutation Register($username: String!, $password: String!, $role: String!, $givenName: String!, $email: EmailAddress!) {
      register(
        username: $username
        password: $password
        role: $role
        given_name: $givenName
        email: $email
      ) {
        __typename
        code
        token
        success
        message
        user {
          __typename
          ...UserDetails
        }
      }
    }
    """

  public let operationName: String = "Register"

  public let operationIdentifier: String? = "663f53c9814aef2f6c3fc6ccdca5cb00cbb77de1fa50434c422e5a190b3df70c"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + UserDetails.fragmentDefinition)
    return document
  }

  public var username: String
  public var password: String
  public var role: String
  public var givenName: String
  public var email: String

  public init(username: String, password: String, role: String, givenName: String, email: String) {
    self.username = username
    self.password = password
    self.role = role
    self.givenName = givenName
    self.email = email
  }

  public var variables: GraphQLMap? {
    return ["username": username, "password": password, "role": role, "givenName": givenName, "email": email]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("register", arguments: ["username": GraphQLVariable("username"), "password": GraphQLVariable("password"), "role": GraphQLVariable("role"), "given_name": GraphQLVariable("givenName"), "email": GraphQLVariable("email")], type: .nonNull(.object(Register.selections))),
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
          GraphQLField("code", type: .nonNull(.scalar(Int.self))),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
          GraphQLField("user", type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: Int, token: String? = nil, success: Bool, message: String, user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "AuthenticationResponse", "code": code, "token": token, "success": success, "message": message, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
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

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
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

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
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

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("prefix", type: .scalar(String.self)),
            GraphQLField("given_name", type: .nonNull(.scalar(String.self))),
            GraphQLField("middle_name", type: .scalar(String.self)),
            GraphQLField("last_name", type: .scalar(String.self)),
            GraphQLField("role", type: .nonNull(.scalar(Role.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(`prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role) {
          self.init(unsafeResultMap: ["__typename": "User", "prefix": `prefix`, "given_name": givenName, "middle_name": middleName, "last_name": lastName, "role": role])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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
            return resultMap["given_name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "given_name")
          }
        }

        public var middleName: String? {
          get {
            return resultMap["middle_name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "middle_name")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["last_name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "last_name")
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

public struct UserDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment UserDetails on User {
      __typename
      prefix
      given_name
      middle_name
      last_name
      role
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("prefix", type: .scalar(String.self)),
      GraphQLField("given_name", type: .nonNull(.scalar(String.self))),
      GraphQLField("middle_name", type: .scalar(String.self)),
      GraphQLField("last_name", type: .scalar(String.self)),
      GraphQLField("role", type: .nonNull(.scalar(Role.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(`prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role) {
    self.init(unsafeResultMap: ["__typename": "User", "prefix": `prefix`, "given_name": givenName, "middle_name": middleName, "last_name": lastName, "role": role])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
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
      return resultMap["given_name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "given_name")
    }
  }

  public var middleName: String? {
    get {
      return resultMap["middle_name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "middle_name")
    }
  }

  public var lastName: String? {
    get {
      return resultMap["last_name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "last_name")
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
}
