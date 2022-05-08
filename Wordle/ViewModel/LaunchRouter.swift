//
//  LaunchRouter.swift
//  Wordle
//
//  Created by syed saud arif on 03/05/22.
//

import Foundation

protocol LaunchRouter {
    func createNewWordle()
}

class LaunchRouterImpl : LaunchRouter {
    var d : Dictionary? = nil
    
    func createNewWordle() {
        let fetcher : DictionaryFetcher = DictionaryFetcherImpl()
        self.d = DictionaryImpl(fetcher)
        self.d?.setObserver = self
    }
}

extension LaunchRouterImpl : DictionaryObserver {
    func isInitiallized() {
        
    }
}
