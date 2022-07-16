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
    
    func testClearStorageWithoutCheck() throws {
        let saveDict: SaveDictionary = SaveDictionaryImpl()
        saveDict.clearStorgae()
        XCTAssertTrue(saveDict.isDictionarySaved == false )
    }
    
    func testClearStorageWithoutCheckWrongAddress() throws {
        let fileURL:URL = URL(string: "/Users/syedsaudarif/Desktop/chat.txt")!
        let saveDict: SaveDictionary = SaveDictionaryImpl()
        (saveDict as? SaveDictionaryImpl)?.documentPath = fileURL
        saveDict.clearStorgae()
        XCTAssertTrue(saveDict.isDictionarySaved == true )
    }
    
    
    func testStoreWhichNoPermissionPath() throws {
        let fileURL:URL = URL(string: "/Users/syedsaudarif/Desktop/chat.txt")!
        let saveDict: SaveDictionary = SaveDictionaryImpl()
        (saveDict as? SaveDictionaryImpl)?.documentPath = fileURL
        (saveDict as? SaveDictionaryImpl)?.store(MockData.mockDictData)
        XCTAssertTrue(saveDict.isDictionarySaved == true )
    }
    
    func testLoadWhichNoPermissionPath() throws {
        let fileURL:URL = URL(string: "/Users/syedsaudarif/Desktop/chat.txt")!
        let saveDict: SaveDictionary = SaveDictionaryImpl()
        (saveDict as? SaveDictionaryImpl)?.documentPath = fileURL
        (saveDict as? SaveDictionaryImpl)?.load()
        XCTAssertTrue(saveDict.isDictionarySaved == true )
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
    
    func testSavingWithException() throws {
        let saveDict: SaveDictionaryImpl = SaveDictionaryImpl()
        if saveDict.isDictionarySaved {
            saveDict.clearStorgae()
        }
        saveDict.documentPath = URL(string:"/user/")
        if saveDict.saveDict(MockData.mockDictData) {
            XCTAssertTrue(false)
        } else {
            XCTAssert(true)
        }
    }

}
