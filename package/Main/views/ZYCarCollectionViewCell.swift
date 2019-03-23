//
//  QYCarCollectionViewCell.swift
//  package
//
//  Created by Admin on 2019/3/11.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYCarCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
        self.layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var numberChangeCallback:((IndexPath,Int)->())?
    
    var _model : ZYGoodsModel?
    var  model : ZYGoodsModel?{
        set{
            _model = newValue
            self.refreshUI()
        }
        get{
            return _model
        }
    }
    var selectCallBack:((IndexPath)->())?
    
    let cellView : ZYCarCellView = ZYCarCellView()
    let btnSelect : UIButton = UIButton.init()
    let numberView : QYGoodsNumberView = QYGoodsNumberView.init()

    
    func initUI() {
        self.contentView.layer.cornerRadius = SCALE(size: 10)
        self.contentView.layer.masksToBounds = true
        
        self.contentView.backgroundColor = UIColor.white
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellView)
        
        
        self.contentView.addSubview(btnSelect)
        btnSelect.setImage(UIImage.init(named: "选择1"), for: .selected)
        btnSelect.setImage(UIImage.init(named: "选择"), for: .normal)
        
        self.contentView.addSubview(numberView)
        numberView.numberChangeCallback = {numbe in
            if self.numberChangeCallback != nil
            {
                self.numberChangeCallback!(self.indexPath!,numbe)
            }
            
        }
    
    }
    func layout()  {
        cellView.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(SCALE(size: 50))
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()

            make.width.equalTo(UIScreen.main.bounds.width-SCALE(size: 70))

        }
        
        btnSelect.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(SCALE(size: 10))
            make.centerY.equalTo(cellView.snp.centerY)
            make.width.height.equalTo(SCALE(size: 30))
        }



        numberView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(cellView).offset(SCALE(size: -10))
        }


        btnSelect.phAddTarget(events: .touchUpInside) { (sender) in
            if (self.selectCallBack != nil){
                self.selectCallBack!(self.indexPath!)
            }
        }

    }
    func refreshUI()  {
        cellView.model = self.model
        
        self.btnSelect.isSelected = (self.model?.isSelected)!
        
        self.numberView.number = (self.model?.number)!
        
    
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
}
struct QYGoodsModelAssociatedKeys {
    static var isSelected: String = "isSelected"
    static var number: String = "number"
}

extension ZYGoodsModel{
    var isSelected: Bool? {
        get {
            
            let value = objc_getAssociatedObject(self, &QYGoodsModelAssociatedKeys.isSelected) ?? false
            return (value as! Bool)
        }
        set {
            objc_setAssociatedObject(self, &QYGoodsModelAssociatedKeys.isSelected, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var number: Int? {
        get {
            
            let value = objc_getAssociatedObject(self, &QYGoodsModelAssociatedKeys.number) ?? 1
            return (value as! Int)
        }
        set {
            objc_setAssociatedObject(self, &QYGoodsModelAssociatedKeys.number, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
