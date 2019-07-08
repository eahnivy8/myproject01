//
//  ContainerVC.swift
//  MyApp
//
//  Created by xeozin on 15/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    @IBOutlet weak var menuConst: NSLayoutConstraint!
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    // 메시지 수신 메서드(함수)
    @objc func toggleSideMenu() {
        print("OK 수신 완료")
        
        if sideMenuOpen {   // true
            menuConst.constant = -240
            sideMenuOpen = false
        } else {            // false
            menuConst.constant = 0
            sideMenuOpen = true
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

}
