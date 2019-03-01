//
//  BaseTableViewCell.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.initUI()
        self.layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imgView : UIImageView = UIImageView.init()
    let labelName : UILabel = UILabel.init()
    let labelAddress : UILabel = UILabel.init()
    let labelDesc : UILabel  = UILabel.init()
    let btnPraise : UIButton = UIButton.init()
    
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
    func initUI()  {

        
        self.contentView.addSubview(imgView)
        imgView.phLayer(cornerRadius: 0, borderWidth: 1,borderColor: UIColor.lightGray)
        
        
        self.contentView.addSubview(labelName)
        
        
        
        self.contentView.addSubview(labelAddress)
        
        self.contentView.addSubview(labelDesc)
        
        self.contentView.addSubview(btnPraise)
        btnPraise.phInitialize(normalTitle: "24", normalImg: UIImage.init(named: "选中"), normalTextColor: UIColor.red,font: UIFont.phMiddle)
        
        
        
    }
    func layout()  {
        imgView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(SCALE(size: 10))
            make.width.height.equalTo(SCALE(size: 80))
//            make.bottom.equalToSuperview().offset(SCALE(size: -10))
        }
        labelName.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.top)
            make.left.equalTo((imgView.snp.right)).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        labelAddress.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgView.snp.centerY)
            make.left.equalTo((imgView.snp.right)).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        labelDesc.snp.makeConstraints { (make) in
            make.bottom.equalTo(imgView.snp.bottom)
            make.left.equalTo((imgView.snp.right)).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        btnPraise.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(SCALE(size: 50))
            make.height.equalTo(20)
        }
    }
    
    func refreshUI(){
//        "http://t3.qlogo.cn/mbloghead/71220ceb3aeae6d41970/50"
        let url = URL(string: (model?.avatar)!)
        imgView.kf.setImage(with: url,placeholder: UIImage.init(named: "avatar"))
       
        self.btnPraise.setTitle(model?.praise, for: .normal);
     
        self.labelName.text = model?.name
        self.labelAddress.text = model?.address
        self.labelDesc.text = model!.price
    }

}
