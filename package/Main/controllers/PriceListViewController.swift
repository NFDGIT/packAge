//
//  PriceListViewController.swift
//  package
//
//  Created by Admin on 2019/2/21.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PriceListViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi();
        self.initUI()

        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
    }
    override func initUI() {
        super.initUI()
        
        
        let tableView : UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalToSuperview()
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
extension PriceListViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.indexPath = indexPath
        cell.textLabel?.text = "\(100)元"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
}
