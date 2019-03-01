//
//  FilterTypeViewController.swift
//  package
//
//  Created by Admin on 2019/2/27.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class FilterTypeViewController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    var collectionView : UICollectionView?
    
    var datas : Array<Any> = Array.init()
    
    func getLayout() -> UICollectionViewLayout {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        layout.minimumLineSpacing = SCALE(size: 10)
        layout.sectionInset = UIEdgeInsetsMake(4, 10, 10, 10)
        
        //        if type == .list
        //        {
        //            //            layout.itemSize = CGSize.init(width: UIScreen.main.bounds.width - 30, height: 50)
        //        layout.estimatedItemSize = CGSize.init(width: UIScreen.main.bounds.width - 30, height: 50)
        //        }
        //        else
        //        {
        
        
        let width = (UIScreen.main.bounds.size.width - CGFloat(layout.minimumLineSpacing.significandWidth * 4) - 40) / 3
        let height : CGFloat = UIScreen.main.bounds.width * 0.1
        
        layout.estimatedItemSize = CGSize.init(width: width, height: height)
        //        }
        
        
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        layout.headerReferenceSize = CGSize.init(width: self.view.frame.width, height: SCALE(size: 40))
        layout.footerReferenceSize = CGSize.init(width: self.view.frame.width, height: 0.3)
        
        //        layout.footerReferenceSize = CGSize.init(width: self.frame.width, height: 20)
        return layout
    }
    func getCollection() -> UICollectionView {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.getLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FilterTypeViewCollectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(FilterTypeCollectionCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        
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
        self.navigationItem.title = "选择户型"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确定", style: UIBarButtonItemStyle.done, target: self, action: #selector(rightBtn))
    }
    override func initUI() {
        super.initUI()
        
        
        self.collectionView = self.getCollection()
        self.view.addSubview(self.collectionView!)
        
        self.collectionView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func refreshData(){
        
        self.view.makeToastActivity(.center)
        let datas : Array<Any> = [
            ["name":"筛选","districts":[
                ["name":"不限","selected":true],["name":"个人","selected":false],["name":"经纪人","selected":false]
                ]
            ],
            ["name":"朝向","districts":[
                ["name":"不限","selected":true],["name":"东","selected":false],["name":"南","selected":false],["name":"西","selected":false],["name":"北","selected":false]
                ]
            ]
        ]
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            self.view.hideToastActivity()
            
            
            //            let country : NSArray = (res.data["districts"] as! NSArray)
            //            let provinces : NSArray = (country.firstObject as! NSDictionary).value(forKey: "districts") as! NSArray
            self.datas = datas
            
            self.collectionView?.reloadData()
            
        })
        
        //
        //        NetTool.post(url: "https://restapi.amap.com/v3/config/district",param: ["key":"a9370bed5a49fd3a9585ba1db78005da","subdistrict":"2"] ) { (res) -> (Void) in
        //            self.view.hideToastActivity()
        //
        //            if res.success
        //            {
        //                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
        //                    let country : NSArray = (res.data["districts"] as! NSArray)
        //                    let provinces : NSArray = (country.firstObject as! NSDictionary).value(forKey: "districts") as! NSArray
        //                    self.datas = provinces as! Array<Any>
        //
        //                    self.collectionView?.reloadData()
        //
        //                })
        //
        //
        //
        //
        //
        //
        //                //                self.datas = ((res.data["districts"] as! Array<Any>).first as! Dictionary<String,Array>)["districts"]!
        //            }
        //            else
        //            {
        //
        //            }
        //            self.collectionView?.reloadData()
        //
        //        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func rightBtn(){
        self.navigationController?.popViewController(animated: true)
    }
}
extension FilterTypeViewController{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let dic  :  Dictionary<String,Any> = self.datas[indexPath.section] as! Dictionary<String,Any>
        
        let reuseview : FilterTypeViewCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader , withReuseIdentifier: "headerView", for: indexPath) as! FilterTypeViewCollectionHeaderView
        
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
        
        
        
        let  cell : FilterTypeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterTypeCollectionCell
        
        cell.btn.setTitle((cityDic["name"] as! String), for: .normal)
        cell.btn.isSelected = cityDic["selected"] as! Bool
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.select(indexP: indexPath)
        
        self.collectionView?.reloadData()
    }
    func select(indexP:IndexPath)  {
        
        var dataTep = datas
        for (index,sectionDic) in datas.enumerated() {
            if index == indexP.section
            {
                
                
                var itemstem : Array<Dictionary<String, Any>> = Array.init()
                
                
                var sectionDicCopy  : Dictionary<String,Any> = (sectionDic as! Dictionary<String,Any>)
                let itemscopy : Array<Any> = sectionDicCopy["districts"] as! Array
                for (indexRow,item)  in itemscopy.enumerated(){
                    var itemcopy : Dictionary<String,Any> = item as! Dictionary<String, Any>
                    itemcopy.updateValue(false, forKey: "selected")
                    if indexRow == indexP.row
                    {
                        itemcopy.updateValue(true, forKey: "selected")
                    }
                    itemstem.append(itemcopy)
                }
                
                sectionDicCopy.updateValue(itemstem, forKey: "districts")
                dataTep[indexP.section] = sectionDicCopy
            
            }
        }
        self.datas = dataTep
        
    }
    
    
}

class FilterTypeViewCollectionHeaderView : UICollectionReusableView {
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
class FilterTypeCollectionCell: UICollectionViewCell {
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
        btn.phInitialize(normalTitle: "北京", normalTextColor: UIColor.phBlackText,normalBgImg:UIImage.phInit(color: UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)),selectedBgImg:UIImage.phInit(color: UIColor.init(red: 255/255.0, green: 127/255.0, blue: 0, alpha: 0.6)), font: UIFont.phMiddle)
        
        btn.backgroundColor = UIColor.white
        btn.phLayer(cornerRadius: 2, borderWidth: 0, borderColor: UIColor.white)
        btn.phImagePosition(at: .left, space: 5)
        btn.isUserInteractionEnabled = false
//        btn.isEnabled = false
        
        let height : CGFloat = UIScreen.main.bounds.width * 0.1
        btn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(self.snp.width)
            make.height.equalTo(height)
            make.bottom.equalToSuperview()
        }
        
    }
}
