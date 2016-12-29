//
//  ADDetailViewController.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import UIKit
protocol ADDetailViewControllerDelegate: class {
    func didReadAdDetail(detailVC: ADDetailViewController)
}
class ADDetailViewController: UIViewController {

    public weak var delegate: ADDetailViewControllerDelegate?
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "广告内容"
        view.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view.
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.red
        button.setTitle("广告内容已阅读", for: UIControlState.normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.addTarget(self, action: #selector(didReadAD), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
    }
    // MARK: - event response
    func didReadAD() {
        delegate?.didReadAdDetail(detailVC: self)
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
