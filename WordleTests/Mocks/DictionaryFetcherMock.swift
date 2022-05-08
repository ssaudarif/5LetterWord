//
//  DictionaryFetcherMock.swift
//  WordleTests
//
//  Created by syed saud arif on 03/05/22.
//

import Foundation
@testable import Wordle

class DictionaryFetcherMock : DictionaryFetcher {
    
    var shouldSendURLError = false
    var shouldSendNetworkError = false
    
    func fetch(_ completion: @escaping (Result<String, NetworkError>) -> Void ) {
        if shouldSendURLError {
            DispatchQueue.global().async {
                completion(.failure(.urlIsInvalid))
            }
            return
        }
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.1, execute: { [weak self] in
            if let kself = self, kself.shouldSendNetworkError {
                return completion(.failure(.requestFailed(err: "mock network error")))
            }
            completion(.success(MockData.mockDictData))
        })
    }
}
