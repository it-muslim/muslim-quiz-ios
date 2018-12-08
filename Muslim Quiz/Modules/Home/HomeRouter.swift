//
//  HomeRouter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol: RouterProtocol {
    
}

class HomeRouter: Router, HomeRouterProtocol {
    
    weak var assembly: HomeAssemblyProtocol!
    
}
