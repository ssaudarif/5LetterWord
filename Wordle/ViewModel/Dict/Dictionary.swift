//
//  Dictionary.swift
//  Wordle
//
//  Created by syed saud arif on 03/05/22.
//

import Foundation

protocol Dictionary {
    var dict:[String] {get}
    var isInitialized:Bool { get }
    var setObserver:DictionaryObserver? { get set }
}

protocol DictionaryObserver : AnyObject {
    func isInitiallized()
}

class DictionaryImpl : Dictionary {
    
    var dict = [String]()
    private weak var _observer: DictionaryObserver?
    private var networkInit : DictionaryInitiallizer?
    
    private var _isInitialized:Bool = false {
        didSet {
            _observer?.isInitiallized()
        }
    }
    
    var isInitialized: Bool {
        return _isInitialized
    }
    
    var setObserver: DictionaryObserver? {
        set {
            _observer = newValue
        }
        get {
            return _observer
        }
    }
    
    
    init(_ dictionaryFetcher : DictionaryFetcher = DictionaryFetcherImpl()) {
        if let dict = tryLocalInit() {
            //Initiallized by local
            handleSuccess(dict)
        } else {
            let k:InitCompletionBlock = { [weak self] (result) in
                switch ( result ) {
                case .success(let s):
                    //Initiallized by network
                    self?.handleSuccess(s)
                case .failure(let e):
                    sharedLogger.log(ErrorLog(logMessage: e.localizedDescription))
                    if let dict = self?.tryResourceInit() {
                        //Initiallized by resource
                        self?.handleSuccess(dict)
                        sharedLogger.log(MessageLog.init(logMessage: "Dictionary initiallized."))
                    } else {
                        sharedLogger.log(ErrorLog.init(logMessage: "Everything failed. Dictionary cannot be initiallized."))
                    }
                }
            }
            tryNetworkInit(dictionaryFetcher, comp: k)
        }
    }
    
    func tryLocalInit() -> [String]? {
        let saveDict = SaveDictionaryImpl()
        if saveDict.isDictionarySaved,
           let s = saveDict.loadDict(),
           let dict = DictionaryImpl.splitWordsFromString(s) {
            return dict
        }
        else {
            return nil
        }
    }
    
    func tryNetworkInit(_ dictionaryFetcher : DictionaryFetcher, comp:@escaping InitCompletionBlock) {
        networkInit = DictionaryInitiallizer_Network(dictionaryFetcher)
        networkInit?.startInit(comp)
    }
    
    func tryResourceInit() -> [String]? {
        if let u = Bundle.main.path(forResource: "sgb-words", ofType: "txt") {
            do {
                let s = try String.init(contentsOfFile: u, encoding: String.Encoding.utf8)
                if let dict = DictionaryImpl.splitWordsFromString(s) {
                    return dict
                }
            } catch {
                sharedLogger.log(ErrorLog.init(logMessage: error.localizedDescription))
            }
        }
        return nil
    }
    
    func handleSuccess(_ s:[String]) {
        self.dict = s
        self._isInitialized = true
    }
    
}


extension DictionaryImpl {
    class func splitWordsFromString(_ s:String) -> [String]? {
        let words = s.split(separator: Character("\n"))
        let d = words.map({ (s) -> String in
            return String(s)
        })
        if DictionaryValidator.validate(d) {
            return d
        }
        return nil
    }
}
