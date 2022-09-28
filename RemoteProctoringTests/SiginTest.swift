//
//  SiginTest.swift
//  RemoteProctoringTests
//
//  Created by Adnan Ahmed Khan on 18/09/2022.
//

import XCTest
import Apollo

final class SiginTest: XCTestCase {
    override func setUpWithError() throws {
        // Register a user with test username and password.
        let administratorRegisterationInput: UserRegisterationInput = UserRegisterationInput(username: "administrator", password: "password", role: .administrator, givenName: "admin", email: "administrator@", organization: "organization")
        ApiClient.shared.client.perform(mutation: RegisterMutation(user: administratorRegisterationInput))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func UsernamePasswordAuthentication() throws {
        Network.shared.client.fetch(query: query) { res in
            // test res is success
            switch res {
            case .success(let gqRes):
                if let errors = gqRes.errors {
                    // test no errors in response
                }
                if let data = gqRes.data {
                    switch data {
                        /* test returned data with default values */
                    case let data as LogInEmailQuery.Data:
                    case let data as LogInUsernameQuery.Data:
                        /**/
                    default:
                        // test never reach default
                    }
                }
            case .failure(let error):
               // test error is nil
            }
        }

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
