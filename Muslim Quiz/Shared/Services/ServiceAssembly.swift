//
//  ServiceAssembly.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 08/12/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import Swinject

protocol ServiceAssemblyProtocol { // aka ServiceLocalor :)
    func getService<T>() -> T?
}

class ServiceAssembly: ServiceAssemblyProtocol {
    
    private let container : Container
    init() {
        self.container = Container()
        
        self.container.register(ColorServiceProtocol.self) { r in
            return RandomColorService()
        }.inObjectScope(.container)
        self.container.register(SectionSourceServiceProtocol.self) { r in
            return SectionSourceService()
        }.inObjectScope(.transient)
    }

    func getService<T>() -> T? {
        return self.container.resolve(T.self)
    }
    
}
