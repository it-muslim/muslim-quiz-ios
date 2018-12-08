//
//  RedService.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol ColorServiceProtocol  {
    
    var color: UIColor { get }
    
}

class RandomColorService: ColorServiceProtocol {
    
    lazy var color: UIColor = {
        return UIColor(red: CGFloat.random(in: 0..<255)/255.0,
                       green: CGFloat.random(in: 0..<255)/255.0,
                       blue: CGFloat.random(in: 0..<255)/255.0,
                       alpha: 1)
    }()
}
