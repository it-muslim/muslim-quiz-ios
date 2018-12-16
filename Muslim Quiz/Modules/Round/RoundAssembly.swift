//
//  RoundAssembly.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 15/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Swinject

protocol RoundAssemblyProtocol: class {
    
    func roundModule(round: Round) -> UIViewController!
    
}

class RoundAssembly: RoundAssemblyProtocol {
    
    private let container : Container
    private let serviceAssembly : ServiceAssemblyProtocol?
    
    init(container: Container) {
        self.container = container
        self.serviceAssembly = container.resolve(ServiceAssemblyProtocol.self)
    
        var argument: Round!
        container.register(RoundView.self) { (r: Resolver, round: Round)  -> RoundView in
            let viewController = RoundViewController()
            argument = round
            viewController.presenter = r.resolve(RoundPresenterProtocol.self)!
            viewController.adapterDataSource = self.serviceAssembly?.getService()
            return viewController
        }
        container.register(RoundPresenterProtocol.self) { r in RoundPresenter(round: argument) }
            .initCompleted { r, presenter in
                let presenter = presenter as! RoundPresenter
                presenter.view = r.resolve(RoundView.self, argument: argument!)!
                presenter.router = r.resolve(RoundRouterProtocol.self)!
        }
        container.register(RoundRouterProtocol.self) { r in RoundRouter() }
            .initCompleted { r, router in
                let router = router as! RoundRouter
                router.viewController = r.resolve(RoundView.self, argument: argument)?.viewController
                router.assembly = self
        }
    }
    
    func roundModule(round: Round) -> UIViewController! {
        return self.container.resolve(RoundView.self, argument: round)?.viewController
    }
    
}

