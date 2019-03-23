//
//  QYCarCellView.swift
//  package
//
//  Created by Admin on 2019/3/21.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYCarCellView: UIView {
    
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
    
    let img:UIImageView = UIImageView.init()
    let labelTitle:UILabel = UILabel.init()
    let labelPrice:UILabel = UILabel.init()
    let labelDesc:UILabel = UILabel.init()
    
    
    init() {
        super.init(frame: CGRect.zero)
        self.initUI()
        self.layout()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        self.backgroundColor = UIColor.white
        
        self.addSubview(img)
        img.contentMode = .scaleAspectFill
        img.backgroundColor = UIColor.phBgContent
        img.phLayer(cornerRadius: 5, borderWidth: 0)
        
        
        self.addSubview(labelTitle)
        labelTitle.font = UIFont.phMiddle
        labelTitle.textColor = UIColor.phBlackText
        
        self.addSubview(labelPrice)
        labelPrice.font = UIFont.phSmall
        labelPrice.textColor = UIColor.appTheme
        
        
        self.addSubview(labelDesc)
        labelDesc.font = UIFont.phSmall
        labelDesc.textColor = UIColor.phLightGrayText
        
        
    }
    func layout()  {
        
        
        img.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(SCALE(size: 10))
            make.width.height.equalTo(SCALE(size: 100))
            make.bottom.equalToSuperview().offset(SCALE(size: -10))
        }
        
        labelTitle.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(SCALE(size: 10))
            make.top.equalTo(img.snp.top).offset(SCALE(size: 5))
            make.right.equalToSuperview().offset(SCALE(size: -30))
        }
        
        
        labelDesc.snp.makeConstraints { (make) in
            make.left.equalTo(labelTitle.snp.left)
            make.centerY.equalTo(img.snp.centerY)
            make.width.equalTo(labelTitle.snp.width)
        }
        
        labelPrice.snp.makeConstraints { (make) in
            make.left.equalTo(labelTitle.snp.left)
            make.bottom.equalTo(img.snp.bottom).offset(SCALE(size: -5))
            make.width.equalTo(labelTitle.snp.width)
        }
        
        
        
    }
    func refreshUI()  {
        
        img.kf.setImage(with: URL.init(string: (model?.avatar)!))
        
        labelTitle.text = model?.name
        labelDesc.text = model?.content
        labelPrice.text = "¥\(model?.price ?? "")"
        
        
        //        img.kf.setImage(with: URL.init(string: (model?.avatar)!), placeholder: UIImage.init(named: "default"))
        //        labelTitle.text = "\(model?.name ?? "")  \(model?.bedroomNum ?? "")室\(model?.liveroomNum ?? "")厅\(model?.restroomNum ?? "")卫"
        //        labelPrice.text = "\(model?.price ?? "")元/月"
        //
        //        labelDesc.text = model?.address
    }
    
}

