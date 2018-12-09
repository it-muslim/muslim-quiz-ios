//
//  GameAssembly.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Swinject

protocol GameAssemblyProtocol: class {
    
    func gameModule(game: Game) -> UIViewController!
    
}

class GameAssembly: GameAssemblyProtocol {
    
    private let container : Container
    private let serviceAssembly : ServiceAssemblyProtocol?
    
    init(container: Container) {
        self.container = container
        self.serviceAssembly = container.resolve(ServiceAssemblyProtocol.self)
    
        var argument: Game?
        container.register(GameView.self) { (r: Resolver, game: Game) -> GameView in
            let viewController = GameViewController()
            argument = game
            viewController.presenter = r.resolve(GamePresenterProtocol.self)!
            viewController.adapterDataSource = self.serviceAssembly?.getService()
            return viewController
        }
        container.register(GamePresenterProtocol.self) { r in GamePresenter(game: argument!) }
            .initCompleted { r, presenter in
                let presenter = presenter as! GamePresenter
                presenter.view = r.resolve(GameView.self, argument: argument!)!
                presenter.router = r.resolve(GameRouterProtocol.self)!
        }
        container.register(GameRouterProtocol.self) { r in GameRouter() }
            .initCompleted { r, router in
                let router = router as! GameRouter
                router.viewController = r.resolve(GameView.self, argument: argument!)?.viewController
                router.assembly = self
        }
    }
    
    func gameModule(game: Game) -> UIViewController! {
        return self.container.resolve(GameView.self, argument: game)?.viewController
    }
    
}

