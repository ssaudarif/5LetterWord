//
//  StoreDictionaryTests.swift
//  WordleTests
//
//  Created by syed saud arif on 07/05/22.
//

import XCTest
@testable import Wordle

class StoreDictionaryTests: XCTestCase {
    func testClearStorage() throws {
        let saveDict: SaveDictionary = SaveDictionaryImpl()
        if saveDict.isDictionarySaved {
            saveDict.clearStorgae()
        }
        XCTAssertTrue(saveDict.isDictionarySaved == false )
    }
    
    func testSaving() throws {
        let saveDict: SaveDictionary = SaveDictionaryImpl()
        if saveDict.isDictionarySaved {
            saveDict.clearStorgae()
        }
        if saveDict.saveDict(MockData.mockDictData) {
            XCTAssertTrue(saveDict.isDictionarySaved)
        } else {
            XCTAssert(false)
        }
    }
    
    func testSavingAndReading() throws {
        let saveDict: SaveDictionary = SaveDictionaryImpl()
        if saveDict.isDictionarySaved {
            saveDict.clearStorgae()
        }
        if saveDict.saveDict(MockData.mockDictData) {
            XCTAssertTrue(saveDict.isDictionarySaved)
            let s = saveDict.loadDict()
            XCTAssertTrue(s == MockData.mockDictData)
        } else {
            XCTAssert(false)
        }
    }

}
