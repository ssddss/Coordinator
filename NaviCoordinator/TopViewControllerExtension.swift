//
//  TopViewControllerExtension.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/28.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func topViewController() -> UIViewController {
        return UIViewController.topViewControllerWithRootViewController(rootViewController: (UIApplication.shared.keyWindow?.rootViewController)!)
    }
    static func topViewControllerWithRootViewController(rootViewController: UIViewController) -> UIViewController{
        if rootViewController is UITabBarController {
            let tabbarVC = rootViewController as! UITabBarController
            return UIViewController.topViewControllerWithRootViewController(rootViewController: tabbarVC.selectedViewController!)
        }
        else if rootViewController is UINavigationController {
            let naviVC = rootViewController as! UINavigationController
            return UIViewController.topViewControllerWithRootViewController(rootViewController: naviVC.visibleViewController!)
        }
        else if let presentedViewController = rootViewController.presentedViewController {
            return UIViewController.topViewControllerWithRootViewController(rootViewController: presentedViewController)
        }
        else {
            return rootViewController
        }
    }
}
