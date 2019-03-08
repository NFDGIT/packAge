//
//  QYMomentTableViewCell.swift
//  package
//
//  Created by Admin on 2019/3/5.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class QYMomentTableViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
        self.layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var _model : QYNewsModel = QYNewsModel()
    var  model : QYNewsModel?{
        set{
            _model = newValue as! QYNewsModel
            self.refreshUI()
        }
        get{
            return _model
        }
    }
    
    let img:UIImageView = UIImageView.init()
    let labelTitle:UILabel = UILabel.init()
    let labelDesc:UILabel = UILabel.init()
    let imgLayoutView:PHLayoutView = PHLayoutView.init()
    
    
    
    func initUI() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(img)
        img.phLayer(cornerRadius: 5, borderWidth: 0)
        
        
        self.contentView.addSubview(labelTitle)
        labelTitle.numberOfLines = 0
        labelTitle.font = UIFont.phMiddle
        labelTitle.textColor = UIColor.phBlackText
        

        
        self.contentView.addSubview(labelDesc)
        labelDesc.numberOfLines = 0
        labelDesc.font = UIFont.phSmall
        labelDesc.textColor = UIColor.phLightGrayText
        
        self.contentView.addSubview(imgLayoutView)
        imgLayoutView.layout.type = .collection
        imgLayoutView.layout.column = 3
        imgLayoutView.numberOfCell = {
            return (self.model!.imgs.count)
        }
        imgLayoutView.cellForIndex = {index in
            let btn = UIButton.init()
            let imgDic = self.model?.imgs[index]
            


            let img = UIImageView.init()
            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            img.backgroundColor = UIColor.phBgContent
            img.kf.setImage(with: URL.init(string: "\(imgDic!["url"] ?? "0")"))
            btn.addSubview(img)
            img.snp.makeConstraints({ (make) in
                make.left.top.equalToSuperview().offset(SCALE(size: 2))
                make.right.bottom.equalToSuperview().offset(SCALE(size: -2))
            })

            return btn
        }
        imgLayoutView.reload()
    }
    func layout()  {
        self.backgroundColor = UIColor.white
        
        img.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(SCALE(size: 10))
            make.width.height.equalTo(SCALE(size: 40))
        }
        
        
        
        labelTitle.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(SCALE(size: 10))
            make.centerY.equalTo(img.snp.centerY)
            make.width.equalToSuperview().offset(SCALE(size: -70))
    
        }
        
        
        labelDesc.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.left)
            make.top.equalTo(img.snp.bottom).offset(SCALE(size: 5))
            make.width.equalTo(UIScreen.main.bounds.size.width - SCALE(size: 40))
            
//            make.bottom.equalToSuperview().offset(SCALE(size: -10))
        }
        
        
        imgLayoutView.snp.makeConstraints { (make) in
            make.left.equalTo(labelDesc.snp.left)
            make.top.equalTo(labelDesc.snp.bottom).offset(SCALE(size: 10))
            make.right.equalTo(labelDesc.snp.right)
            make.bottom.equalToSuperview().offset(SCALE(size: -10))
        }

    
        
    }
    func refreshUI()  {
        
        img.backgroundColor = UIColor.phBgContent
        
        
        img.kf.setImage(with: URL.init(string: (model?.avatar)!))
        
        labelTitle.text = model?.name
        labelDesc.text = model?.content
        
    
        imgLayoutView.reload()
//        imgLayoutView.reload()
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
