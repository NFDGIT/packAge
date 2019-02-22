//
//  FindViewController.swift
//  package
//
//  Created by Admin on 2019/2/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class FindViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    let tableView : UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
    
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
        self.refreshData()
    }
    override func initNavi() {
        super.initNavi()
        
        self.navigationItem.title  = "找司仪"
        
    }
    func initData(){
        
        
    }
    func refreshData() {
        Request.getUsers(pageNum: 1) { (success, msg, data) -> (Void) in
            if success {
                for item in data {
                    let model : UserInfo = UserInfo.init(dic: item as! Dictionary<String, Any>)
                    self.tableView.datas.append(model)
                    
                }
                self.tableView.reloadData()
            }
            
  
            

        }

        
        

    }
    override func initUI() {
        super.initUI()
        
        
        let itemvalues : [(title:String,url:String)] = [("省份",""),("档期",""),("价格","")]
        let layoutView = PHLayoutView.init()
        
        self.view.addSubview(layoutView)
        layoutView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(50)
        }
        layoutView.layout.direction = .horizontal
        
        layoutView.numberOfCell = {
            return itemvalues.count
        }
        layoutView.cellForIndex = {index in
            let item = itemvalues[index]
            
            let btn = UIButton.init(normalTitle: item.title, normalImg:UIImage.init(named: "选中"), normalTextColor: UIColor.phBlackText , font: UIFont.phMiddle)
            return btn
        }
        layoutView.reload()
        
        for item in layoutView.subviews {
            (item as! UIButton).phImagePosition(at: .right, space: SCALE(size: 5))
        }
        layoutView.selectedCell = {index in
            if index == 0 {
                self.navigationController?.pushViewController(LocationViewController(), animated: true)
            }
            if index == 1 {
                self.navigationController?.pushViewController(DateViewController(), animated: true)
            }
            if index == 2 {
                self.navigationController?.pushViewController(PriceListViewController(), animated: true)
            }
        }
        
        
        
        self.view.addSubview(tableView)
        tableView.register(UserTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(layoutView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
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
extension FindViewController{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableView.datas.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.indexPath = indexPath
        
        let model = tableView.datas[indexPath.row]
        cell.model = (model as! UserInfo)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
}
