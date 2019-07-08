//
//  RootNC.swift
//  MyApp
//
//  Created by xeozin on 23/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

class RootNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
    }
    
    // 이벤트 등록
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showNoti), name: NSNotification.Name("Noti"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeRoot(_ :)), name: NSNotification.Name("ChangeRoot"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSetting), name: NSNotification.Name("Setting"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showLogout), name: NSNotification.Name("Logout"), object: nil)
    }
    
    // 공지사항 노출
    @objc func showNoti() {
        performSegue(withIdentifier: "NotiSegue", sender: nil)
    }
    
    // 메인화면을 변경
    @objc func changeRoot(_ notification: Notification) {
        if let changeType: String = notification.object as? String {
            print("CHANGE ROOT \(changeType)")
            
            // 스토리보드에서 ID 를 기준으로 뷰 컨트롤러를 생성
            let vc = storyboard?.instantiateViewController(withIdentifier: changeType)
            
            // 옵셔널 바인딩으로 뷰 컨트롤러가 nil 이 아닌지 확인
            if let viewController = vc {
                // 네비게이션 컨트롤러에 루트 뷰 컨트롤러를 설정 [] 배열구조
                self.setViewControllers([viewController], animated: false)
            }
         }
    }
    
    // 설정창 노출
    @objc func showSetting() {
        performSegue(withIdentifier: "SettingSegue", sender: nil)
    }
    
    // 로그아웃창 노출
    @objc func showLogout() {
        
        let logout = NSLocalizedString("LOGOUT", comment: "")
        let logoutMsg = NSLocalizedString("LOGOUT_MSG", comment: "")
        let comfirm = NSLocalizedString("CONFIRM", comment: "")
        let cancel = NSLocalizedString("CANCLE", comment: "")
        
        let alertView = UIAlertController(title: logout, message: logoutMsg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: comfirm, style: .default) { _ in
            let defaults = UserDefaults.standard
            
            if let name = defaults.string(forKey: "userName") {
                print(name)                                 // 이름 출력 테스트
                defaults.removeObject(forKey: "userName")   // 유저 정보 삭제
                defaults.synchronize()                      // 동기화
            }
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
        let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: nil)
        
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        
        self.present(alertView, animated: true, completion: nil)
    }
}
