//
//  SettingMainVC.swift
//  MyApp
//
//  Created by xeozin on 06/07/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var count: UILabel!
}

class SettingMainVC: UIViewController {
    @IBOutlet weak var versionLabel: UILabel!
    
    // 배열[딕셔너리, 딕셔너리] 데이터 선언
    var settingItems: Array<[String:String]> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func addItems() {
        settingItems.removeAll() // 초기화
        settingItems.append(["title":"프로필수정", "count":"0"])  // 딕셔너리 값 추가 ["키":"값"]
        settingItems.append(["title":"수강신청과목", "count":"3"])
        settingItems.append(["title":"출석일수", "count":"20"])
        settingItems.append(["title":"인증방법", "count":"2"])
        settingItems.append(["title":"지점안내", "count":"5"])
    }
    
    // 창 닫기
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // 회원탈퇴 버튼 이벤트
    @IBAction func leave(_ sender: Any) {
        print("탈퇴 기능")
    }
    
    // FAQ 버튼 이벤트
    @IBAction func faq(_ sender: Any) {
        print(("FAQ 기능"))
    }
}

extension SettingMainVC: UITableViewDataSource, UITableViewDelegate {
    
    // 갯수를 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingItems.count   // 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPath.row indexPath.section
        // 0, 1, 2, 3, 4
        // 좋지 않은 방법 (셀을 계속 재생성)
//        let cell = UITableViewCell()
//        cell.textLabel?.text = settingItems[indexPath.row]["title"]
        
        // 셀의 재사용 (dequeueReusableCell 메서드를 이용해서 재사용이 가능해짐)
        
        print(indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SettingCell
        
        let item = settingItems[indexPath.row]  // 아이템
        
        // 타이틀 표시
        cell.title.text = item["title"]
        
        // 옵셔널 바인딩 (cnt 값은 확실히 보장)
        if let cnt = item["count"] {
            if cnt == "0" {
                // 갯수 "0" 이면 count 라벨을 히든
                cell.count.isHidden = true
            } else {
                // 갯수 표시
                let cntString:String = "\(cnt) 개"
                cell.count.text = cntString
            }
        }
        
        return cell
    }
    
    // 테이블뷰 ROW 크기 반환  -> CGFloat
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.section, indexPath.row, settingItems[indexPath.row])
        
        let sb = UIStoryboard(name: "Setting", bundle: Bundle.main)         // Setting 스토리보드 객체 생성
        let item = settingItems[indexPath.row]
        
        if item["title"] == "프로필수정" {
            let vc = sb.instantiateViewController(withIdentifier: "Menu1")  // 스토리보드 ID로 뷰컨트롤러 생성
            navigationController?.pushViewController(vc, animated: true)    // 네비게이션 컨트롤러 푸시
        } else if item["title"] == "수강신청과목" {
            let vc = sb.instantiateViewController(withIdentifier: "Menu2")
            navigationController?.pushViewController(vc, animated: true)
        } else if item["title"] == "출석일수" {
            let vc = sb.instantiateViewController(withIdentifier: "Menu3")
            navigationController?.pushViewController(vc, animated: true)
        } else if item["title"] == "인증방법" {
            let vc = sb.instantiateViewController(withIdentifier: "Menu4")
            navigationController?.pushViewController(vc, animated: true)
        } else if item["title"] == "지점안내" {
            let vc = sb.instantiateViewController(withIdentifier: "Menu5")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
