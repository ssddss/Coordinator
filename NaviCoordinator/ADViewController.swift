//
//  ADViewController.swift
//  NaviCoordinator
//
//  Created by yurongde on 2016/12/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

import UIKit
protocol ADViewControllerDelegate: class {
    func adDidShow(adVC: ADViewController)
    func showTargetAD(adVC: ADViewController, name: String)
}
class ADViewController: UIViewController {

    public weak var delegate: ADViewControllerDelegate?
    private var timer: Timer?
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "广告"
        view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
        let button: UIButton = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.red
        button.setTitle("查看广告", for: UIControlState.normal)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        button.addTarget(self, action: #selector(clickAD), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.finishShowAD), userInfo: nil, repeats: false)
    }

    // MARK: - event response
    func clickAD() {
        timer?.invalidate()
        self.delegate?.showTargetAD(adVC: self, name: "google")
    }
    // MARK: - private
    // MARK: - timer
    func finishShowAD() -> Void {

        self.delegate?.adDidShow(adVC: self)
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
