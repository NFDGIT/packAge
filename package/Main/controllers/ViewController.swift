//
//  ViewController.swift
//  package
//
//  Created by Admin on 2019/2/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: BaseViewController,UICollectionViewDelegate ,UICollectionViewDataSource {

    
    var datas:Array<GoodsInfo> = Array.init()
    
    
    var carouseDatas : Array<GoodsInfo> = Array.init()
    let carouse = PHCarouselView.init(direction: .horizontal)
    
    
    
    var collectionView : UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
        
//        self.phSet(key: "name", value: "penghui")
    
//        let name = self.phGet(key: "name")
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        
    
        super.viewDidLoad()
        self.initNavi()

        Request.register(goodsInfo: GoodsInfo.getRandomInfo()) { (success, msg, data) -> (Void) in
            
        }


        
        self.initUI()
        self.refreshData()
   
  
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func initNavi() {
        super.initNavi()
     
        self.title = "首页"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "位置", style: UIBarButtonItemStyle.done, target: self, action: #selector(rightBtn))
    
    }
    
    
    
    override func initUI() {
        super.initUI()
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(carouse)
        carouse.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(SCALE(size: 150))
        }
        carouse.numberCell = {
            return self.carouseDatas.count
        }
        carouse.cellForIndex = { index in
            let item = self.carouseDatas[index]
            
            let btn = UIButton.init()
            
            
            
            let img : ImageView = ImageView.init()
            img.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: item.avatar)!),placeholder: UIImage.init(named: "default"))
            img.isUserInteractionEnabled = false
            
            btn.addSubview(img)
            img.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            
            return btn
        }
        carouse.selectedCell = {index in
            let model : GoodsInfo =  self.carouseDatas[index]
            let detail = DetailViewController.init()
            detail.Id = model.userId
            self.navigationController?.pushViewController(detail, animated: true)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            self.carouse.reload();
        }

        

        
        let layoutviewDatas : [(img:String,title:String)] = [("整租","整租"),("合租","合租"),("个人房源","个人房源"),("安选","安选")]
        let layoutview :  PHLayoutView = PHLayoutView.init()
        layoutview.layout.direction = .horizontal
        self.view.addSubview(layoutview)
        layoutview.snp.makeConstraints { (make) in
            make.top.equalTo(carouse.snp.bottom).offset(SCALE(size: 20))
            make.left.right.equalToSuperview()
            make.height.equalTo(SCALE(size: 60))
        }
        layoutview.numberOfCell = {
            return layoutviewDatas.count
        }
        layoutview.cellForIndex = {index in
            let itemdata = layoutviewDatas[index]
            
            let btn = UIButton.init(normalTitle: itemdata.title, normalImg:UIImage.init(named: itemdata.img), normalTextColor: UIColor.phBlackText, font: UIFont.phMiddle)
            return btn
        }
        layoutview.selectedCell = {index in
            let findVC = FindViewController.init()
            findVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(findVC, animated: true)
        }
        layoutview.reload()
        for item in layoutview.subviews {
            (item as! UIButton).phImagePosition(at: .top, space: SCALE(size: 0))
        }
        
        
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
        
        layout.itemSize = CGSize.init(width: (UIScreen.main.bounds.size.width - 30)/2, height: 200)
        
        
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
            make.top.equalTo(layoutview.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        
    }
    
    @objc func rightBtn(){
       self.navigationController?.pushViewController(LocationViewController(), animated: true)
    }
    
    func refreshData(){

        self.view.makeToastActivity(.center)
        Request.getUsers(pageNum: 0) { (success, msg, data) -> (Void) in
            self.view.hideToastActivity()
            
            if success {
                
               
                for item in data {
                    let model : GoodsInfo = GoodsInfo.init(dic: item as! Dictionary<String, Any>)
                    self.datas.append(model)
                }
                self.collectionView.reloadData()
                
                self.carouseDatas.append(GoodsInfo.init(dic: data.last as! Dictionary<String, Any>))
                self.carouse.reload()
    
            }else{
                self.view.makeToast(msg,position:.center)
            }
            
        }
    
    }
    
}

extension ViewController{
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
