//
//  StartViewController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol StartView: ViewProtocol {
    func configure()
}

class StartViewController: ViewController {
    
    var presenter: StartPresenterProtocol!
    override var presenterRef: PresenterProtocol! {
        get {
            return presenter
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        self.presenter.signInRequested()
    }
    
}

extension StartViewController: StartView {
    
    func configure() { }

}
