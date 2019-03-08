//
//  QYReseverSubmitAlertView.swift
//  package
//
//  Created by Admin on 2019/3/7.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class QYReseverSubmitAlertView: UIView {
    
    let backView : UIView = UIView.init()
    
    var dateClosure:(()->(Date))?
    var submitClosure:((String)->())?
    
    init() {
        super.init(frame: CGRect.zero)

        self.initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI()  {
        backView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.backgroundColor = UIColor.white
        
        self.phLayer(cornerRadius: 5, borderWidth: 0)
        
        backView.addSubview(self)
    }
    func reload()  {
        var iterator = self.subviews.makeIterator()
        while let ele = iterator.next(){
            ele.removeFromSuperview()
        }
        
        
        let btnTitle = UIButton.init()
        btnTitle.setTitle("请确认以下信息", for: .normal)
        btnTitle.setTitleColor(UIColor.phBlackText, for: .normal)
        btnTitle.titleLabel?.font = UIFont.phBig
        self.addSubview(btnTitle)
        btnTitle.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(SCALE(size: 40))
        }
        
        let reseverdate = self.dateClosure!()
        let formart = DateFormatter.init()
        formart.dateFormat = "yy年MM月dd日"
        let dateString = formart.string(from: reseverdate)
        
        
        let btnResever = UIButton.init()
        btnResever.setTitle("预约时间：\(dateString)", for: .normal)
        btnResever.setTitleColor(UIColor.phBlackText, for: .normal)
        btnResever.titleLabel?.font = UIFont.phBig
        self.addSubview(btnResever)
        btnResever.snp.makeConstraints { (make) in
            make.top.equalTo(btnTitle.snp.bottom).offset(SCALE(size: 10))
            make.left.right.equalToSuperview()
            make.height.equalTo(SCALE(size: 40))
        }
        
        let line1 = UIView.init()
        self.addSubview(line1)
        line1.backgroundColor = UIColor.phBgContent
        line1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(btnResever.snp.bottom).offset(SCALE(size: 5))
        }
        
        
        let tf = PHTextField.init(placeHolder: "请输入手机号", textColor: UIColor.phBlackText, font: UIFont.phBig, textAlignment: .center, leftView: nil, rightView: nil)
        tf.keyboardType = .phonePad
        self.addSubview(tf)
        tf.snp.makeConstraints { (make) in
            
            make.top.equalTo(btnResever.snp.bottom).offset(SCALE(size: 10))
            make.left.right.equalToSuperview()
            make.height.equalTo(SCALE(size: 40))
        }
        
        let line2 = UIView.init()
        self.addSubview(line2)
        line2.backgroundColor = UIColor.phBgContent
        line2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(tf.snp.bottom).offset(SCALE(size: 5))
        }
        
        
        for i in 0...1 {
            let btn : UIButton = UIButton.init()
            self.addSubview(btn)
            btn.setTitle(i==0 ? "取消":"确定", for: .normal)
            btn.setTitleColor(i==0 ? UIColor.phBlackText : UIColor.appTheme, for: .normal)
            btn.titleLabel?.font = UIFont.phBig
            
            let line = UIView.init()
            btn.addSubview(line)
            line.backgroundColor = UIColor.phBgContent
            line.snp.makeConstraints { (make) in
                make.left.top.right.equalToSuperview()
                make.height.equalTo(1)
               
            }
            
            
            btn.snp.makeConstraints { (make) in
                if i == 0{make.left.equalToSuperview()}
                else {make.right.equalToSuperview()}
                
                make.top.equalTo(tf.snp.bottom).offset(SCALE(size: 40))
                make.width.equalToSuperview().multipliedBy(0.5)
                make.height.equalTo(SCALE(size: 50))
                make.bottom.equalToSuperview()
            }
            btn.phAddTarget(events: .touchUpInside) { (sender) in
                if i == 0
                {
                    self.disAppear()
                }
                if i == 1
                {
                    if (self.submitClosure != nil)
                    {
                        self.submitClosure!(tf.text!)
                    }
                    
                }
            }
        }
        
    }
    func appear() {
    
        backView.alpha = 0
        (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        self.reload()
        UIView.animate(withDuration: 0.5, animations: {
            self.backView.alpha = 1
        }) { (completed) in
        }
    }
    func disAppear()  {
        UIView.animate(withDuration: 0.5, animations: {
            self.backView.alpha = 0
        }) { (completed) in
            self.backView.removeFromSuperview()
        }
        
    }

}
