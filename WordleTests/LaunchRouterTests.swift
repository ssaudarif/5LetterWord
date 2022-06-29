//
//  LaunchRouterTests.swift
//  WordleTests
//
//  Created by syed saud arif on 03/05/22.
//

import XCTest
@testable import Wordle

class LaunchRouterTests: XCTestCase {

    var lr:LaunchRouterImpl? = nil
    var exp:XCTestExpectation? = nil
    
    func testCreateNewWordle() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        self.exp = expectation(description: "Testing Create New Wordle")
        self.lr = LaunchRouterImpl()
        self.lr?.createNewWordle(with: self)
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertTrue( self.lr?.d?.dict.contains("hello") ?? false )
    }

    

}

extension LaunchRouterTests : DictionaryObserver {
    func isInitiallized() {
        self.exp?.fulfill()
    }
}
