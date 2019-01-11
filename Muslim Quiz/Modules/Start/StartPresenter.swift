//
//  StartPresenter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Foundation
import Firebase

fileprivate let kUserEmailKey = "kUserEmailKey"

protocol StartPresenterProtocol: PresenterProtocol {
    func signInRequested(email: String, password: String)
    func vkSignInRequested()
    func facebookSignInRequested()
    func googleSignInRequested()
}

class StartPresenter : Presenter, StartPresenterProtocol {
    
    var router: StartRouterProtocol!
    weak var view: StartView!
    
    private var auth: Auth = Auth.auth() // TODO: Inject and optionaly wrap
    private var userDefaults: UserDefaults = UserDefaults.standard // TODO: Inject and optionaly wrap
    private var databaseRef: DatabaseReference! = Database.database().reference() //TODO: Inject and wrap?
    
    override func viewDidLoad() {
        let email = userDefaults.string(forKey: kUserEmailKey)
        self.view.configure(email: email)
    }
    
    func signInRequested(email: String, password: String) {
        userDefaults.set(email, forKey: kUserEmailKey)
        self.signUp(email: email, password: password)
    }
    
    func vkSignInRequested() {
        
    }
    
    func facebookSignInRequested() {
        
    }
    
    func googleSignInRequested() {
        
    }
    
    // MARK: Private
    
    private func signUp(email: String, password: String) {
        self.view.startLoading()
        self.auth.createUser(withEmail: email,
                               password: password)
        { [weak self] (auth, error) in
            self?.processAuth(email, password, auth, error)
        }
    }
    
    private func signIn(email: String, password: String) {
        self.view.startLoading()
        self.auth.signIn(withEmail: email, password: password) { [weak self] (auth, error) in
            self?.processAuth(email, password, auth, error)
        }
    }
    
    private func processAuth(_ email: String,
                             _ password : String,
                             _ auth : AuthDataResult?,
                             _ error: Error?)  {
        defer {
            self.view.stopLoading()
        }
        
        if let error = error as NSError? {
            guard error.code != AuthErrorCode.emailAlreadyInUse.rawValue else {
                self.signIn(email: email, password: password)
                return
            }
            self.processError(error: error)
            return
        }
        
        guard let user = auth?.user else {
            self.view.showError(msg: "Авторизация прошла, но потом что-то то пошло не так...")
            return
        }
        
        self.databaseRef.child("users/\(user.uid)").setValue([
            "email" : email,
            "level" : Config.initialLevel,
            "score" : Config.initialScore
            ])
        self.router.openHome()
    }
    
    private func processError(error: Error) {
        let error = error as NSError
        switch (error.code) {
        case AuthErrorCode.invalidEmail.rawValue:
            self.view.showError(msg: "Email не понравился ваш")
        case AuthErrorCode.operationNotAllowed.rawValue:
            self.view.showError(msg: "Бек не настроен")
        case AuthErrorCode.wrongPassword.rawValue:
            self.view.showError(msg: "Пароль не понравился ваш")
        case AuthErrorCode.userDisabled.rawValue:
            self.view.showError(msg: "Пользователь деактивирован")
        case AuthErrorCode.weakPassword.rawValue:
            self.view.showError(msg: "Слабый пароль")
        default:
            self.view.showError(msg: error.localizedDescription)
        }
    }
    
}
