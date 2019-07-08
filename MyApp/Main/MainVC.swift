//
//  MainVC.swift
//  MyApp
//
//  Created by xeozin on 15/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 테이블 뷰 아이템 (저장된 데이터베이스 값)
    var sbs = [SBS]()
    
    // 데이터베이스 객체
    var moc:NSManagedObjectContext!
    
    // 셀 갯수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sbs.count
    }
    
    // 셀 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatabaseCell", for: indexPath) as! ItemCell
        
        let item = sbs[indexPath.row] // 현재 해당 셀의 데이터
        
        cell.itemTitle.text = item.article   // 제목
        cell.timeText.text = item.time       // 시간 (평일반/주말반)
        
        // 이미지 할당
        if let data = item.image {
            if let img = UIImage(data: data) {
                cell.img.image = img
            }
        }
        
        // Date 할당
        let dateFormatter = DateFormatter()
        // Date 포맷 생성
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        // date 옵셔널 바인딩
        if let date = item.date {
            // 문자열 생성
            let dateString = dateFormatter.string(from: date)
            cell.dateText.text = dateString
        }
        
        return cell
    }
    
    // 셀 높이 반환
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    @IBOutlet weak var itemTableView: UITableView!
    
    // 시작점
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 델리게이트 설정
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        // 앱 델리게이트 객체
        let appDel = UIApplication.shared.delegate as! AppDelegate
        moc = appDel.persistentContainer.viewContext
        
        // 데이터 로드
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMainDetail" {
            // 옵셔널 바인딩
            if let vc:MainDetailVC = segue.destination as? MainDetailVC {
                let cell = sender as! UITableViewCell               //  현재 선택된 셀
                let indexPath = self.tableView.indexPath(for: cell) //  인덱스 패스 반환
                if let idx = indexPath?.row {
                    vc.item = self.sbs[idx]                         // 선택된 셀의 데이터를 전달
                }
            }
        }
    }
    
    // 데이터 로드 함수
    func loadData() {
        let sbsRequest:NSFetchRequest<SBS> = SBS.fetchRequest()
        do {
            sbs = try moc.fetch(sbsRequest)
            self.tableView.reloadData()
        } catch {
            print("error \(error)")
        }
    }
    
    // 메뉴 버튼 눌림
    @IBAction func menu(_ sender: UIBarButtonItem) {
        // 메세지 발송
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    // 아이템 추가
    @IBAction func addItem(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // 이미지 선택 취소
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 선택
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // if let 옵셔널 바인딩
        // as? 형변환
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            picker.dismiss(animated: true) {
                self.createItem(img: image)
            }
        }
        
    }
    
    // 데이터 베이스 저장
    func createItem(img: UIImage) {
        let alertView = UIAlertController(title: "수강신청", message: "강의 정보를 입력하세요.", preferredStyle: .alert)
        
        alertView.addTextField { textField in
            textField.placeholder = "신청과목"
        }
        
        alertView.addTextField { textField in
            textField.placeholder = "평일반/주말반"
        }
        
        // 저장 코드...
        let saveAction = UIAlertAction(title: "저장", style: .default) { action in
            let articleTextField = alertView.textFields?.first
            let timeTextField = alertView.textFields?.last
            
            if articleTextField?.text != "" && timeTextField?.text != "" {
                // SBS 데이터베이스 객체 생성
                let item = SBS(context: self.moc)
                item.image = img.jpegData(compressionQuality: 0.3)
                item.article = articleTextField?.text
                item.time = timeTextField?.text
                item.date = Date()  // 현재시간
                
                // 에러 검출
                do {
                    try self.moc.save() // 실제 데이터베이스에 저장하는 메서드
                } catch {
                    print("저장 실패 \(error.localizedDescription)")
                }
                
                self.loadData() // 데이터 다시 로드
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { action in
            print("저장 취소됨")
        }
        
        alertView.addAction(saveAction)
        alertView.addAction(cancelAction)
        
        self.present(alertView, animated: true, completion: nil)
    }
}
