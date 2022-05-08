//
//  DictionaryFetcherTests.swift
//  WordleTests
//
//  Created by syed saud arif on 03/05/22.
//

import XCTest
@testable import Wordle

class DictionaryFetcherTests: XCTestCase {

    func testFetch() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "DictionaryFetcherExpectation")
        
        var string = ""
        let df:DictionaryFetcher = DictionaryFetcherMock()
        df.fetch() { result in
            switch(result) {
            case .success(let s) :
                string = s
            case .failure(_) :
                string = ""
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(string.count != 0)
    }

    func testFetchError() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "DictionaryFetcherExpectation")
        
        var error : NetworkError? = nil
        let df:DictionaryFetcherMock = DictionaryFetcherMock()
        df.shouldSendURLError = true
        df.fetch() { result in
            switch(result) {
            case .success(_) : break
            case .failure(let e) :
                error = e
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(error != nil)
    }
    
    func testFetchErrorNetwork() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "DictionaryFetcherExpectation")
        
        var error : NetworkError? = nil
        let df:DictionaryFetcherMock = DictionaryFetcherMock()
        df.shouldSendNetworkError = true
        df.fetch() { result in
            switch(result) {
            case .success(_) : break
            case .failure(let e) :
                error = e
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
        if let e = error, case .requestFailed(_) = e {} else {assertionFailure()}
        
        
    }


}
