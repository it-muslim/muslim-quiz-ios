//
//  StartViewController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol StartView: ViewProtocol {
    func configure(email: String?)
}

class StartViewController: ViewController, StartView {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var presenter: StartPresenterProtocol!
    override var presenterRef: PresenterProtocol! {
        get {
            return presenter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews();
    }
    
    // MARK: Actions
    
    @IBAction func signIn(_ sender: Any) {
        guard let email = self.emailField.text,
            let password = self.passwordField.text,
        email.count != 0, password.count != 0 else {
            return
        }
        
        self.presenter.signInRequested(email: email,
                                       password: password)
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        self.presenter.googleSignInRequested()
    }

    @IBAction func facebookSignIn(_ sender: Any) {
        self.presenter.facebookSignInRequested()
    }
    
    @IBAction func vkSignIn(_ sender: Any) {
        self.presenter.vkSignInRequested()
    }
    
    @objc func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // MARK: Private
    
    private func setupViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    
    // MARK: StartView
    
    func configure(email: String?) {
        self.emailField.text = email
    }
        
}
