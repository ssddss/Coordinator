//
//  AppDelegate.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppCoordinatorDelegate {

    var window: UIWindow?
    private var timer: Timer?
    private var appCoordinator: AppCoordinator?
//MARK: - AppCoordinatorDelegate
    func reCreateAppCoordinator() {
        let myRootViewController = RootViewController(nibName: nil, bundle: nil)
        window?.rootViewController = myRootViewController
        appCoordinator = nil
        
        appCoordinator = AppCoordinator(rootViewController: myRootViewController, launchFinish: true, delegate: self)
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let myRootViewController = RootViewController(nibName: nil, bundle: nil)
        window?.rootViewController = myRootViewController

        appCoordinator = AppCoordinator(rootViewController: myRootViewController, launchFinish: false, delegate: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveLogoutNotification(notification:)), name: NSNotification.Name(rawValue: "LogoutNotification"), object: nil)

//        模拟收到通知或者通用链接
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.remoteOrUniversialLinkReceive), userInfo: nil, repeats: true)
//        timer.fire()
        return true
    }
    // MARK: - Notification
    @objc func didReceiveLogoutNotification(notification: NSNotification) {
//        timer?.invalidate()
    }
    /// 假装收到了通知或者通用链接
    func remoteOrUniversialLinkReceive() {
        appCoordinator?.receiveRemoteURLRoute(urlName: "abc")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

