//
//  MeViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class MeViewController: BaseViewController {
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        
        self.title = "我的"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "设置", style: UIBarButtonItemStyle.done, target: self, action: #selector(setBtnClick))
        
    }

    override func initUI() {
        super.initUI()
        let itemValues : [(String)] = [("清除缓存"),("去评价"),("关于我们")]
        
        
        var temView : UIView?
        for (index,itemvalue) in itemValues.enumerated() {
            let btn : UIButton = UIButton.init(normalTitle: itemvalue, normalTextColor: UIColor.phBlackText, font: UIFont.phMiddle)
            btn.contentHorizontalAlignment = .left
            btn.phImagePosition(at: .left, space: SCALE(size: 20))
            self.view.addSubview(btn)
            btn.backgroundColor = UIColor.white
            
            btn.snp.makeConstraints { (make) in
                make.top.equalTo(temView == nil ? SCALE(size: 100) : (temView?.snp.bottom)!).offset(10)
                make.left.right.equalToSuperview()
                make.height.equalTo(SCALE(size: 60))
            }
            
            let imgArrow = UIImageView.init(image: UIImage.init(named: "arrow"))
            btn.addSubview(imgArrow)
            imgArrow.contentMode = .center
            imgArrow.snp.makeConstraints { (make) in
                make.width.height.equalTo(30)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(SCALE(size: -10))
            }
            
            
            temView = btn
            if index == 0
            {
                btn.phAddTarget(events: .touchUpInside) { (sender) in
//                    self.view.makeToast("\(PHTool.getCacheSize())",position:.center)
                    
                    self.view.makeToastActivity(.center)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                        PHTool.removeCache(callBack: { (success) in
                            self.view.makeToast("清除成功",position:.center)
                            self.view.hideToastActivity()
                        })
                    })
                    
     
                }
                
                
            }
            if index == 1
            {
                btn.phAddTarget(events: .touchUpInside) { (sender) in
                    let url = URL.init(string: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=\("1454804219")")
                    UIApplication.shared.openURL(url!)
                }

                
            }
            if index == 2
            {
                btn.phAddTarget(events: .touchUpInside) { (sender) in
                    let webVC = PHBaseWebViewController.init()
           
                    let fileURL =  Bundle.main.url(forResource: "aboutus", withExtension: "html" )
                    webVC.webView.loadFileURL(fileURL!,allowingReadAccessTo:Bundle.main.bundleURL);
                    webVC.navigationItem.title = "关于我们"
                    
                    
                    self.view.makeToastActivity(.center)
                    Request.getAboutUs(response: { (success, msg, data) -> (Void) in
                        self.view.hideToastActivity()
                        if success {
                            let letus : Dictionary<String,Any> = data["letus"] as! Dictionary<String,Any>
                            var content : String = letus["letus_content"] as! String
                            content = """
                                          龙之美装饰是一家装修设计公司，专业提供精美设计方案<br/>
                                          设计行业领航者
                                      """
                            
                            
                            webVC.webView.loadHTMLString(self.getAboutus(content: content), baseURL: nil)
                            self.navigationController?.pushViewController(webVC, animated: true)
                        }else{
                            self.view.makeToast(msg,position:.center)
                        }
       
                    })
              
                    
        
//                    webVC.webView.load(URLRequest.init(url:URL.init(string: "https://www.baidu.com")!))
                    
                    
                    
                  
                }
            }
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MeViewController{
    @objc func setBtnClick() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    func getAboutus(content:String) -> String {
        return """
        <html>
        <head>
        <title>关于我们</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        </head>
        <body>
        </br>
        <div  style="text-align:center;text-color:orange">
        \(content)
        </div>
        </body>
        </html>
        """
    }
}
