//
//  RoundRouter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol RoundRouterProtocol: RouterProtocol {
    
}

class RoundRouter: Router, RoundRouterProtocol {
    
    weak var assembly: RoundAssemblyProtocol!
    var roundAssembly: RoundAssembly!
    
    
}
