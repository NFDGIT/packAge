//
//  QYCategoryItemViewController.swift
//  package
//
//  Created by Admin on 2019/3/10.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import MJRefresh


class ZYCategoryItemViewController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var type : String = ""
    var data : Array<ZYGoodsModel> = Array.init()
    var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        self.refreshData()

        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        self.navigationItem.title = type
    }
    override func initUI() {
        super.initUI()
        
        
        
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        

        
        layout.estimatedItemSize = CGSize.init(width: UIScreen.main.bounds.width - 20, height: 90)
        //
        //        layout.estimatedItemSize = CGSize.init(width: 50, height: 30)
        
//        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 0)
        
        //        layout.headerReferenceSize = CGSize.init(width: self.view.frame.width, height: 20)
        
        
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.green
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.register(ZYGoodsCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collectionView!.backgroundColor = UIColor.clear
        
        collectionView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.refreshData()
        })
        collectionView?.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                self.collectionView?.mj_footer.endRefreshing()
            })
        })

        self.view.addSubview(collectionView!)
        collectionView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        
        
      
    }
    
    func refreshData()  {
        Request.getGoods { (success, msg, data) -> (Void) in
            self.collectionView?.mj_header.endRefreshing()
            self.collectionView?.mj_footer.endRefreshing()
            
            if success {
                for datadic in data
                {
                    let model = ZYGoodsModel.init(dic: datadic as! Dictionary<String, Any>)
                    self.data.append(model)
                }
                self.data = self.data.filter({ (model) -> Bool in
                    return model.type == self.type
                })
                self.collectionView?.reloadData()
            }else
            {
                self.view.makeToast(msg,position:.center)
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
extension ZYCategoryItemViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ZYGoodsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZYGoodsCollectionViewCell
        cell.model = self.data[indexPath.section]
        
     
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.data[indexPath.section]
        let detail = ZYDetailViewController.init()
        detail.model = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
