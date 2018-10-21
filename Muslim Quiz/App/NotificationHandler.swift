//
//  NotificationHandler.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 21/10/2018.
//  Copyright © 2018 Amin Benarieb. All rights reserved.
//

import UIKit

protocol NotificationHandlerProtocol {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    
    func application(_ application: UIApplication,
                     didRegister notificationSettings: UIUserNotificationSettings)
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    
    
    func application(_ application: UIApplication,
                     handleActionWithIdentifier identifier: String?,
                     forRemoteNotification userInfo: [AnyHashable : Any],
                     withResponseInfo responseInfo: [AnyHashable : Any],
                     completionHandler: @escaping () -> Void)
    
}

class NotificationHandler : NotificationHandlerProtocol {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?){}
    
    func application(_ application: UIApplication,
                     didRegister notificationSettings: UIUserNotificationSettings){}
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){}
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){}
        
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void){}
    
    
    func application(_ application: UIApplication,
                     handleActionWithIdentifier identifier: String?,
                     forRemoteNotification userInfo: [AnyHashable : Any],
                     withResponseInfo responseInfo: [AnyHashable : Any],
                     completionHandler: @escaping () -> Void){}
    
}
