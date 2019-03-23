//
//  QYGoodsCollectionViewCell.swift
//  package
//
//  Created by Admin on 2019/3/5.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYGoodsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
        self.layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
    let cellView : ZYGoodsCellView = ZYGoodsCellView()
    
    func initUI() {
  
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellView)


    }
    func layout()  {
        cellView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width - 20)
            make.bottom.equalToSuperview()
        
        }
        

    }
    func refreshUI()  {
        cellView.model = self.model

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
