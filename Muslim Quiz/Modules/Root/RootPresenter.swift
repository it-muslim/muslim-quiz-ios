//
//  RootPresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 22/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation
import Firebase

protocol RootPresenterProtocol: PresenterProtocol {
    
}

class RootPresenter : Presenter, RootPresenterProtocol {
    
    let auth: Auth = Auth.auth()
    var router: RootRouterProtocol!
    weak var view: RootView!
    
    // Firebase
    var authHandle : AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        self.view.configure()
        
        // Showing auth on start if needed
        if self.auth.currentUser == nil {
            self.router.openStart(instantly: true)
        }
        
        // Showing auth on sign out
        self.authHandle = self.auth.addStateDidChangeListener({ [weak self] (auth, user) in
            guard (user != nil) else {
                self?.router.openStart(instantly: false)
                return
            }
            
            self?.router.openHome()
        })
    }
    
    deinit {
        if let authHandle = self.authHandle {
            self.auth.removeStateDidChangeListener(authHandle)
        }
    }
    
}
