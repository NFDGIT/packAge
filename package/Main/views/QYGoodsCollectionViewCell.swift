//
//  QYGoodsCollectionViewCell.swift
//  package
//
//  Created by Admin on 2019/3/5.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class QYGoodsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
        self.layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var _model : QYGoodsModel?
    var  model : QYGoodsModel?{
        set{
            _model = newValue
            self.refreshUI()
        }
        get{
            return _model
        }
    }
    let cellView : QYGoodsCellView = QYGoodsCellView()
    
//
//    let img:UIImageView = UIImageView.init()
//    let labelTitle:UILabel = UILabel.init()
//    let labelPrice:UILabel = UILabel.init()
//    let labelDesc:UILabel = UILabel.init()
//
//
    func initUI() {
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellView)
//
//        self.contentView.addSubview(img)
//        img.phLayer(cornerRadius: 5, borderWidth: 0)
//
//
//        self.contentView.addSubview(labelTitle)
//        labelTitle.font = UIFont.phMiddle
//        labelTitle.textColor = UIColor.phBlackText
//
//        self.contentView.addSubview(labelPrice)
//        labelPrice.font = UIFont.phMiddle
//        labelPrice.textColor = UIColor.appTheme
//
//
//        self.contentView.addSubview(labelDesc)
//        labelDesc.font = UIFont.phSmall
//        labelDesc.textColor = UIColor.phLightGrayText
//
//
    }
    func layout()  {
        cellView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.bottom.equalToSuperview()
        }
        
//        self.backgroundColor = UIColor.white
//
//        img.snp.makeConstraints { (make) in
//            make.left.top.equalToSuperview().offset(SCALE(size: 10))
//            make.width.height.equalTo(SCALE(size: 120))
//            make.bottom.equalToSuperview().offset(SCALE(size: -10))
//        }
//
//        labelTitle.snp.makeConstraints { (make) in
//            make.left.equalTo(img.snp.right).offset(SCALE(size: 10))
//            make.top.equalTo(img.snp.top).offset(SCALE(size: 5))
//            make.width.equalTo(UIScreen.main.bounds.width - SCALE(size: 100))
//        }
//
//
//        labelDesc.snp.makeConstraints { (make) in
//            make.left.equalTo(labelTitle.snp.left)
//            make.centerY.equalTo(img.snp.centerY)
//            make.width.equalTo(labelTitle.snp.width)
//        }
//
//        labelPrice.snp.makeConstraints { (make) in
//            make.left.equalTo(labelTitle.snp.left)
//            make.bottom.equalTo(img.snp.bottom).offset(SCALE(size: -5))
//            make.width.equalTo(labelTitle.snp.width)
//        }
//
//
    }
    func refreshUI()  {
        cellView.model = self.model
//        img.backgroundColor = UIColor.phLightGrayText
//
//        labelTitle.text = "fdsakfdjlkasfjdlksajfdlksafjds"
//        labelDesc.text = "dsaf.dsjflkasjdglkajflkdjsaklfdjsal;kgjkdangfkjdnsv,ndskdgjklafjd;lksajgdklsajflkdsjalfkdjsafkl;d"
//        labelPrice.text = "9888"
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
