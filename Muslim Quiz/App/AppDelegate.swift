//
//  AppDelegate.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 21/10/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appConfigurator: AppConfiguratorProtocol!
    var deepLinkHandler: DeeplinkHandlerProtocol!
    var notificationHandler: NotificationHandlerProtocol!
    var window: UIWindow?
    
    // DI Container
    let container: Container = {
        let container = Container()
        container.register(AppConfiguratorProtocol.self) { _ in AppConfigurator() }
        container.register(DeeplinkHandlerProtocol.self) { _ in DeeplinkHandler() }
        container.register(NotificationHandlerProtocol.self) { _ in NotificationHandler() }
        
        return container
    }()
    
    // MARK: Lifecycle
    
    override init() {
        self.appConfigurator = container.resolve(AppConfiguratorProtocol.self)
        self.deepLinkHandler = container.resolve(DeeplinkHandlerProtocol.self)
        self.notificationHandler = container.resolve(NotificationHandlerProtocol.self)
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.appConfigurator.initialSetupApplication(application,
                                                     didFinishLaunchingWithOptions: launchOptions,
                                                     with: &self.window)
        self.notificationHandler.application(application,
                                             didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        self.appConfigurator.applicationWillResignActive(application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        self.appConfigurator.applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        self.appConfigurator.applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        self.appConfigurator.applicationDidBecomeActive(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.appConfigurator.applicationWillTerminateApp(application)
    }

    // MARK: Links

    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return self.deepLinkHandler.application(application,
                                         continue: userActivity,
                                         restorationHandler: restorationHandler)
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return self.deepLinkHandler.application(app, open: url, options: options)
    }
    
    // MARK: Remote Notifications
    
    func application(_ application: UIApplication,
                     didRegister notificationSettings: UIUserNotificationSettings) {
        self.notificationHandler.application(application, didRegister: notificationSettings)
        
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.notificationHandler.application(application,
                                             didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        self.notificationHandler.application(application,
                                             didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.notificationHandler.application(application,
                                             didReceiveRemoteNotification: userInfo,
                                             fetchCompletionHandler: completionHandler)
    }
    
    func application(_ application: UIApplication,
                     handleActionWithIdentifier identifier: String?,
                     forRemoteNotification userInfo: [AnyHashable : Any],
                     withResponseInfo responseInfo: [AnyHashable : Any],
                     completionHandler: @escaping () -> Void) {
        self.notificationHandler.application(application,
                                             handleActionWithIdentifier: identifier,
                                             forRemoteNotification: userInfo,
                                             withResponseInfo: responseInfo,
                                             completionHandler: completionHandler)
    }

}

