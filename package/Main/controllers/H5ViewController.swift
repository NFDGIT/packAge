//
//  H5ViewController.swift
//  package
//
//  Created by Admin on 2019/2/13.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class H5ViewController: BaseViewController {
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
    override func initUI() {
        super.initUI()
        
        self.showNavi = false
        
        
        //
        let topView = PHTabbarView.init()
        let btn = UIButton.init(normalTitle: "区域", normalImg: UIImage.init(named: "未选中"), selectedImg: UIImage.init(named: "选中"), normalTextColor: UIColor.phBlackText, selectedTextColor: UIColor.red,normalBgImg:UIImage.phInit(color: UIColor.white),selectedBgImg:UIImage.phInit(color: UIColor.phBgContent),font: UIFont.phMiddle)
        let btn1 = UIButton.init(normalTitle: "租金",  normalImg: UIImage.init(named: "未选中"), selectedImg: UIImage.init(named: "选中"), normalTextColor: UIColor.phBlackText, selectedTextColor: UIColor.red,normalBgImg:UIImage.phInit(color: UIColor.white),selectedBgImg:UIImage.phInit(color: UIColor.phBgContent),font: UIFont.phMiddle)
        let btn2 = UIButton.init(normalTitle: "户型",  normalImg: UIImage.init(named: "未选中"), selectedImg: UIImage.init(named: "选中"), normalTextColor: UIColor.phBlackText, selectedTextColor: UIColor.red,normalBgImg:UIImage.phInit(color: UIColor.white),selectedBgImg:UIImage.phInit(color: UIColor.phBgContent),font: UIFont.phMiddle)
        let btn3 = UIButton.init(normalTitle: "筛选",  normalImg: UIImage.init(named: "未选中"), selectedImg: UIImage.init(named: "选中"), normalTextColor: UIColor.phBlackText, selectedTextColor: UIColor.red,normalBgImg:UIImage.phInit(color: UIColor.white),selectedBgImg:UIImage.phInit(color: UIColor.phBgContent),font: UIFont.phMiddle)
        
        topView.datas = [btn,
                         btn1,
                         btn2,
                         btn3
        ]
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Status_Height())
            make.left.width.equalToSuperview()
            make.height.equalTo(40)
        }
        topView.callBack = {index in
            
        }
        for (index,item) in (topView.datas?.enumerated())! {
            item.phImagePosition(at: index % 2 == 0 ? .left : .right, space: 10)
        }
        
        
        let webView : BaseWebView = BaseWebView.init()
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }

        webView.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com")!))
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
     return UIStatusBarStyle.default
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
