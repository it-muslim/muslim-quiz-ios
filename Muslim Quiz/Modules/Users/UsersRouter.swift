//
//  UsersRouter.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol UsersRouterProtocol: RouterProtocol {
    
}

class UsersRouter: Router, UsersRouterProtocol {
    
    weak var assembly: UsersAssemblyProtocol!
    
}
