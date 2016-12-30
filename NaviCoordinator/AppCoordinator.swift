//
//  AppCoordinator.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import Foundation
import UIKit
protocol AppCoordinatorDelegate: class {
    func reCreateAppCoordinator()
}
class AppCoordinator: ADViewControllerDelegate, RootViewControllerDelegate, RootCoordinator, WelcomCoordinatorDelegate, SceneCoordinatorDelegate, ADDetailViewControllerDelegate, UniversialLinkOrNotificationViewControllerDelegate{
    // MARK: - Inputs
    public weak var delegate: AppCoordinatorDelegate?
    
    /// 表示重新创建，应用刚启动的时候为NO，如果退登录后重新创建是YES，决定要不要显示广告页面
    private var launchFinish: Bool = false
    
    /// 用户的登录状态能选择的值
    private let userLoginStatus = [true, false]
    
    /// 登录状态
    private var userDidLogin: Bool = false
    
    /// 用作中转的界面，仅是一个空界面
    private let appRootViewController: RootViewController
    
    /// 子coordinator容器
    private var childCoordinators: [RootCoordinator] = []
    
    /// 广告点击的链接在map中的key
    private let urlRouteMapADKey = "routeMapADKey"
    
    /// 通用链接或者通知在map中的key
    private let urlRouteMapNotificationOrUniversialKey = "urlRouteMapNotificationOrUniversialKey"
    
    /// 存放广告点击或者通用链接和通知
    private var appURLRouteMap: [String:String] = [:]
    
    /// 表示已经创建了登录或者登录后的内容界面，要present广告或者通用链接和通知内容的时候判断是否已经完成界面的创建先
    private var appContentViewDidShow: Bool = false
    var rootViewController: UIViewController {
        get {
            return self.rootViewController
        }
    }
    init(rootViewController: RootViewController, launchFinish: Bool, delegate: AppCoordinatorDelegate) {
        self.delegate = delegate
        self.appRootViewController = rootViewController
        self.appRootViewController.delegate = self
        self.launchFinish = launchFinish
//        userDidLogin = userLoginStatus[Int(arc4random_uniform(UInt32(userLoginStatus.count)))]
        //监听app内容界面的viewDidAppear后才present要显示的内容
        NotificationCenter.default.addObserver(self, selector: #selector(self.appContentViewDidFinishLaunch(notification:)), name: NSNotification.Name(rawValue: "appContentViewDidFinishLaunch"), object: nil)
    }
    deinit {
        //移除监听
        NotificationCenter.default.removeObserver(self)
    }
    // MARK - UniversialLink or RemoteNotification
    
    /// 通知或者通用链接点击时，处理详情跳转
    ///
    /// - Parameter urlName: 地址
    func receiveRemoteURLRoute(urlName: String) {
        appURLRouteMap[urlRouteMapNotificationOrUniversialKey] = urlName
        
        //如果应用刚启动，我们自己的登录或者登录过的内容界面没有创建完成，先等待3秒后再请求一次
        if !appContentViewDidShow {
            let delay = DispatchTime.now() + .seconds(3)
            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
               self.receiveRemoteURLRoute(urlName: urlName)
            })
            return;
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "appContentViewDidFinishLaunch"), object: nil)

    }
    //MARK - CoordiantorExecute
    
    func startExecute() {
        //如果不是第一次启动，就不显示广告了
        if launchFinish {
            showBaseContentViewController()
            return
        }
        //显示广告
        let adVC: ADViewController = ADViewController(nibName: nil, bundle: nil)
        adVC.delegate = self
        let naviADVC = NavigationController(rootViewController: adVC)
        self.appRootViewController.present(naviADVC, animated: false, completion: nil)

    }
 
    // MARK: - RootViewControllerDelegate
    func rootViewControllerDidShow() {
        //要在appcoordinator的rootViewController出现后才开始我们正常的app流程
        startExecute()
    }
    // MARK: - ADViewControllerDelegate
    func adDidShow(adVC: ADViewController) {
        adVC.dismiss(animated: false, completion: nil)
        showBaseContentViewController()
    }
    func showTargetAD(adVC: ADViewController, name: String) {
        adVC.dismiss(animated: false, completion: nil)
        appURLRouteMap[urlRouteMapADKey] = name
        showBaseContentViewController()
    
        
    }
    // MARK: notification
    
    /// 监听app的界面创建完成后才做广告或者通知链接，通知的详情显示行为
    ///
    /// - Parameter notification: 通知
    @objc func appContentViewDidFinishLaunch(notification: NSNotification) {
        
        appContentViewDidShow = true
        //因为首页和登录页面出现时这个都会收到通知，所以要判断是否有要跳转的地址
        if appURLRouteMap.count == 0 {
            return;
        }
        
        //获取top view controller
        let topVC = UIViewController.topViewController()
        print(topVC)

        //优先显示通知或者通用链接，如果有通知或者通用链接，那么即使点击了广告也不处理。
        if appURLRouteMap[urlRouteMapNotificationOrUniversialKey] == nil {
            appURLRouteMap.removeAll()
            let adDetailVC = ADDetailViewController(nibName: nil, bundle: nil)
            adDetailVC.delegate = self;
            adDetailVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            topVC.present(adDetailVC, animated: true, completion: nil)
        }
        else {
            if userDidLogin {
                appURLRouteMap.removeAll()
                let universialLinkDetailVC = UniversialLinkOrNotificationViewController(nibName: nil, bundle: nil)
                universialLinkDetailVC.delegate = self;
                topVC.present(universialLinkDetailVC, animated: true, completion: nil)
            }
       }

    }
    // MARK: - UniversialLinkOrNotificationViewControllerDelegate
    func didReadUniversialOrNotificationDetail(detailVC: UniversialLinkOrNotificationViewController) {
        detailVC.dismiss(animated: false, completion: nil)
    }
    // MARK: - ADDetailViewControllerDelegate

    func didReadAdDetail(detailVC: ADDetailViewController) {
        detailVC.dismiss(animated: false, completion: nil)
    }
    // MARK: - WelcomCoordinatorDelegate
    func welocmCoordinatorDidFinish(welcomCoordinator: WelcomCoordinator) {
        deleteCoordinator(targetCoordinator: welcomCoordinator)
    }
    func userDidLogin(welcomCoordinator: WelcomCoordinator, userName: String) {
        userDidLogin = true
        showBaseContentViewController()
    }
    
    // MARK: - PrivateMethod
    
    /// 显示app的登录或者登录后的页面
    func showBaseContentViewController(){
//        如果已经登录就进入内容
        if userDidLogin {
           
            let sceneCoordinator = SceneCoordinator(previousViewController: self.appRootViewController)
            sceneCoordinator.delegate = self;
            childCoordinators.append(sceneCoordinator)
            sceneCoordinator.startExecute()
            return ;
        }
        
      
        let welcomCoordinator = WelcomCoordinator(previousViewController: self.appRootViewController)
        welcomCoordinator.delegate = self
        childCoordinators.append(welcomCoordinator)
        welcomCoordinator.startExecute()
    }
    
    /// 移除子coordinator
    ///
    /// - Parameter targetCoordinator: 对应的coordinator
    func deleteCoordinator(targetCoordinator: RootCoordinator) {
        
        var i: Int?
        for j in 0..<childCoordinators.count {
            if childCoordinators[j] === targetCoordinator {
                i = j;
            }
        }
        if let index = i {
            childCoordinators.remove(at: index)
            
        }
    }
    // MARK: - SceneCoordinatorDelegate
    func didLogout(coordinator: SceneCoordinator) {
//        退出账号
        deleteCoordinator(targetCoordinator: coordinator)
        userDidLogin = false
        delegate?.reCreateAppCoordinator()
    }

    
}
