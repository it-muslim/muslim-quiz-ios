//
//  NibLoadable.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 09/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

public protocol NibLoadable {}
public extension NibLoadable where Self: UIView {
    
    public func setupFromNib() {
        guard let view = self.instantiateFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
    }
    
    public func instantiateFromNib() -> UIView? {
        return Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                        owner: self,
                                        options: nil)?.first as? UIView
    }
}
