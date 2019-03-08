//
//  QYMessageCollectionViewCell.swift
//  package
//
//  Created by Admin on 2019/3/5.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class QYMessageCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
        self.layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var _model : QYMessageModel?
    var  model : QYMessageModel?{
        set{
            _model = newValue
            self.refreshUI()
        }
        get{
            return _model
        }
    }
    
    let img:UIImageView = UIImageView.init()
    let labelTitle:UILabel = UILabel.init()
    let labelPrice:UILabel = UILabel.init()
    let labelDesc:UILabel = UILabel.init()
    
    
    func initUI() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(img)

        
        self.contentView.addSubview(labelTitle)
        labelTitle.numberOfLines = 2
        labelTitle.font = UIFont.phMiddle
        labelTitle.textColor = UIColor.phBlackText
        
        
        self.contentView.addSubview(labelDesc)
        labelDesc.numberOfLines = 2
        labelDesc.font = UIFont.phSmall
        labelDesc.textColor = UIColor.phLightGrayText
        
        
    }
    func layout()  {
        self.backgroundColor = UIColor.white
        
        labelTitle.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(SCALE(size: 10))
            make.width.equalTo(UIScreen.main.bounds.width - SCALE(size: 50))

        }
        
        labelDesc.snp.makeConstraints { (make) in
            make.left.right.equalTo(labelTitle)
            make.top.equalTo(labelTitle.snp.bottom).offset(SCALE(size: 10))
//            make.right.equalToSuperview().offset(SCALE(size: -10))
            make.bottom.equalToSuperview().offset(SCALE(size: -10))
        }
    
    }
    func refreshUI()  {
        
        labelTitle.text = model?.name
        labelDesc.text = model?.content
//        img.kf.setImage(with: URL.init(string: (model?.avatar)!), placeholder: UIImage.init(named: "default"))
//        labelTitle.text = "\(model?.name ?? "")  \(model?.bedroomNum ?? "")室\(model?.liveroomNum ?? "")厅\(model?.restroomNum ?? "")卫"
//        labelPrice.text = "\(model?.price ?? "")元/月"
//
//        labelDesc.text = model?.address
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
