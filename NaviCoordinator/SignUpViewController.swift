//
//  SignUpViewController.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/27.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import UIKit

protocol SignUpViewControllerDelegate: class {
    func didSignUp()
    func signUpPop()
}
class SignUpViewController: UIViewController {

    public weak var delegate: SignUpViewControllerDelegate?
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
        view.backgroundColor = UIColor.blue
        
        // Do any additional setup after loading the view.
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.red
        button.setTitle("注册", for: UIControlState.normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.addTarget(self, action: #selector(signUp), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        
        let button1: UIButton = UIButton(type: UIButtonType.custom)
        button1.backgroundColor = UIColor.red
        button1.setTitle("手动Pop", for: UIControlState.normal)
        button1.frame = CGRect(x: 100, y: 300, width: 200, height: 100)
        button1.addTarget(self, action: #selector(self.manualPop), for: UIControlEvents.touchUpInside)
        view.addSubview(button1)

    }
    // MARK: - event response
    func signUp() {
        delegate?.didSignUp()
    }
    func manualPop() {
        delegate?.signUpPop()
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
