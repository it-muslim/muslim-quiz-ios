//
//  HomeRouter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol: RouterProtocol {
    func openChoosePartner()
    func openGame(_ game: Game)
}

class HomeRouter: Router, HomeRouterProtocol {
    
    weak var assembly: HomeAssemblyProtocol!
    
    func openChoosePartner() {
        let usersModule = self.assembly.usersAssembly.usersModule()!
        self.viewController.navigationController?.pushViewController(usersModule,
                                                                     animated: true)
    }
    
    
    func openGame(_ game: Game) {
        let gameModule = self.assembly.gameAssembly.gameModule(game: game)!
        self.viewController.navigationController?.pushViewController(gameModule,
                                                                     animated: true)
    }
    
}
