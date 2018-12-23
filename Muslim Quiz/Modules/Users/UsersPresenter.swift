//
//  UsersPresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation

protocol UsersPresenterProtocol: PresenterProtocol {
    
}

class UsersPresenter : Presenter, UsersPresenterProtocol {
    
    var router: UsersRouterProtocol!
    weak var view: UsersView!
    
    override func viewDidLoad() {
        var users = [User]()
//        self.view.configure(listObjects: users)
    }
    
}
