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
        //First clear the local storage
        try? StoreDictionaryTests().testClearStorage()
        
        func initiallizeDictionary() -> Dictionary {
            let df:DictionaryFetcherMock = DictionaryFetcherMock()
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
    
    let df:DictionaryFetcherMock = DictionaryFetcherMock()

    
    func testFetcherError() throws {
        df.shouldSendURLError = true
        let networkInit = DictionaryInitiallizer_Network(df)
        let exp1 = expectation(description: "Dictionary Initiallization from network Expectation. URL error.")
        networkInit.startInit({ result in
            exp1.fulfill()
            switch(result) {
            case .success(let s):
                //Initiallized by network
                XCTAssertTrue(true, "The result succeded. But it should have failed.")
            case .failure(let e):
                print(e.localizedDescription)
            }
        })
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    
    func testDictionaryFetchErrorButInitiallizedByResource() throws {
        //First clear the local storage
        try? StoreDictionaryTests().testClearStorage()
        
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
        XCTAssertTrue(dic.dict.count != 0)
    }
    
//    func testDictionaryNetworkError() throws {
//        //First clear the local storage
//        try? StoreDictionaryTests().testClearStorage()
//
//        func initiallizeDictionary() -> Dictionary {
//            let df:DictionaryFetcherMock = DictionaryFetcherMock()
//            df.shouldSendNetworkError = true
//            let dic = DictionaryImpl(df)
//            return dic
//        }
//        self.exp = expectation(description: "Dictionary Initiallization testing network Error.")
//        var dic = initiallizeDictionary()
//        dic.setObserver = self
//        waitForExpectations(timeout: 3, handler: nil)
//        XCTAssertTrue(dic.isInitialized)
//        XCTAssertTrue(dic.dict.count == 0)
//    }

}

extension DictionaryTests : DictionaryObserver {
    func isInitiallized() {
        exp?.fulfill()
    }
    
    
}
