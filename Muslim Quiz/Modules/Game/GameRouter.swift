//
//  GameRouter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol GameRouterProtocol: RouterProtocol {
    func openRound(round: Round) 
}

class GameRouter: Router, GameRouterProtocol {
    
    weak var assembly: GameAssemblyProtocol!
    
    func openRound(round: Round) {
        let roundModule = self.assembly.roundsAssembly.roundModule(round: round)!
        self.viewController.navigationController?.pushViewController(roundModule,
                                                                     animated: true)
    }
    
}
