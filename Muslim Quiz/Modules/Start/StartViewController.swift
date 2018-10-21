//
//  ViewController.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 21/10/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol StartViewControllerProtocol : class {
    var viewController : UIViewController { get }
}
extension StartViewControllerProtocol where Self: UIViewController {
    var viewController : UIViewController {
        return self
    }
}

class StartViewController: UIViewController, StartViewControllerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }


}

