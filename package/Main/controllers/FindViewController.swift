//
//  FindViewController.swift
//  package
//
//  Created by Admin on 2019/2/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class FindViewController: BaseViewController ,UICollectionViewDataSource,UICollectionViewDelegate{
    var datas:Array<GoodsInfo> = Array.init()
    var collectionView : UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
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

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.refreshData()
        
    }
    
    override func initNavi() {
        super.initNavi()
        
        self.navigationItem.title  = "找房"
        
    }
    func initData(){
        
        
    }
    func refreshData() {
        self.view.makeToastActivity(.center)
        self.datas.removeAll()
        

        Request.getUsers(pageNum: 1) { (success, msg, data) -> (Void) in
            
            self.view.hideToastActivity()
            if success {
                for item in data {
                    let model : GoodsInfo = GoodsInfo.init(dic: item as! Dictionary<String, Any>)
                    self.datas.append(model)
                }
                self.collectionView.reloadData()
            }else
            {
                self.view.makeToast(msg,position:.center)
            }
            
            
            
        }

        
        

    }
    override func initUI() {
        super.initUI()
        
        
        let itemvalues : [(title:String,url:String)] = [("区域",""),("租金",""),("户型",""),("筛选","")]
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
            
            let btn = UIButton.init(normalTitle: item.title, normalImg:UIImage.init(named: "下拉"), normalTextColor: UIColor.phBlackText , font: UIFont.phMiddle)
            return btn
        }
        layoutView.reload()
        
        for item in layoutView.subviews {
            (item as! UIButton).phImagePosition(at: .right, space: SCALE(size: 0))
        }
        layoutView.selectedCell = {index in
            if index == 0 {
                self.navigationController?.pushViewController(LocationViewController(), animated: true)
            }
            if index == 1 {
                self.navigationController?.pushViewController(FilterRentViewController(), animated: true)
            }
            if index == 2 {
                self.navigationController?.pushViewController(FilterTypeViewController(), animated: true)
            }
            if index == 3 {
                self.navigationController?.pushViewController(FilterViewController(), animated: true)
            }
            
        }
        
        
        
  

        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
        
        layout.itemSize = CGSize.init(width: (UIScreen.main.bounds.size.width - 20), height: 200)
        
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        layout.headerReferenceSize = CGSize.init(width: self.view.frame.width, height: 20)
        
        
        
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(GoodsCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(layoutView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
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
    //    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        let reuseview : PHDistrictViewCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader , withReuseIdentifier: "headerView", for: indexPath) as! PHDistrictViewCollectionHeaderView
    //
    //        return reuseview
    //        }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell : GoodsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GoodsCollectionViewCell
        cell.model = datas[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model : GoodsInfo =  datas[indexPath.row]
        let detail = DetailViewController.init()
        detail.Id = model.userId
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
