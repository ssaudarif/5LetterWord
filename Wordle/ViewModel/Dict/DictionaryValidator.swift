//
//  DictionaryValidator.swift
//  Wordle
//
//  Created by syed saud arif on 07/05/22.
//

import Foundation



class DictionaryValidator {
    class func validate(_ s:[String]) -> Bool {
        let lessThan5 = s.filter { (s) -> Bool in
            return s.count != 5
        }
        return (lessThan5.count == 0)
    }
}
