//
//  Menu5VC.swift
//  MyApp
//
//  Created by xeozin on 07/07/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

//    var items: [MapInfo] = [MapInfo(name: "강남지점", lat: 37.504081, lon: 127.035156),
//                            MapInfo(name: "대구지점", lat: 35.866286, lon: 128.586489),
//                            MapInfo(name: "광주지점", lat: 35.148106, lon: 126.917606),
//                            MapInfo(name: "부산지점", lat: 35.152325, lon: 129.059269)]



import UIKit
import MapKit

// [ struct ]
// 1. 클래스와 비슷함
// 2. 값 타입
// 3. 클래스와 다르게 상속이 안됨

// class [기능이 포함된 타입] : 값을 참조   (메모리를 적게 씀)
// struct [단순 데이터를 정의하는 타입] : 값을 복사 (메모리를 조금 더 많이 씀)
struct MapInfo {
    var name:String // 지점이름
    var lat:Double  // 위도
    var lon:Double  // 경도
}

// 대리기사 (델리게이터 : 위임자)
class Menu5VC: BaseMenuVC {
    
    // 테이블 뷰 (대리기사 부른)
    @IBOutlet weak var tableView: UITableView!
    
    var items: [MapInfo] = [MapInfo(name: "강남지점", lat: 37.504081, lon: 127.035156),
                            MapInfo(name: "대구지점", lat: 35.866286, lon: 128.586489),
                            MapInfo(name: "광주지점", lat: 35.148106, lon: 126.917606),
                            MapInfo(name: "부산지점", lat: 35.152325, lon: 129.059269)]
    
    // 한 번만 실행됨
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "지점안내"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // 세그웨이 이동함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let con:MapVC = segue.destination as! MapVC
        
        if let selectedItemIndex = tableView.indexPathForSelectedRow {
            let item = items[selectedItemIndex.row]
            con.loc = CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon)
            con.title = item.name
        }
    }
    
}

extension Menu5VC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        let item:MapInfo = items[indexPath.row] // 0, 1, 2, 3 (총 4회)
        cell.textLabel?.text = item.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .ultraLight)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
