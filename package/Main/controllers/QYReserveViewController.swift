//
//  QYReserveViewController.swift
//  package
//
//  Created by Admin on 2019/3/5.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import MJRefresh

class QYReserveViewController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    var data : Array<QYGoodsModel> = Array.init()
    var collectionView : UICollectionView?
    
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshData()
    }
    
    override func initNavi() {
        super.initNavi()
        self.navigationItem.title = "预约"
    }
    
    override func initUI() {
        super.initUI()
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
        
        layout.estimatedItemSize = CGSize.init(width: UIScreen.main.bounds.width, height: 50)
        //
        //        layout.estimatedItemSize = CGSize.init(width: 50, height: 30)
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0)
        
        layout.headerReferenceSize = CGSize.init(width: self.view.frame.width, height: 20)
        
        
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.register(QYGoodsCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collectionView!.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView!)
        collectionView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.refreshData()
        })
        collectionView?.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                self.collectionView?.mj_footer.endRefreshing()
            })
        })
        
    }
    func refreshData()  {
        self.data.removeAll()
        self.view.makeToastActivity(.center)
        Request.getGoods { (success, msg, data) -> (Void) in
            self.view.hideToastActivity()
            self.collectionView?.mj_header.endRefreshing()
            self.collectionView?.mj_footer.endRefreshing()
            
            if success {
                for dataitem in data
                {
                    let model = QYGoodsModel.init(dic: dataitem as! Dictionary<String, Any>)

                    for reserver in Request.reserverList
                    {
                        if reserver == model.goodsId
                        {
                             self.data.append(model)
                        }
                    }
                }
                

                self.collectionView?.reloadData()
            }
            else
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
extension QYReserveViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : QYGoodsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QYGoodsCollectionViewCell
        cell.model = self.data[indexPath.section]
        

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.data[indexPath.section]
        
        let detail = QYDetailViewController.init()
        detail.model = model
        
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
