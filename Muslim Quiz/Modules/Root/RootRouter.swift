//
//  RootRouter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 22/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol RootRouterProtocol: RouterProtocol {
    func openStart(instantly: Bool)
    func openHome()
}

class RootRouter: Router, RootRouterProtocol {
    
    weak var assembly: RootAssemblyProtocol!
    
    func openStart(instantly: Bool = false) {
        let startModule = self.assembly.startAssembly.startModule()!
        self.viewController.present(startModule,
                                    animated: instantly == false,
                                    completion: nil)
    }
    
    func openHome() {
        self.viewController.presentedViewController?.dismiss(animated: true,
                                                             completion: nil)
        let homeModule = self.assembly.homeAssembly.homeModule()!
        (self.viewController as? UINavigationController)?.setViewControllers([homeModule], animated: false)
    }
    
}
