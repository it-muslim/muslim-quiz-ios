//
//  RootViewController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 22/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol RootView: class {
    func configure()
}

class RootViewController: UINavigationController {
    
    var presenter: RootPresenterProtocol!
    var presenterRef: PresenterProtocol! {
        get {
            return presenter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
}

extension RootViewController: RootView {
    
    func configure() { }

}
