//
//  LoginVC.swift
//  MyApp
//
//  Created by xeozin on 23/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 키보드 포커싱
        idTextField.becomeFirstResponder()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true) {
            // code...
        }
    }
    
    @IBAction func enter(_ sender: UITextField) {
        if sender == idTextField {
            passTextField.becomeFirstResponder()
        } else if sender == passTextField {
            passTextField.resignFirstResponder()
            login()
        }
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        login()
    }
    
    func showErrorPopup() {
        print("HELLO")
    }
    
    func login() {
        
        // idTextField에 문자열 길이를 가져옴
        guard let idCount = idTextField.text?.count else {
            return
        }
        
        // passTextField에 문자열 길이를 가져옴
        guard let pwCount = passTextField.text?.count else {
            return
        }
        
        if idCount > 0, pwCount > 0 {
            dismiss(animated: true) {
                let defaults = UserDefaults.standard    // 시스템 저장
                defaults.set(self.idTextField.text, forKey: "userName")
                defaults.set(self.passTextField.text, forKey: "userPass")
                defaults.synchronize()  // 동기화
            }
        } else {
            let errorPopup = UIAlertController(title: "확인", message: "아이디 또는 패스워드를 확인해주세요.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            errorPopup.addAction(okAction)
            
            present(errorPopup, animated: true, completion: nil)
        }
    }
    
}
