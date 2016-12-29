//
//  WelcomCoordinator.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/27.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import Foundation
import UIKit
protocol WelcomCoordinatorDelegate: class {
    func welocmCoordinatorDidFinish(welcomCoordinator: WelcomCoordinator)
    func userDidLogin(welcomCoordinator: WelcomCoordinator, userName: String)
}
class WelcomCoordinator: RootCoordinator, WelcomViewControllerDelegate, SignUpViewControllerDelegate{
    var rootViewController: UIViewController {
        get {
            return viewController;
        }
    }
    public let previousViewController: UIViewController?
    private let viewController: NavigationController
    public weak var delegate: WelcomCoordinatorDelegate?
   
    // MARK: - life cycle
    init(previousViewController: UIViewController) {
        self.previousViewController = previousViewController
        
        let welcomeVC = WelcomViewController(nibName: nil, bundle: nil)
        self.viewController = NavigationController(rootViewController: welcomeVC)
        welcomeVC.delegate = self
        
    }
    
    // MARK: - WelcomViewControllerDelegate
    func finishShowWelcome() {
        viewController.dismiss(animated: true, completion: nil)
        delegate?.welocmCoordinatorDidFinish(welcomCoordinator: self)
    }
    func loginButtonClick() {
        viewController.dismiss(animated: true, completion: nil)
        delegate?.userDidLogin(welcomCoordinator: self, userName: "hi")
    }
    func signUpButtonClick() {
        let signUpVC = SignUpViewController(nibName: nil, bundle: nil)
        signUpVC.delegate = self
        self.viewController.pushViewController(viewController: signUpVC, animated: true)
    }
    func signUpPop() {
        self.viewController.popViewController(animated: true)
    }
    // MARK: - SignUpViewControllerDelegate
    func didSignUp() {
        viewController.dismiss(animated: true, completion: nil)
        delegate?.userDidLogin(welcomCoordinator: self, userName: "hi")
    }
    //MARK - CoordiantorExecute
    func startExecute() {
        previousViewController?.present(viewController, animated: false, completion: nil)
    }
}
