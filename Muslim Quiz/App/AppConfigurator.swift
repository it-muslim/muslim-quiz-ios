//
//  AppConfigurator.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 21/10/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit
import Firebase
import Swinject

// TODO: Make it initiated from plist.list or configurable from server
class Config {
    static let initialLevel = ""
    static let initialScore = 100
}

protocol AppConfiguratorProtocol {

    func initialSetupApplication(_ application: UIApplication,
                                  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                                  with window: inout UIWindow?)

    
    func applicationWillResignActive(_ application: UIApplication)
    
    func applicationDidEnterBackground(_ application: UIApplication)
    
    func applicationWillEnterForeground(_ application: UIApplication)
    
    func applicationDidBecomeActive(_ application: UIApplication)
    
    func applicationWillTerminateApp(_ application: UIApplication)

}

class AppConfigurator : AppConfiguratorProtocol {

    // DI Container
    private let container : Container = {
        let container = Container()
        container.register(ServiceAssemblyProtocol.self, factory: { r in
            return ServiceAssembly()
        })
        container.register(RootAssemblyProtocol.self, factory: { r in
            return RootAssembly(container: container)
        })
        container.register(DialogFactoryProtocol.self, factory: { r in
            return DialogFactory()
        })
        return container
    }()
    private var rootAssembly: RootAssemblyProtocol!
    init() {
        self.rootAssembly = self.container.resolve(RootAssemblyProtocol.self)
    }
    
    func initialSetupApplication(_ application: UIApplication,
                                  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                                  with window: inout UIWindow?) {
        // Firebase
        FirebaseApp.configure()
        
        // TODO: Add Logging
        // https://dashboard.bugfender.com/bf2/#/bf/app/11182/instructions
//        @_exported import BugfenderSDK 0.
//        Bugfender.activateLogger("eRZTFH8PILkZZX3Qy4qzTlCgqJFTo4dc") // 1. Move to .plist
//        Bugfender.enableUIEventLogging()  // 2. optional, log user interactions automatically
//        DDLog.add(DDBugfenderLogger.shared) 3. Configure CocoaLumberJack
//        BFLog("Hello world!") // Use wrapper for logging /
        
        // Window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = self.rootAssembly.rootModule()
        window?.makeKeyAndVisible()
    }
    
    func applicationWillResignActive(_ application: UIApplication){
        // Sent when the application is about to move from active to inactive state.
        // This can occur for certain types of temporary interruptions
        // (such as an incoming phone call or SMS message) or when the user quits
        // the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers,
        // and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication){
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough application state information to restore your application
        // to its current state in case it is terminated later.
        // If your application supports background execution,
        // this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication){
        // Called as part of the transition from the background to the active state;
        // here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication){
        // Restart any tasks that were paused (or not yet started) while the application was inactive.
        // If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminateApp(_ application: UIApplication){
        // Save data if appropriate
    }

}

