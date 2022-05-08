//
//  Log.swift
//  Wordle
//
//  Created by syed saud arif on 07/05/22.
//

import Foundation

protocol Log {
    var logMessage:String { get }
    var isError:Bool { get }
}

struct ErrorLog : Log {
    var logMessage: String
    var isError:Bool = true
}

struct MessageLog : Log {
    var logMessage: String
    var isError:Bool = false
}


