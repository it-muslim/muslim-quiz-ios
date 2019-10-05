//
//  StartAssembly.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Swinject

protocol StartAssemblyProtocol: class {
    
    var homeAssembly: HomeAssembly! { get}
    
    func startModule() -> UIViewController!
    
}

class StartAssembly: StartAssemblyProtocol {
    
    let serviceAssembly: ServiceAssemblyProtocol
    var homeAssembly: HomeAssembly!
    private let container: Container
    
    init(container: Container) {
        self.container = container
        self.homeAssembly = HomeAssembly(container: container)
        self.serviceAssembly = container.resolve(ServiceAssemblyProtocol.self)!
        
        self.container.register(StartView.self) { r in
            let viewController = StartViewController()
            viewController.presenter = r.resolve(StartPresenterProtocol.self)!
            viewController.dialogFactory = r.resolve(DialogFactoryProtocol.self)!
            return viewController
        }
        self.container.register(StartPresenterProtocol.self) { r in StartPresenter() }
            .initCompleted { r, presenter in
                let presenter = presenter as! StartPresenter
                presenter.view = r.resolve(StartView.self)!
                presenter.router = r.resolve(StartRouterProtocol.self)!
                presenter.eventTracker = self.serviceAssembly.getService()
        }
        self.container.register(StartRouterProtocol.self) { r in StartRouter() }
            .initCompleted { r, router in
                let router = router as! StartRouter
                router.viewController = r.resolve(StartView.self)?.viewController
                router.assembly = self
        }
    }
    
    func startModule() -> UIViewController! {
        let startModule = self.container.resolve(StartView.self)!.viewController!
        return UINavigationController(rootViewController:startModule)
    }
    
    
}

