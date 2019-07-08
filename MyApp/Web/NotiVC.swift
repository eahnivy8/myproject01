//
//  NotiVC.swift
//  MyApp
//
//  Created by xeozin on 30/06/2019.
//  Copyright © 2019 xeozin. All rights reserved.
//

import UIKit
import WebKit
import KRProgressHUD

class NotiVC: UIViewController {

    let webView:WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        loadRequest()
    }
    
    // 레이아웃 설정
    fileprivate func setupLayout() {
        self.view.backgroundColor = .lightGray
        
        // 오토리사이징을 사용하지 않겠다. (코드로 오토레이아웃을 만들겠다.)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
//        view.insertSubview(webView, at: 0)
        view.addSubview(webView)
        
        // #available (현재 iOS 가능 버전 확인)
        if #available(iOS 11.0, *) {
            // iOS 11 이상
            let safeArea = self.view.safeAreaLayoutGuide
            // leadingAnchor 왼쪽
            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            // topAnchor 위쪽
            webView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            // trailingAnchor 오른쪽
            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            // bottomAnchor 아랫쪽
            webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        } else {
            // iOS 11 이하
            // leadingAnchor 왼쪽
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            // topAnchor 위쪽
            webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            // trailingAnchor 오른쪽
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            // bottomAnchor 아랫쪽
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    // 웹 페이지 요청
    fileprivate func loadRequest() {
        let naver = "https://m.stock.naver.com/item/main.nhn#/stocks/035420/discuss" // naver 웹 URL
        let url = URL(string: naver)                // URL 문자열을 URL 객체로 변환
        if let naverURL = url {                     // 옵셔널 값을 일반 값으로 변환
            let req = URLRequest(url: naverURL)     // 만들어진 URL 객체로 URLRequest 객체 생성
            webView.load(req)                       // 웹 페이지 로드
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// 웹 브라우저 이동 처리
extension NotiVC : WKNavigationDelegate {
    
    // 시작점
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        KRProgressHUD.show()
    }
    
    // 종료
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        KRProgressHUD.dismiss()
    }
    
    // 실패
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        KRProgressHUD.dismiss()
    }
}

// 웹 브라우저의 UI 다시 로드할 때
extension NotiVC : WKUIDelegate {
    
}
