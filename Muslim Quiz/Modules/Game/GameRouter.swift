//
//  GameRouter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol GameRouterProtocol: RouterProtocol {
    
}

class GameRouter: Router, GameRouterProtocol {
    
    weak var assembly: GameAssemblyProtocol!
    
}
