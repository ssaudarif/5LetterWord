//
//  DictionaryInitiallizer_Network.swift
//  Wordle
//
//  Created by syed saud arif on 07/05/22.
//

import Foundation

typealias InitCompletionBlock = (Result<[String], Error>) -> Void

protocol DictionaryInitiallizer {
    func startInit(_ completion:@escaping(InitCompletionBlock))
}

class DictionaryInitiallizer_Network {
    
    var compHandler:InitCompletionBlock? = nil
    let df:DictionaryFetcher

    init(_ dictionaryFetcher : DictionaryFetcher = DictionaryFetcherImpl()) {
        df = dictionaryFetcher
    }
    
    func startInit(_ completion:@escaping(InitCompletionBlock)) {
        self.compHandler = completion
    }
    
    func startFetch() {
        df.fetch { [weak self] (result) in
            switch(result) {
            case .failure(let err):
                self?.handleError(err)
            case .success(let s):
                self?.handleSuccess(s)
            }
            
        }
    }
    
    func handleError(_ n:Error) {
        let errLog:Log = ErrorLog(logMessage: n.localizedDescription)
        sharedLogger.log(errLog)
    }
    
    func handleSuccess(_ s:String) {
        if let d = DictionaryImpl.splitWordsFromString(s) {
            compHandler?(.success(d))
        } else {
            compHandler?(.failure(InetrnalError.invalidDictionary))
        }
    }
}
