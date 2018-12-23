//
//  ViewController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol ViewProtocol: class {
    var viewController: UIViewController! { get }
    
    func startLoading()
    func stopLoading()
    func showError(msg: String)
    
}


extension ViewProtocol where Self: UIViewController {
    var viewController : UIViewController! {
        return self
    }
}

class ViewController: UIViewController, ViewProtocol {
    
    public var dialogFactory: DialogFactoryProtocol!
    var presenterRef : PresenterProtocol! {
        get {
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenterRef.viewDidLoad()
    }
    
    func startLoading(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    func stopLoading(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    func showError(msg: String){
        self.dialogFactory.present(in: self,
                                   title: "Что-то пошло не так 🥴",
                                   msg: msg,
                                   cancel: "OK")
    }
    
}
