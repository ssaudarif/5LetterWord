//
//  Game.swift
//  Wordle
//
//  Created by syed saud arif on 07/05/22.
//

import Foundation


protocol Wordle {
    var word:String {get}
}

class Game : Wordle {
    
    private var _word: String
    
    var word: String {
        get {
            return _word
        }
        set {
            _word = newValue
        }
    }
    
    init(_ w:String) {
        _word = w
    }
    
}
