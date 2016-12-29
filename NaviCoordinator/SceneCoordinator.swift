//
//  SceneCoordinator.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/27.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import Foundation
import UIKit

protocol SceneCoordinatorDelegate: class {
    func didLogout(coordinator: SceneCoordinator)
}
class SceneCoordinator: RootCoordinator{
    public let previousViewController: UIViewController?

    private let tabbarViewController: UITabBarController
    public weak var delegate: SceneCoordinatorDelegate?
    var rootViewController: UIViewController {
        get {
            return tabbarViewController
        }
    }
    // MARK: - life cycle
    init(previousViewController: UIViewController) {
        self.previousViewController = previousViewController
        tabbarViewController = UITabBarController(nibName: nil, bundle: nil)
        let navi1 = UINavigationController(rootViewController: ImageViewController(nibName: nil, bundle: nil))
        let navi2 = UINavigationController(rootViewController: ImageViewController(nibName: nil, bundle: nil))
        let navi3 = UINavigationController(rootViewController: ImageViewController(nibName: nil, bundle: nil))
        
        tabbarViewController.viewControllers = [navi1, navi2, navi3]
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveLogoutNotification(notification:)), name: NSNotification.Name(rawValue: "LogoutNotification"), object: nil)

    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: - Notification
    @objc func didReceiveLogoutNotification(notification: NSNotification) {
         exitCurrentAccount()
    }
    func exitCurrentAccount() {
//        如果是present的，要把每一个present出来的vc都dismiss一次,防止内存泄漏
        let topVC = UIViewController.topViewController()
        print(topVC)
        if topVC.presentingViewController != nil {
            topVC.dismiss(animated: false, completion: nil)
            let delay = DispatchTime.now() + .milliseconds(5)

            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                self.exitCurrentAccount()
            })
            
            return;
        }
        tabbarViewController.dismiss(animated: true, completion: nil)
        delegate?.didLogout(coordinator: self)
    }
    //MARK - CoordiantorExecute
    func startExecute() {
        tabbarViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        previousViewController?.present(tabbarViewController, animated: true, completion: nil)

    }
}
