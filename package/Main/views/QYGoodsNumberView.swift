//
//  QYGoodsNumberView.swift
//  package
//
//  Created by Admin on 2019/3/15.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class QYGoodsNumberView: UIView {
    var numberChangeCallback:((Int)->())?
    
    
    private var _number : Int = 1
    var number : Int {
        get{
            return _number
        }
        set{
            _number = newValue
            self.refreshUI()
        }
    }
    
    private let btnSubtract : UIButton = UIButton.init()
    private let btnAugment : UIButton = UIButton.init()
    let btnNumber : UIButton = UIButton.init()
    
    
    init() {
        super.init(frame: CGRect.zero)
        self.initUI()
        self.layout()

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func  initUI()  {
        self.phLayer(cornerRadius: SCALE(size: 12.5), borderWidth: 1,borderColor: UIColor.appTheme);
        
        self.addSubview(btnSubtract)

        btnSubtract.setImage(UIImage.init(named: "减"), for: .normal)
        btnSubtract.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        
        
        
        self.addSubview(btnNumber)
        btnNumber.titleLabel?.font = UIFont.phBig
        btnNumber.setTitleColor(UIColor.phLightGrayText, for: .normal)
    
        
        
        self.addSubview(btnAugment)
        btnAugment.setImage(UIImage.init(named: "加"), for: .normal)
        btnAugment.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
    }
    
    @objc func btnClick(sender:UIButton)  {
        var num = self.number
        
        if sender.isEqual(btnSubtract) {
           num = self.number - 1
        }else{
           num = self.number + 1
        }


        if self.numberChangeCallback != nil
        {
            self.numberChangeCallback!(num)
        }
    }
    func layout()  {
        let height = SCALE(size: 25)
        let width = SCALE(size: 75)
        
        btnSubtract.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.height.equalTo(height)
        }
        
        
        btnNumber.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(btnSubtract.snp.right)
            make.height.equalTo(height)
            make.width.equalTo(width-height*2)
            
        }
        
        btnAugment.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(btnNumber.snp.right)
            make.height.width.equalTo(height)
            
            
            make.bottom.right.equalToSuperview()

        }
        
        
        
    }
    func refreshUI()  {
        self.btnNumber.setTitle("\(self.number)", for: .normal)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
