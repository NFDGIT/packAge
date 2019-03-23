//
//  QYEmptyView.swift
//  package
//
//  Created by Admin on 2019/3/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class QYEmptyView: UIView {
    var url : URL? = URL.init(string: "")
    var tip : String?
    
    init(url:URL? = URL.init(string: ""),tip:String) {
        super.init(frame: CGRect.zero)
        self.url = url
        self.tip = tip
        
        self.initUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initUI()  {
        let imgView = UIImageView.init()
        self.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(SCALE(size: 60))
        }
        
        if  url == nil {
            imgView.image = UIImage.init(named: "空列表")
        }else{
            imgView.kf.setImage(with: url)
        }

        
        let btnTip = UIButton.init()
        btnTip.setTitleColor(UIColor.lightGray, for: .normal)
        btnTip.titleLabel?.font = UIFont.phBig
        self.addSubview(btnTip)
        btnTip.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(SCALE(size: 10))
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(SCALE(size: 30))
        }
        btnTip.setTitle(self.tip, for: .normal)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
