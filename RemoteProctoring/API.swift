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
  public init(username: String, password: String, role: String, `prefix`: Swift.Optional<String?> = nil, givenName: String, middleName: Swift.Optional<String?> = nil, lastName: Swift.Optional<String?> = nil, email: String, organization: String) {
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

  public var role: String {
    get {
      return graphQLMap["role"] as! String
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

  public let operationIdentifier: String? = "5d9e56e6aff3ea0d1329d0eb61bc82bc40366556b80bc9f3c54706c900d4d79b"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + LoginResponse.fragmentDefinition)
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

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("prefix", type: .scalar(String.self)),
            GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
            GraphQLField("middleName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("role", type: .nonNull(.scalar(Role.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(`prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role) {
          self.init(unsafeResultMap: ["__typename": "User", "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role])
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

  public let operationIdentifier: String? = "080c43d62a934d3ac4cda73e5313fbc563dfde00f0d4b6f0f0cc3a41220ba4cf"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + LoginResponse.fragmentDefinition)
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

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("prefix", type: .scalar(String.self)),
            GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
            GraphQLField("middleName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("role", type: .nonNull(.scalar(Role.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(`prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role) {
          self.init(unsafeResultMap: ["__typename": "User", "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role])
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

  public let operationName: String = "Register"

  public let operationIdentifier: String? = "bd89ae9b98e2f7a86645290c8aab54bfbc2b50e86d615e8f46daded8aa3cbfcf"

  public var queryDocument: String {
    var document: String = operationDefinition
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
            GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
            GraphQLField("middleName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("role", type: .nonNull(.scalar(Role.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(`prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role) {
          self.init(unsafeResultMap: ["__typename": "User", "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role])
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

public struct LoginResponse: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment LoginResponse on AuthenticationResponse {
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
    """

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
        GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
        GraphQLField("middleName", type: .scalar(String.self)),
        GraphQLField("lastName", type: .scalar(String.self)),
        GraphQLField("role", type: .nonNull(.scalar(Role.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(`prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role) {
      self.init(unsafeResultMap: ["__typename": "User", "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role])
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

public struct UserDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment UserDetails on User {
      __typename
      prefix
      givenName
      middleName
      lastName
      role
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("prefix", type: .scalar(String.self)),
      GraphQLField("givenName", type: .nonNull(.scalar(String.self))),
      GraphQLField("middleName", type: .scalar(String.self)),
      GraphQLField("lastName", type: .scalar(String.self)),
      GraphQLField("role", type: .nonNull(.scalar(Role.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(`prefix`: String? = nil, givenName: String, middleName: String? = nil, lastName: String? = nil, role: Role) {
    self.init(unsafeResultMap: ["__typename": "User", "prefix": `prefix`, "givenName": givenName, "middleName": middleName, "lastName": lastName, "role": role])
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
}
