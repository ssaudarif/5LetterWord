//
//  DictionaryFetcher.swift
//  Wordle
//
//  Created by syed saud arif on 03/05/22.
//

import Foundation

enum NetworkError : Error {
    case urlIsInvalid
    case requestFailed(err:String)
    case dataFormatError
}

protocol DictionaryFetcher {
    func fetch(_ completion: @escaping (Result<String, NetworkError>) -> Void )
}


class DictionaryFetcherImpl : DictionaryFetcher{
    
    func fetch(_ completion: @escaping (Result<String, NetworkError>) -> Void ) {
        guard let url = URL(string: "https://www-cs-faculty.stanford.edu/~knuth/sgb-words.txt") else {
            DispatchQueue.global().async {
                completion(.failure(.urlIsInvalid))
            }
            return
        }
        //let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let e = error {
                return completion(.failure(.requestFailed(err: e.localizedDescription)))
            }
            if let d = data {
                guard let s = String.init(data: d, encoding: String.Encoding.utf8) else {
                    completion(.failure(.dataFormatError))
                    return
                }
                completion(.success(s))
            }
        }
        
        task.resume()
    }
    
}
