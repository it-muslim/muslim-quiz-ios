//___FILEHEADER___

import Foundation

protocol ___VARIABLE_presenterProtocolName___: PresenterProtocol {
    
}

class ___VARIABLE_presenterName___ : Presenter, ___VARIABLE_presenterProtocolName___ {
    
    var router: ___VARIABLE_routerProtocolName___!
    weak var view: ___VARIABLE_viewProtocolName___!
    
    override func viewDidLoad() {
        self.view.configure()
    }
    
}
