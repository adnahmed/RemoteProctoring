// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AuthenticationQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Authentication($username: String!, $password: String!, $role: String!) {
      loginUser(username: $username, password: $password, role: $role) {
        __typename
        code
        token
        message
      }
    }
    """

  public let operationName: String = "Authentication"

  public let operationIdentifier: String? = "4f3f95344dba0420a2793c4cc55652d87a0c7281f00cb0bab19a60a2c7dd3099"

  public var username: String
  public var password: String
  public var role: String

  public init(username: String, password: String, role: String) {
    self.username = username
    self.password = password
    self.role = role
  }

  public var variables: GraphQLMap? {
    return ["username": username, "password": password, "role": role]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("loginUser", arguments: ["username": GraphQLVariable("username"), "password": GraphQLVariable("password"), "role": GraphQLVariable("role")], type: .nonNull(.object(LoginUser.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(loginUser: LoginUser) {
      self.init(unsafeResultMap: ["__typename": "Query", "loginUser": loginUser.resultMap])
    }

    public var loginUser: LoginUser {
      get {
        return LoginUser(unsafeResultMap: resultMap["loginUser"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "loginUser")
      }
    }

    public struct LoginUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["LoginResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .nonNull(.scalar(Int.self))),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: Int, token: String? = nil, message: String) {
        self.init(unsafeResultMap: ["__typename": "LoginResponse", "code": code, "token": token, "message": message])
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
    }
  }
}
