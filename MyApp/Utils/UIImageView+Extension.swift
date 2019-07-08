//
//  UIImageView+Extension.swift
//  MyApp
//
//  Created by xeozin on 22/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

// 클래스 확장 (extension)
// Apple 클래스 UIImageView 기능을 추가하는 행위
extension UIImageView {
    func load(url: URL) {
        
        // 비동기 처리
        DispatchQueue.global().async { [weak self] in
            // 데이터를 받아오는 과정 (옵셔널 바인딩)
            if let data = try? Data(contentsOf: url) {
                // 데이터를 이미지화 하는 과정 (옵셔널 바인딩)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
        
    }
}
