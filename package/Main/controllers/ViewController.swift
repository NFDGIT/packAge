//
//  ViewController.swift
//  package
//
//  Created by Admin on 2019/2/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    var datas:Array<UserInfo> = Array.init()
    
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
        let userinfo : UserInfo = UserInfo()
        userinfo.name = "彭辉"
        userinfo.avatar = "http://img4.duitang.com/uploads/item/201408/27/20140827212135_NzdLA.thumb.700_0.png"
        userinfo.praise = "20"
        userinfo.address = "河南郑州"
        userinfo.price = "1500"



//        Request.addUser(userInfo: userinfo) { (success, msg, data) -> (Void) in
//
//        }
  
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func initNavi() {
        super.initNavi()
     
        self.title = "首页"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "位置", style: UIBarButtonItemStyle.done, target: self, action: #selector(rightBtn))
    
    }
    
    
    
    override func initUI() {
        super.initUI()
        
        
        let carouseDatas : [(img:String,title:String)] = [("https://p.ssl.qhimg.com/dmfd/400_300_/t0181726b381cae1f8a.jpg",""),("http://img4.duitang.com/uploads/item/201408/27/20140827212135_NzdLA.thumb.700_0.png","")]
        let carouse = PHCarouselView.init(direction: .horizontal)
        self.view.addSubview(carouse)
        carouse.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(200)
        }
        carouse.numberCell = {
            return carouseDatas.count
        }
        carouse.cellForIndex = { index in
            let item = carouseDatas[index]
            
            let img : ImageView = ImageView.init()
            img.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: item.img)!),placeholder: UIImage.init(named: "default"))
            return img
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
        carouse.reload();
        }

        

        

        self.view.addSubview(tableView)
        tableView.register(UserTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(carouse.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
  
    }
    
    @objc func rightBtn(){
       self.navigationController?.pushViewController(LocationViewController(), animated: true)
    }
    
    func refreshData(){
        Request.getUsers(pageNum: 0) { (success, msg, data) -> (Void) in
            
            
            if success {
                
               
                for item in data {
                    let model : UserInfo = UserInfo.init(dic: item as! Dictionary<String, Any>)
                    self.datas.append(model)
                }
            
                self.tableView.reloadData()
            }

        }
    
    }
    
}

extension ViewController{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datas.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.indexPath = indexPath
        
        let model = datas[indexPath.row]
        cell.model = model
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
}
