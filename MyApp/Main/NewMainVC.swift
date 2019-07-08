//
//  NewMainVC.swift
//  MyApp
//
//  Created by xeozin on 16/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit
import KRProgressHUD

class Gallary: Codable {
    let url:String
    let title:String
    let description:String
}

class NewMainVC: UIViewController {
    
    // 컬렉션 뷰
    @IBOutlet weak var colView: UICollectionView!
    
    // HTTP 주소 (HTTP, HTTPS)
    let urlString:String = "http://167.179.110.133:8080/xeozin/gallary"
    // 통신을 통해서 가져온 데이터
    var items:[Gallary]?
    // 컬럼을 2줄로 표현
    var col:CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colView.delegate = self     // 델리게이트 설정 (delegate)
        colView.dataSource = self   // 델리게이트 설정 (dataSource)
        
        getData()
        checkLogin()
    }
    
    func checkLogin() {
        let defaults = UserDefaults.standard
        
        if let name = defaults.string(forKey: "userName") {
            print(name)
        } else {
            print("로그인 필요")
            self.navigationController?.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }
    
    
    // 세그웨이 이동 준비
    // segue : 이동하는 선
    // sender : 선택된 셀
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            // 옵셔널 바인딩 (이동할 목적지가 NewMainDetailVC 가 맞는지 확인)
            if let vc:NewMainDetailVC = segue.destination as? NewMainDetailVC {
                // sender 를 UICollectionViewCell 변환
                let cell = sender as! UICollectionViewCell
                // 인덱스 패스를 구하는 함수에서 현재 선택된 셀의 인덱스를 가져옴
                let indexPath = self.colView.indexPath(for: cell)
                if let idx = indexPath?.row {
                    vc.item = items?[idx]
                }
            }
        }
    }
    
    // 화면을 다시 그릴때
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // 컬렉션 뷰의 FlowLayout 객체를 가져옴 (guard 실패하면 반환)
        guard let flowLayout = colView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        if UIDevice.current.orientation.isLandscape {   // 가로모드
            col = 5
        } else {    // 세로모드
            col = 2
        }
        
        flowLayout.invalidateLayout()
    }
    
    // 통신을 통한 데이터 전달
    func getData() {
        
        // url 데이터가 없으면 메서드(함수) 종료
        guard let url = URL(string: urlString) else {
            return
        }
        
        KRProgressHUD.show()
        
        // 통신 시도
        // data = 통신으로 가져온 데이터
        // res = 응답객체 (통신 정보)
        // err = 통신 실패 에러 객체
        URLSession.shared.dataTask(with: url) { data, res, err in
            if err != nil {
                print(err?.localizedDescription ?? "Error is empty")
            }
            
            // 통신 데이터가 없으면 메서드 종료
            guard let responseData = data else {
                return
            }
            
            do {
                let gallaryData = try JSONDecoder().decode([Gallary].self, from: responseData)
                
                // 비동기 통신
                DispatchQueue.main.async {
                    self.items = gallaryData
                    self.colView.reloadData()
                    
                    KRProgressHUD.dismiss() // 로딩바 제거
                }
            } catch let jsonError {
                print(jsonError)
                
                KRProgressHUD.dismiss() // 로딩바 제거
            }
            
            
            
        }.resume()
    }
    
    // 메뉴 버튼 눌림
    @IBAction func menu(_ sender: UIBarButtonItem) {
        // 메세지 발송
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
}

// 컬렉션 뷰의 델리게이트를 담당하는 extension (확장)
extension NewMainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GallaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NetCell", for: indexPath) as! GallaryCell
        
        if let item = self.items?[indexPath.row] {
            let imgURL = item.url    // 이미지 주소
            
            if let url = URL(string: imgURL) {
                cell.imageView.load(url: url)
            }
            
            cell.title.text = item.title
            cell.desc.text = item.description
        }
        
        return cell
    }
}

extension NewMainVC : UICollectionViewDelegateFlowLayout {
    // 아이템의 실제 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace:CGFloat = 10 * (col + 1)   // 30
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / col
        return CGSize(width: widthPerItem, height: 250)
    }
    
    // 아이템 간의 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
