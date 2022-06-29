//
//  ViewController.swift
//  Wordle
//
//  Created by syed saud arif on 03/05/22.
//

import UIKit


class ViewController: UIViewController {
    
    let launchRouter:LaunchRouter = LaunchRouterImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        launchRouter.createNewWordle(with: self)
        // Do any additional setup after loading the view.
    }
}

extension ViewController : DictionaryObserver {
    func isInitiallized() {
        
    }
}

