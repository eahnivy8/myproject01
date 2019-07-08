//
//  MainDetailVC.swift
//  MyApp
//
//  Created by xeozin on 23/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

class MainDetailVC: UIViewController {
    
    var item:SBS?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let sbs = item {
            
            // 이미지 설정
            if let imgData = sbs.image {
                imageView.image = UIImage(data: imgData)
            }
            
            // 텍스트 설정
            if let dateData = sbs.date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM월 dd, yyyy"
                timeLabel.text = formatter.string(from: dateData)
            }
            
            titleLabel.text = sbs.article
        }
        
        
    }
}
