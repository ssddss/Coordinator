//
//  NavigationController.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import Foundation
import UIKit
protocol RootViewControllerProvider: class {
    var rootViewController: UIViewController { get }
}
protocol CoordinatorExecute {
    func startExecute()
}
typealias RootCoordinator =  RootViewControllerProvider & CoordinatorExecute

final class NavigationController: UIViewController {
    // MARK: - Inputs
    
    private let rootViewController: UIViewController
    
    // MARK: - Mutable state
    
    internal var viewControllersToChildCoordinators: [UIViewController: RootCoordinator] = [:]
    
    // MARK: - Lazy views
    
    internal lazy var childNavigationController: UINavigationController =
        UINavigationController(rootViewController: self.rootViewController)
    
    // MARK: - Initialization
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        childNavigationController.delegate = self
        childNavigationController.interactivePopGestureRecognizer?.delegate = self
        
        addChildViewController(childNavigationController)
        view.addSubview(childNavigationController.view)
        childNavigationController.didMove(toParentViewController: self)
        
        childNavigationController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childNavigationController.view.topAnchor.constraint(equalTo: view.topAnchor),
            childNavigationController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            childNavigationController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            childNavigationController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    // MARK: - Public
    
    func pushCoordinator(coordinator: RootCoordinator, animated: Bool) {
        viewControllersToChildCoordinators[coordinator.rootViewController] = coordinator
        
        pushViewController(viewController: coordinator.rootViewController, animated: animated)
    }
    
    func pushViewController(viewController: UIViewController, animated: Bool) {
        childNavigationController.pushViewController(viewController, animated: animated)
    }
    func popViewController(animated: Bool) -> UIViewController? {
        return childNavigationController.popViewController(animated: animated);
    }
}

// MARK: - UIGestureRecognizerDelegate

extension NavigationController: UIGestureRecognizerDelegate {
   
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
   
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        cleanUpChildCoordinators()

    }
    // MARK: - Private
    
    private func cleanUpChildCoordinators() {
        for viewController in viewControllersToChildCoordinators.keys {
            if !childNavigationController.viewControllers.contains(viewController) {
                viewControllersToChildCoordinators.removeValue(forKey: viewController)
            }
        }
    }
}
