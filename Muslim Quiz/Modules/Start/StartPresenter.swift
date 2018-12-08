//
//  StartPresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

protocol StartPresenterProtocol: PresenterProtocol {
    func signInRequested()
}

class StartPresenter : Presenter, StartPresenterProtocol {
    
    var router: StartRouterProtocol!
    weak var view: StartView!
    
    override func viewDidLoad() {
        self.view.configure()
    }
    
    func signInRequested() {
        self.router.openHome()
    }
    
}
