//
//  UsersAssembly.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Swinject

protocol UsersAssemblyProtocol: class {
    
    func usersModule() -> UIViewController!
    
}

class UsersAssembly: UsersAssemblyProtocol {
    
    private let container : Container
    private let serviceAssembly : ServiceAssemblyProtocol?
    
    init(container: Container) {
        self.container = container
        self.serviceAssembly = container.resolve(ServiceAssemblyProtocol.self)
        
        container.register(UsersView.self) { r in
            let viewController = UsersViewController()
            viewController.presenter = r.resolve(UsersPresenterProtocol.self)!
            viewController.adapterDataSource = self.serviceAssembly?.getService()
            viewController.dialogFactory = r.resolve(DialogFactoryProtocol.self)!
            return viewController
        }
        container.register(UsersPresenterProtocol.self) { r in UsersPresenter() }
            .initCompleted { r, presenter in
                let presenter = presenter as! UsersPresenter
                presenter.view = r.resolve(UsersView.self)!
                presenter.router = r.resolve(UsersRouterProtocol.self)!
        }
        container.register(UsersRouterProtocol.self) { r in UsersRouter() }
            .initCompleted { r, router in
                let router = router as! UsersRouter
                router.viewController = r.resolve(UsersView.self)?.viewController
                router.assembly = self
        }
    }
    
    func usersModule() -> UIViewController! {
        return self.container.resolve(UsersView.self)?.viewController
    }
    
}

