//
//  IntroVC.swift
//  MyApp
//
//  Created by xeozin on 29/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit
import KRProgressHUD

class IntroVC: UIViewController {
    @IBOutlet weak var leftCar: UIImageView!
    @IBOutlet weak var rightCar: UIImageView!
    
    var leftFrame:CGRect!
    var rightFrame:CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPosition()
        showProgress()
    }
    
    // 최초 포지션을 설정
    func initPosition() {
        leftFrame = leftCar.frame
        rightFrame = rightCar.frame
        
        self.leftCar.frame =  CGRect(x: 83, y: 330, width: leftFrame.width, height: leftFrame.height)
        self.rightCar.frame = CGRect(x: 420, y: 250, width: rightFrame.width, height: rightFrame.height)
    }
    
    func showProgress() {
        KRProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // 1초 뒤에 실행
            KRProgressHUD.dismiss {
                self.moveCar()
            }
        }
    }
    
    func moveCar() {
        print("차 이동 시작")
        
        // 알파값, 크기, 좌표
        UIView.animate(withDuration: 0.6, delay: 0.2, options: .curveEaseInOut,
                       animations: {
            self.leftCar.frame =  CGRect(x: 16, y: 133, width: self.leftFrame.width, height: self.leftFrame.height)
            self.rightCar.frame = CGRect(x: 234, y: 15, width: self.rightFrame.width, height: self.rightFrame.height)
        }) { b in
            print("차 이동 종료")
        }
    }
    
}
