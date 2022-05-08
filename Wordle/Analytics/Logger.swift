//
//  Logger.swift
//  Wordle
//
//  Created by syed saud arif on 07/05/22.
//

import Foundation

var sharedLogger:Logger {
    get { return ConsoleLogger.shared }
}

protocol Logger {
    func log(_ l:Log)
}

class ConsoleLogger:Logger {
    
    fileprivate init() {}
    static let shared:Logger = ConsoleLogger()
    
    func log(_ l:Log) {
        let k = logMessageCreator(l)
        print(k)
    }
    
    func logMessageCreator(_ l:Log) -> String {
        let k = (l.isError ? "⚠️" : "✅") + l.logMessage
        return k
    }
}
