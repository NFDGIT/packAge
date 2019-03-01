//
//  LocationViewController.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class LocationViewController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    var collectionView : UICollectionView?
    
    var datas : Array<Any> = Array.init()
    
    func getLayout() -> UICollectionViewLayout {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        layout.minimumLineSpacing = SCALE(size: 5)
        
        
//        if type == .list
//        {
//            //            layout.itemSize = CGSize.init(width: UIScreen.main.bounds.width - 30, height: 50)
            layout.estimatedItemSize = CGSize.init(width: UIScreen.main.bounds.width - 30, height: 50)
//        }
//        else
//        {
//            layout.estimatedItemSize = CGSize.init(width: 50, height: 30)
//        }
        
        
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        layout.sectionInset = UIEdgeInsetsMake(4, 10, 10, 10)
        
        layout.headerReferenceSize = CGSize.init(width: self.view.frame.width, height: 20)
        layout.footerReferenceSize = CGSize.init(width: self.view.frame.width, height: 0.3)
        
        //        layout.footerReferenceSize = CGSize.init(width: self.frame.width, height: 20)
        return layout
    }
    func getCollection() -> UICollectionView {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.getLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LocationViewCollectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(LocationCollectionCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        self.refreshData()
        
        
        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        self.navigationItem.title = "地址"
    }
    override func initUI() {
        super.initUI()
        
        
//        let districtView : PHDistrictView = PHDistrictView.init(frame: CGRect.zero)
//        self.view.addSubview(districtView)
//        districtView.snp.makeConstraints { (make) in
//            make.left.bottom.right.equalToSuperview()
//            make.top.equalToSuperview()
//        }
//
        
        


        
        self.collectionView = self.getCollection()
        self.view.addSubview(self.collectionView!)
        
        self.collectionView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func refreshData(){
        
        self.view.makeToastActivity(.center)
        
        NetTool.post(url: "https://restapi.amap.com/v3/config/district",param: ["key":"a9370bed5a49fd3a9585ba1db78005da","subdistrict":"2"] ) { (res) -> (Void) in
            self.view.hideToastActivity()
            
            if res.success
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                    let country : NSArray = (res.data["districts"] as! NSArray)
                    let provinces : NSArray = (country.firstObject as! NSDictionary).value(forKey: "districts") as! NSArray
                    self.datas = provinces as! Array<Any>
                    
                    self.collectionView?.reloadData()
                    
                })
                
                
                
                
                
                
                //                self.datas = ((res.data["districts"] as! Array<Any>).first as! Dictionary<String,Array>)["districts"]!
            }
            else
            {
                
            }
            self.collectionView?.reloadData()
            
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
extension LocationViewController{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let dic  :  Dictionary<String,Any> = self.datas[indexPath.section] as! Dictionary<String,Any>
        
        let reuseview : LocationViewCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader , withReuseIdentifier: "headerView", for: indexPath) as! LocationViewCollectionHeaderView
        
        reuseview.btn.setTitle((dic["name"] as! String), for: .normal)
        
        return reuseview
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.datas.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dic  :  Dictionary<String,Any> = self.datas[section] as! Dictionary<String,Any>
        let  districts : Array<Any> = dic["districts"] as! Array<Any>
        
        
        return districts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dic  :  Dictionary<String,Any> = self.datas[indexPath.section] as! Dictionary<String,Any>
        let  citys : Array<Any> = dic["districts"] as! Array<Any>
        let  cityDic : Dictionary<String,Any> = citys[indexPath.row] as! Dictionary<String,Any>
 
        
        
        let  cell : LocationCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LocationCollectionCell
        
        cell.btn.setTitle((cityDic["name"] as! String), for: .normal)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
}

class LocationViewCollectionHeaderView : UICollectionReusableView {
    let btn : UIButton = UIButton.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func initUI()  {
        self.addSubview(btn)
//        btn.backgroundColor = UIColor.white
        btn.phInitialize(normalTitle: "", normalTextColor: UIColor.phBlackText, font: UIFont.phBig)
        btn.contentHorizontalAlignment = .left
        btn.phImagePosition(at: .left, space: SCALE(size: 25))
        btn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}
class LocationCollectionCell: UICollectionViewCell {
    let btn : UIButton = UIButton.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.initUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        
        let size = self.contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var cellFrame = layoutAttributes.frame
        cellFrame.size.height = size.height
        
        layoutAttributes.frame = cellFrame
        return layoutAttributes
    }
    
    
    
    func initUI()  {
        self.contentView.addSubview(btn)
//        self.contentView.phView(backGroundColor: UIColor.green)
        
        self.phView(backGroundColor: .white)
        btn.phInitialize(normalTitle: "北京", normalTextColor: UIColor.phBlackText, font: UIFont.phMiddle)
        
        btn.backgroundColor = UIColor.white
        btn.phLayer(cornerRadius: 5, borderWidth: 0, borderColor: UIColor.white)
        btn.contentHorizontalAlignment = .left
        btn.phImagePosition(at: .left, space: 5)
        
        btn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(self.snp.width)
            make.bottom.equalToSuperview()
        }
        
    }
}
