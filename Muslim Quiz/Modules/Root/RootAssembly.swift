//
//  RootAssembly.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 22/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Swinject

protocol RootAssemblyProtocol: class {
    
    var startAssembly: StartAssembly! { get }
    var homeAssembly: HomeAssembly! { get }
    func rootModule() -> UIViewController!
    
}

class RootAssembly: RootAssemblyProtocol {
    
    private let container : Container
    private(set) var startAssembly: StartAssembly!
    private(set) var homeAssembly: HomeAssembly!
    
    init(container: Container) {
        self.container = container
        self.startAssembly = StartAssembly(container: container)
        self.homeAssembly = HomeAssembly(container: container)
    
        container.register(RootView.self) { r in
            let viewController = RootViewController()
            viewController.presenter = r.resolve(RootPresenterProtocol.self)!
            return viewController
        }
        container.register(RootPresenterProtocol.self) { r in RootPresenter() }
            .initCompleted { r, presenter in
                let presenter = presenter as! RootPresenter
                presenter.view = r.resolve(RootView.self)!
                presenter.router = r.resolve(RootRouterProtocol.self)!
        }
        container.register(RootRouterProtocol.self) { r in RootRouter() }
            .initCompleted { r, router in
                let router = router as! RootRouter
                router.viewController = r.resolve(RootView.self) as? UIViewController
                router.assembly = self
        }
    }
    
    func rootModule() -> UIViewController! {
        return self.container.resolve(RootView.self) as? UIViewController
    }
    
}

