//
//  NewWordleCreator.swift
//  Wordle
//
//  Created by syed saud arif on 06/05/22.
//

import Foundation

protocol WordleInitiallizer {
    func createNewWordle(_ dict:Dictionary) -> Wordle
    
}

class WordleInitiallizerImpl : WordleInitiallizer {
        
    func createNewWordle(_ dict:Dictionary) -> Wordle {
        return Game("sssss")
    }
    
}
