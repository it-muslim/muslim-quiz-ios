//___FILEHEADER___

import Swinject

protocol ___VARIABLE_assemblyProtocolName___: class {
    
    func ___VARIABLE_assemblyMethodsPrefix___Module() -> UIViewController!
    
}

class ___VARIABLE_assemblyName___: ___VARIABLE_assemblyProtocolName___ {
    
    private let container : Container
    init(container: Container) {
        self.container = container
    
        container.register(___VARIABLE_viewProtocolName___.self) { r in
            let viewController = ___VARIABLE_viewControllerName___()
            viewController.presenter = r.resolve(___VARIABLE_presenterProtocolName___.self)!
            return viewController
        }
        container.register(___VARIABLE_presenterProtocolName___.self) { r in ___VARIABLE_presenterName___() }
            .initCompleted { r, presenter in
                let presenter = presenter as! ___VARIABLE_presenterName___
                presenter.view = r.resolve(___VARIABLE_viewProtocolName___.self)!
                presenter.router = r.resolve(___VARIABLE_routerProtocolName___.self)!
        }
        container.register(___VARIABLE_routerProtocolName___.self) { r in ___VARIABLE_routerName___() }
            .initCompleted { r, router in
                let router = router as! ___VARIABLE_routerName___
                router.viewController = r.resolve(___VARIABLE_viewProtocolName___.self)?.viewController
                router.assembly = self
        }
    }
    
    func ___VARIABLE_assemblyMethodsPrefix___Module() -> UIViewController! {
        return self.container.resolve(___VARIABLE_viewProtocolName___.self)?.viewController
    }
    
}

