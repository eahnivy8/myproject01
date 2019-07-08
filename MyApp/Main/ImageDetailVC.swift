//
//  ImageDetailVC.swift
//  MyApp
//
//  Created by xeozin on 22/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit

class ImageDetailVC: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeScrollView()
    }
    
    func makeScrollView() {
        // 가로, 세로 사이즈
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        // 스크롤 뷰 생성
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: w, height: h)
        scrollView.backgroundColor = .black
        scrollView.alwaysBounceVertical = false         // Bounce 동작 제거 (상하)
        scrollView.alwaysBounceHorizontal = false       // Bounce 동작 제거 (좌우)
        scrollView.showsVerticalScrollIndicator = false // 높이 스크롤바를 제거
        scrollView.flashScrollIndicators()
        
        scrollView.minimumZoomScale = 1.0       // 최소 사이즈 (원본)
        scrollView.maximumZoomScale = 10.0      // 10 배
        
        scrollView.delegate = self  // 델리게이트
        
        if let img = self.imageView {
            img.center = CGPoint(x: view.center.x, y: view.center.y - 100)
            scrollView.addSubview(img)
        }
        
        self.view.addSubview(scrollView)
    }
    
    // 스크롤 뷰 Zoom (UIScrollViewDelegate)
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
