//
//  DeeplinkConfigurator.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 21/10/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol DeeplinkHandlerProtocol {
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
    
}

class DeeplinkHandler : DeeplinkHandlerProtocol {
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return false
    }

    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return false
    }
 
}
