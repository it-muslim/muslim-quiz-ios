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
        for i in 0..<4 {
            users.append(User(identifier: "user\(i)",
                name: "Амин \(i)",
                level: "Студент \(i)",
                score: 10*i))
        }
        self.view.configure(listObjects: users)
    }
    
}
