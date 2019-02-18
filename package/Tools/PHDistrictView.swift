//
//  DistrictView.swift
//  package
//
//  Created by Admin on 2019/2/15.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit


enum PHDistrictViewType{
    case list
    case collection
}
class PHDistrictView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{

    private var type:PHDistrictViewType = .list
    
    var collectionView : UICollectionView?
    init() {
        super.init(frame: CGRect.zero)
        self.initUI()
    }
    override init(frame: CGRect) {
       super.init(frame: frame)
        self.initUI()
       
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    func setType(type:PHDistrictViewType){
        self.type = type
        self.collectionView?.setCollectionViewLayout(self.getLayout(), animated: true)
    }
    
    func getLayout() -> UICollectionViewLayout {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
        
        
        if type == .list
        {
//            layout.itemSize = CGSize.init(width: UIScreen.main.bounds.width - 30, height: 50)
            layout.estimatedItemSize = CGSize.init(width: UIScreen.main.bounds.width - 30, height: 50)
        }
        else
        {
            layout.estimatedItemSize = CGSize.init(width: 50, height: 30)
        }
        
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        layout.headerReferenceSize = CGSize.init(width: self.frame.width, height: 20)
        
//        layout.footerReferenceSize = CGSize.init(width: self.frame.width, height: 20)
        return layout
    }
    func getCollection() -> UICollectionView {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.getLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PHDistrictViewCollectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(PHDistrictViewCollectionCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }
    
    func initUI()  {

        self.collectionView = self.getCollection()
        self.addSubview(self.collectionView!)
        
        self.collectionView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension PHDistrictView{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseview : PHDistrictViewCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader , withReuseIdentifier: "headerView", for: indexPath) as! PHDistrictViewCollectionHeaderView
        
        return reuseview
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell : PHDistrictViewCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PHDistrictViewCollectionCell
        return cell
    }
}

class PHDistrictViewCollectionHeaderView : UICollectionReusableView {
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
        btn.backgroundColor = UIColor.white
        btn.phInitialize(normalTitle: "a", normalTextColor: UIColor.red, font: UIFont.phBig)
        btn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
class PHDistrictViewCollectionCell: UICollectionViewCell {
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
        self.contentView.phView(backGroundColor: UIColor.green)
        
        self.phView(backGroundColor: .white)
        btn.phInitialize(normalTitle: "北京", normalTextColor: UIColor.red, font: UIFont.phBig)
        
        btn.backgroundColor = UIColor.white
        btn.phLayer(cornerRadius: 5, borderWidth: 0, borderColor: UIColor.white)
        
        btn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(self.snp.width)
            make.bottom.equalToSuperview()
        }
    
    }
}
