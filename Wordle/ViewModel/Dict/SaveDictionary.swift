//
//  SaveDictionary.swift
//  Wordle
//
//  Created by syed saud arif on 07/05/22.
//

import Foundation

protocol SaveDictionary {
    //send it dict with \n as seperator
    func saveDict(_ dict:String) -> Bool
    //get dict with \n as seperator
    func loadDict() -> String?
    
    var isDictionarySaved:Bool {get}
    
    func clearStorgae()
}


class SaveDictionaryImpl {
    
    let fileName:String = "Dictionary"
    let encoding:String.Encoding = String.Encoding.utf8
    
    lazy var documentPath:URL? = {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            return fileURL
        } catch {
            print(error)
        }
        return nil
    }()
    
}

extension SaveDictionaryImpl : StoreDictionary  {
    
    var isDictionarySaved: Bool {
        if let path = documentPath, FileManager.default.fileExists(atPath: path.path) {
            return true
        }
        return false
    }
    
    func saveDict(_ dict: String) -> Bool {
        return store(dict)
    }
    
    func loadDict() -> String? {
        return load()
    }
    
    func clearStorgae() {
        if let path = documentPath, isDictionarySaved {
            do {
                try FileManager.default.removeItem(at: path)
            } catch {
                let e = ErrorLog(logMessage: error.localizedDescription)
                sharedLogger.log(e)
            }
        }
    }
    
    @discardableResult func store(_ str: String) -> Bool {
        do {
            if let path = documentPath {
                try str.write(to: path, atomically: false, encoding: encoding)
                return true
            }
        } catch {
            let errLog:Log = ErrorLog(logMessage: error.localizedDescription)
            sharedLogger.log(errLog)
        }
        return false
    }
    
    func load() -> String? {
        do {
            if let path = documentPath, isDictionarySaved {
                let str = try String.init(contentsOf: path, encoding: encoding)
                return str
            }
        } catch {
            let errLog:Log = ErrorLog(logMessage: error.localizedDescription)
            sharedLogger.log(errLog)
        }
        return nil
    }
}
