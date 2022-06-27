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
      }
    }
    """

  public let operationName: String = "Authentication"

  public let operationIdentifier: String? = "2763246ef4943c9482af2b8978681ada1d8761914ea240bf9558862bddd3f004"

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
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(code: Int, token: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "LoginResponse", "code": code, "token": token])
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
    }
  }
}
