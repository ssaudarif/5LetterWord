//
//  DictionaryTests.swift
//  WordleTests
//
//  Created by syed saud arif on 04/05/22.
//

import XCTest
@testable import Wordle

class DictionaryTests: XCTestCase {

    var exp : XCTestExpectation? = nil
    
    func testDictionaryFetching() throws {
        func initiallizeDictionary() -> Dictionary {
            let df:DictionaryFetcher = DictionaryFetcherMock()
            let dic = DictionaryImpl(df)
            return dic
        }
        self.exp = expectation(description: "Dictionary Initiallization from network Expectation.")
        var dic = initiallizeDictionary()
        dic.setObserver = self
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(dic.isInitialized)
        XCTAssertTrue(dic.dict.count > 0)
    }
    
    func testDictionaryFetchError() throws {
        func initiallizeDictionary() -> Dictionary {
            let df:DictionaryFetcherMock = DictionaryFetcherMock()
            df.shouldSendURLError = true
            let dic = DictionaryImpl(df)
            return dic
        }
        self.exp = expectation(description: "Dictionary Initiallization from url Error.")
        var dic = initiallizeDictionary()
        dic.setObserver = self
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(dic.isInitialized)
        XCTAssertTrue(dic.dict.count == 0)
    }
    
    func testDictionaryNetworkError() throws {
        func initiallizeDictionary() -> Dictionary {
            let df:DictionaryFetcherMock = DictionaryFetcherMock()
            df.shouldSendNetworkError = true
            let dic = DictionaryImpl(df)
            return dic
        }
        self.exp = expectation(description: "Dictionary Initiallization testing network Error.")
        var dic = initiallizeDictionary()
        dic.setObserver = self
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(dic.isInitialized)
        XCTAssertTrue(dic.dict.count == 0)
    }

}

extension DictionaryTests : DictionaryObserver {
    func isInitiallized() {
        exp?.fulfill()
    }
    
    
}
