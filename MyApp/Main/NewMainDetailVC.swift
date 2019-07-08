//
//  NewMainDetailVC.swift
//  MyApp
//
//  Created by xeozin on 22/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

class NewMainDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var dateSelector: UITextField!
    @IBOutlet weak var teacherSelector: UITextField!
    
    var pickOption = ["김태희", "강동원", "손예진", "권상우"]
    
    var item:Gallary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapEvent()
        
        load()
        addDatePicker()
        addTeacherPicker()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowImageSegue" {
            if let vc = segue.destination as? ImageDetailVC {
                vc.imageView = UIImageView(image: self.imgView.image)
                vc.title = self.titleLabel.text
            }
        }
    }
    
    func addTapEvent() {
        // 텝 제스쳐 생성
        // tap 메서드에 연결
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        
        // 뷰 제스쳐 연결
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap() {
        teacherSelector.resignFirstResponder()
        dateSelector.resignFirstResponder()
    }
    
    // 데이트(Date) 픽커
    func addDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dateSelector.inputView = datePicker
        datePicker.addTarget(self, action: #selector(updateDateField(_ :)), for: .valueChanged)
    }
    
    @objc func updateDateField(_ sender: UIDatePicker) {
        print(sender.date)
        
        // 날짜를 문자열로 바꿔주는 객체
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: sender.date)
        dateSelector.text = dateString
    }
    
    // 데이터(Data) 픽커
    func addTeacherPicker() {
        let teacherPicker = UIPickerView()
        teacherPicker.delegate = self
        teacherPicker.dataSource = self
        
        teacherSelector.inputView = teacherPicker
    }
    
    // 컬럼 반환 (1)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 로우 갯수 (4)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    // 아이템 타이틀 반환
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    // 선택 되었을 때
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        teacherSelector.text = pickOption[row]
    }
    
    // 접근 제한자
    // open, public, internal(기본값), private, fileprivate
    private func load() {
        // 옵셔널 바인딩
        if let obj = item {
            titleLabel.text = obj.title
            descLabel.text = obj.description
            let imgURL = URL(string: obj.url)!
            imgView.load(url: imgURL)
        }
    }
    
    @IBAction func save() {
        // 네비게이션 컨트롤러 Back
        self.navigationController?.popViewController(animated: true)
    }
}
