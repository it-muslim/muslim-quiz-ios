//
//  ViewController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol ViewProtocol: class {
    var viewController: UIViewController! { get }
}

extension ViewProtocol where Self: UIViewController {
    var viewController : UIViewController! {
        return self
    }
}

class ViewController: UIViewController, ViewProtocol {
    
    var presenterRef : PresenterProtocol! {
        get {
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenterRef.viewDidLoad()
    }
    
}
