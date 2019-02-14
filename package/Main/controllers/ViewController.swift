//
//  ViewController.swift
//  package
//
//  Created by Admin on 2019/2/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    
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

        self.hidesBottomBarWhenPushed = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func initNavi() {
        super.initNavi()
        self.showNavi = false
    }
    override func initUI() {
        super.initUI()
        
        
        let topView = PHTopFilterView.init()
        topView.datas = [UIButton.init().initialize(normalTitle: "地区", selectedTitle: nil, normalImg: nil, selectedImg: nil, normalTextColor: UIColor.phBlackText, selectedTextColor: UIColor.red, font: UIFont.phBig),
                         UIButton.init().initialize(normalTitle: "租金", selectedTitle: nil, normalImg: nil, selectedImg: nil, normalTextColor: UIColor.phBlackText, selectedTextColor: UIColor.red, font: UIFont.phBig),
                         UIButton.init().initialize(normalTitle: "户型", selectedTitle: nil, normalImg: nil, selectedImg: nil, normalTextColor: UIColor.phBlackText, selectedTextColor: UIColor.red, font: UIFont.phBig),
                         UIButton.init().initialize(normalTitle: "筛选", selectedTitle: nil, normalImg: nil, selectedImg: nil, normalTextColor: UIColor.phBlackText, selectedTextColor: UIColor.red, font: UIFont.phBig)
        ]
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Status_Height())
            make.left.width.equalToSuperview()
            make.height.equalTo(50)
        }
        topView.callBack = {index in

        }
        
    
        
        let tableView : UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        self.view.addSubview(tableView)
        tableView.register(BaseTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
    }
    
    
    
}

extension ViewController{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BaseTableViewCell
        cell.indexPath = indexPath
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let webvc : BaseWebViewController = BaseWebViewController()
//        webvc.webView.load(URLRequest.init(url: URL.init(string: "http://192.168.10.6:5000")!))
//        webvc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(webvc, animated: true)
        
        self.navigationController?.pushViewController(LocationViewController(), animated: true)
    }
    
}
