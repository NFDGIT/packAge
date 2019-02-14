//
//  BaseWebView.swift
//  package
//
//  Created by Admin on 2019/2/13.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import WebKit

class BaseWebView: WKWebView,WKNavigationDelegate,WKUIDelegate {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame:CGRect) {
        let config : WKWebViewConfiguration = WKWebViewConfiguration()
        config.userContentController = WKUserContentController.init()
        
        let preferences : WKPreferences = WKPreferences.init()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        //        preferences.minimumFontSize = 30
        config.preferences = preferences
        
        super.init(frame: frame, configuration: config)
        
       self.initData()
    }
    init() {
        let config : WKWebViewConfiguration = WKWebViewConfiguration()
        config.userContentController = WKUserContentController.init()
        
        let preferences : WKPreferences = WKPreferences.init()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        //        preferences.minimumFontSize = 30
        config.preferences = preferences
        
        super.init(frame: CGRect.zero, configuration: config)
       self.initData()

    }
    func initData()  {
        self.navigationDelegate = self
        self.uiDelegate = self

    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension BaseWebView{
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.performDefaultHandling,nil)
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
