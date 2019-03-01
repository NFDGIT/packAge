//
//  GoodsCollectionViewCell.swift
//  package
//
//  Created by Admin on 2019/2/25.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class GoodsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
        self.layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var _model : GoodsInfo?
    var  model : GoodsInfo?{
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
        self.contentView.addSubview(img)
        img.phLayer(cornerRadius: 5, borderWidth: 0)
        
        self.contentView.addSubview(labelTitle)
        labelTitle.font = UIFont.phMiddle
        labelTitle.textColor = UIColor.phBlackText
        
        self.contentView.addSubview(labelPrice)
        labelPrice.font = UIFont.phMiddle
        labelPrice.textColor = UIColor.appTheme
        
        
        self.contentView.addSubview(labelDesc)
        labelDesc.font = UIFont.phSmall
        labelDesc.textColor = UIColor.phLightGrayText
        
        
    }
    func layout()  {
        self.backgroundColor = UIColor.white
        
        labelDesc.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(SCALE(size: -10))
            make.right.equalToSuperview().offset(SCALE(size: -10))
            make.height.equalTo(SCALE(size: 20))
        }
        
        labelPrice.snp.makeConstraints { (make) in
            
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(SCALE(size: 10))
            make.right.equalTo(labelDesc.snp.left).offset(SCALE(size: -10))
            make.bottom.equalToSuperview().offset(SCALE(size: -10))
        }
        
        

        
        labelTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(SCALE(size: 10))
            make.right.equalToSuperview().offset(SCALE(size: -10))
            make.height.equalTo(SCALE(size: 20))
            make.bottom.equalTo(labelPrice.snp.top).offset(SCALE(size: -5))
        }
    
        img.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(labelTitle.snp.top).offset(SCALE(size: -10))
        }
        
    }
    func refreshUI()  {
        img.kf.setImage(with: URL.init(string: (model?.avatar)!), placeholder: UIImage.init(named: "default"))
        labelTitle.text = "\(model?.name ?? "")  \(model?.bedroomNum ?? "")室\(model?.liveroomNum ?? "")厅\(model?.restroomNum ?? "")卫"
        labelPrice.text = "\(model?.price ?? "")元/月"

        labelDesc.text = model?.address
    }
    
}
