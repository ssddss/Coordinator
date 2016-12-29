//
//  ImageViewController.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        title = "首页"
        // Do any additional setup after loading the view.
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.red
        button.setTitle("登出", for: UIControlState.normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.addTarget(self, action: #selector(clickLogout), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        
        let button1: UIButton = UIButton(type: UIButtonType.custom)
        button1.backgroundColor = UIColor.red
        button1.setTitle("Next", for: UIControlState.normal)
        button1.frame = CGRect(x: 100, y: 300, width: 200, height: 100)
        button1.addTarget(self, action: #selector(self.pushNext(button:)), for: UIControlEvents.touchUpInside)
        view.addSubview(button1)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "appContentViewDidFinishLaunch"), object: nil)
    }
    // MARK: - event response
    func clickLogout() {
        
//        self.navigationController?.pushViewController(RootViewController(nibName: nil, bundle: nil), animated: true)
//        let delay = DispatchTime.now() + .seconds(7)
//
//        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LogoutNotification"), object: nil)
//        })
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LogoutNotification"), object: nil)

    }
    func pushNext(button: UIButton) {
        self.navigationController?.pushViewController(ImageViewController(nibName: nil, bundle: nil), animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
