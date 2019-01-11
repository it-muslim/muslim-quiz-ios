//
//  UsersPresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation
import Firebase

protocol UsersPresenterProtocol: PresenterProtocol {
    
}

class UsersPresenter : Presenter, UsersPresenterProtocol {
    
    var router: UsersRouterProtocol!
    weak var view: UsersView!
    private var auth: Auth = Auth.auth() // TODO: Inject and optionaly wrap
    private var databaseRef: DatabaseReference! = Database.database().reference() //TODO: Inject and wrap?
    private var usersObserver: DatabaseHandle?
    
    override func viewDidLoad() {
        self.loadData()
    }
    
    private func loadData() {
        self.usersObserver = self.databaseRef.child("users")
            .observe(.value, with: { [weak self] (snapshot) in
                guard let storngSelf = self,
                    let userJSONs = snapshot.value as? [String : [String : Any]] else {
                        return
                }
                
                let users = userJSONs
                    .compactMap({ (userJson) -> User? in
                        let key = userJson.key
                        var value = userJson.value
                        
                        
                        if let uid = self?.auth.currentUser?.uid, key == uid {
                            return nil
                        }
                        
                        value["identifier"] = key
                        return try? User(JSON: value)
                    })
                storngSelf.view.configure(listObjects: users.map { $0.diffable() } )
                
            }, withCancel: { [weak self] (error) in
                self?.view.showError(msg: error.localizedDescription)
            })
    }
    
}
