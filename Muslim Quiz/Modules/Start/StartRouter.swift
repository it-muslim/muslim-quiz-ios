//
//  StartRouter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol StartRouterProtocol: RouterProtocol {
    func openHome()
}

class StartRouter: Router, StartRouterProtocol {
    
    weak var assembly: StartAssemblyProtocol!

    func openHome() {
        let homeModule = self.assembly.homeAssembly.homeModule()!
        self.viewController.navigationController?.pushViewController(homeModule,
                                                                     animated: true)
    }
    
}
