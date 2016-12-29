//
//  UniversialLinkOrNotificationViewController.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/28.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import UIKit

protocol UniversialLinkOrNotificationViewControllerDelegate: class {
    func didReadUniversialOrNotificationDetail(detailVC: UniversialLinkOrNotificationViewController)
}
class UniversialLinkOrNotificationViewController: UIViewController {

    public weak var delegate: UniversialLinkOrNotificationViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "通用链接/通知"
        view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.red
        button.setTitle("通用链接/通知-已阅读", for: UIControlState.normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.addTarget(self, action: #selector(didReadAD), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
    }
    // MARK: - event response
    func didReadAD() {
        delegate?.didReadUniversialOrNotificationDetail(detailVC: self)
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
