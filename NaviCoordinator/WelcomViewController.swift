//
//  WelcomViewController.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import UIKit

protocol WelcomViewControllerDelegate: class {
    func finishShowWelcome()
    func loginButtonClick()
    func signUpButtonClick()
}
class WelcomViewController: UIViewController {

    public weak var delegate: WelcomViewControllerDelegate?
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "欢迎"
        view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
//        let delay = DispatchTime.now() + .seconds(3)
//
//        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
//            self.delegate?.finishShowWelcome()
//        })
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.red
        button.setTitle("点击登录", for: UIControlState.normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.addTarget(self, action: #selector(clickLogin), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        
        let signbutton: UIButton = UIButton(type: UIButtonType.custom)
        signbutton.backgroundColor = UIColor.red
        signbutton.setTitle("注册", for: UIControlState.normal)
        signbutton.frame = CGRect(x: 100, y: 160, width: 200, height: 50)
        signbutton.addTarget(self, action: #selector(clickSignUp), for: UIControlEvents.touchUpInside)
        view.addSubview(signbutton)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "appContentViewDidFinishLaunch"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: - event response
    func clickLogin() {
        self.delegate?.loginButtonClick()
    }
    func clickSignUp() {
        delegate?.signUpButtonClick()
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
