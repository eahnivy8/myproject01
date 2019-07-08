//
//  MenuVC.swift
//  MyApp
//
//  Created by xeozin on 15/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfile()
    }
    
    // 프로필 로드
    func loadProfile() {
        drawLabel()
        drawImage()
    }
    
    func drawLabel() {
        // 사용자 아이디 노출
        let defaults = UserDefaults.standard    // 로컬 저장 변수 클래스
        if let name = defaults.string(forKey: "userName") {
            let welcome = NSLocalizedString("WELCOME", comment: " 님 환영합니다.")    // 다국어 적용 문자열 가져옴
            self.profileLabel.text = "\(name)\(welcome)"
        }
        
    }
    
    func drawImage() {
        let urlString = "https://s-i.huffpost.com/gen/5532558/images/n-WOMAN-HEAD-628x314.jpg"
        if let url = URL(string: urlString) {
            profileImage.contentMode = .scaleAspectFill
            profileImage.load(url: url)
            
            roundImage(image: profileImage)
        }
    }
    
    func roundImage(image: UIImageView) {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 프로필은 제외한 메뉴를 호출
        if indexPath.row > 0 {
            NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        }
        
        print("선택된 셀 row \(indexPath.row)")
        
        switch indexPath.row {
        case 0:tableView.deselectRow(at: indexPath, animated: false)
        case 1:NotificationCenter.default.post(name: NSNotification.Name("Noti"), object: nil)
        case 2:NotificationCenter.default.post(name: NSNotification.Name("ChangeRoot"), object: "NewMain")
        case 3:NotificationCenter.default.post(name: NSNotification.Name("ChangeRoot"), object: "Main")
        case 4:NotificationCenter.default.post(name: NSNotification.Name("Setting"), object: nil)
        case 5:NotificationCenter.default.post(name: NSNotification.Name("Logout"), object: nil)
        default:print("메뉴가 없습니다.")
            
        }
    }
    
}
