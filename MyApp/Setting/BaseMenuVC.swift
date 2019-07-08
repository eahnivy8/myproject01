//
//  BaseMenuVC.swift
//  MyApp
//
//  Created by xeozin on 07/07/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

class BaseMenuVC: UIViewController {
    
    var name:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = name
        
        self.view.backgroundColor = .red
    }
    
    // 화면이 보일 때마다 호출
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }

}
