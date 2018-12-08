//___FILEHEADER___

import UIKit

protocol ___VARIABLE_viewProtocolName___: ViewProtocol {
    func configure()
}

class ___VARIABLE_viewControllerName___: ViewController {
    
    var presenter: ___VARIABLE_presenterProtocolName___!
    override var presenterRef: PresenterProtocol! {
        get {
            return presenter
        }
    }
    
}

extension ___VARIABLE_viewControllerName___: ___VARIABLE_viewProtocolName___ {
    
    func configure() { }

}
