//
//  BaseTableViewCell.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func initUI()  {
        let btn = UIButton.init(normalTitle: "hello ", selectedTitle: nil, normalImg: nil, selectedImg: nil, normalTextColor: UIColor.red, selectedTextColor: nil, font: nil)
        self.addSubview(btn)
        btn.isUserInteractionEnabled = false
        btn.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
     
    }


}
