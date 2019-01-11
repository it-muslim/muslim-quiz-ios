//
//  HomeAssembly.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Swinject

protocol HomeAssemblyProtocol: class {
    
    var usersAssembly: UsersAssembly! { get }
    var gameAssembly: GameAssembly! { get }
    func homeModule() -> UIViewController!
    
}

class HomeAssembly: HomeAssemblyProtocol {
    
    var usersAssembly: UsersAssembly!
    var gameAssembly: GameAssembly!
    private let serviceAssembly : ServiceAssemblyProtocol?
    private let container: Container
    
    init(container: Container) {
        self.container = container
        self.usersAssembly = UsersAssembly(container: container)
        self.gameAssembly = GameAssembly(container: container)
        self.serviceAssembly = container.resolve(ServiceAssemblyProtocol.self)

        self.container.register(HomeView.self) { r in
            let viewController = HomeViewController()
            viewController.presenter = r.resolve(HomePresenterProtocol.self)!
            viewController.adapterDataSource = self.serviceAssembly?.getService()
            viewController.dialogFactory = r.resolve(DialogFactoryProtocol.self)!
            return viewController
        }
        self.container.register(HomePresenterProtocol.self) { r in HomePresenter() }
            .initCompleted { r, presenter in
                let presenter = presenter as! HomePresenter
                presenter.view = r.resolve(HomeView.self)!
                presenter.router = r.resolve(HomeRouterProtocol.self)!
        }
        self.container.register(HomeRouterProtocol.self) { r in HomeRouter() }
            .initCompleted { r, router in
                let router = router as! HomeRouter
                router.viewController = r.resolve(HomeView.self)?.viewController
                router.assembly = self
        }
    }
    
    func homeModule() -> UIViewController! {
        return self.container.resolve(HomeView.self)!.viewController
    }
    
}

