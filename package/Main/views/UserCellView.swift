//
//  UserCellView.swift
//  package
//
//  Created by Admin on 2019/2/26.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class UserCellView: UIView {
    let imgView : UIImageView = UIImageView.init()
    let labelTitle : UILabel = UILabel.init()
    let labelSubtitle: UILabel = UILabel.init()

    
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
        
        self.addSubview(imgView)
        self.addSubview(labelTitle)
        labelTitle.textColor = UIColor.phBlackText
        labelTitle.font = UIFont.phMiddle
        
        
        
        self.addSubview(labelSubtitle)
        labelSubtitle.textColor = UIColor.phBlackText
        labelSubtitle.font = UIFont.phSmall
    }
    func layout()  {
        self.imgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(SCALE(size: 10))
            make.width.height.equalTo(SCALE(size: 60))
            make.bottom.equalToSuperview().offset(SCALE(size: -10))
        }
        
        self.labelTitle.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView.snp.right).offset(SCALE(size: 10))
            make.height.equalTo(SCALE(size: 20))
            make.right.equalToSuperview().offset(SCALE(size: -10))
            make.bottom.equalTo(self.imgView.snp.centerY).offset(SCALE(size: 0))
        }
        
        self.labelSubtitle.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView.snp.right).offset(SCALE(size: 10))
            make.height.equalTo(SCALE(size: 20))
            make.right.equalToSuperview().offset(SCALE(size: -10))
            make.top.equalTo(self.imgView.snp.centerY).offset(SCALE(size: 0))
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
