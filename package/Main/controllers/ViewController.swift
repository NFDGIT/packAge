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


        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func initNavi() {
        super.initNavi()
     
        self.title = "首页"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "位置", style: UIBarButtonItemStyle.done, target: self, action: #selector(rightBtn))
    
    }
    
    
    
    override func initUI() {
        super.initUI()
        
        let tableView : UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        self.view.addSubview(tableView)
        tableView.register(BaseTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.bottom.right.equalToSuperview()
        }
  
  
    }
    
    @objc func rightBtn(){
       self.navigationController?.pushViewController(LocationViewController(), animated: true)
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
        
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
}
