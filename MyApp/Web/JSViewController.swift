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

class JSViewController: UIViewController, WKScriptMessageHandler {
    
    var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createWebView()         // 1. 웹 뷰 생성 (자바스크립트 컨트롤 객체 생성)
        setupLayout()           // 2. 레이아웃 설정
        loadFile()              // 3. 파일 로드
    }
    
    // 자바스크립트 핸들러
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name, message.body)
        if message.name == "callbackHandler" {
            if message.body as! String == "CLOSE" {
                dismiss(animated: true, completion: nil)
            } else if message.body as! String == "CAMERA" {
                // 카메라 뷰 컨트롤러 호출
            } else {
                let alert = UIAlertController(title: "알림", message: message.body as? String, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // 레이아웃 설정
    fileprivate func createWebView() {
        // contentController 생성 (자바스크립트와 연결점)
        let contentController = WKUserContentController()       // 생성
        let config = WKWebViewConfiguration()                   // 설정 객체 생성
        
        // 1. 자바스크립트 호출
        let userScript = WKUserScript(source: "redHeader()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        contentController.addUserScript(userScript)             // 직접 생성한 UserScript 등록
        
        // 2. 자바스크립트 이벤트 대기
        contentController.add(self, name: "callbackHandler")
        config.userContentController = contentController
        
        webView = WKWebView(frame: self.view.frame, configuration: config)  // config == 자바스크립트 컨트롤 객체
    }
    
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
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// HTML 요청 방법
// 1. URL 을 통한 로드
// 2. HTML 문자열을 통한 로드
// 3. File 을 통한 로드
extension JSViewController {
    // 웹 페이지 요청
    fileprivate func loadRequest() {
        let naver = "https://m.stock.naver.com/item/main.nhn#/stocks/035420/discuss" // naver 웹 URL
        let url = URL(string: naver)                // URL 문자열을 URL 객체로 변환
        if let naverURL = url {                     // 옵셔널 값을 일반 값으로 변환
            let req = URLRequest(url: naverURL)     // 만들어진 URL 객체로 URLRequest 객체 생성
            webView.load(req)                       // 웹 페이지 로드
        }
    }
    
    // HTML 로드
    fileprivate func loadHTML() {
        let html = """
            <html>
                <body>
                    <h1>Hello, World</h1>
                </body>
            </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    fileprivate func loadFile() {
        let htmlPath = Bundle.main.path(forResource: "test", ofType: "html")
        guard let path = htmlPath else { return }
        let htmlURL = URL(fileURLWithPath: path, isDirectory: false)
        webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
    }
}

// 웹 브라우저 이동 처리
extension JSViewController : WKNavigationDelegate {
    
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
extension JSViewController : WKUIDelegate {
    
}
