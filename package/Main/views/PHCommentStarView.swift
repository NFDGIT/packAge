//
//  PHCommentStarView.swift
//  package
//
//  Created by Admin on 2019/3/13.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PHCommentStarView: UIView {
    var _rank : Int = 1
    var rank : Int {
        get{
            return _rank
        }
        set{
            _rank = newValue
            if _rank > 10  {
                _rank = 10
            }
            if _rank < 1
            {
                _rank = 1
            }
            self.refreshUI()
            
        }
    }
    
    
    init() {
        super.init(frame: CGRect.zero)
        self.initUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        
        
        var temView : UIView?
        for index in 0..<10 {
            let btn : UIButton = UIButton.init()
            btn.setImage(UIImage.init(named: "星星"), for: .normal)
            btn.setImage(UIImage.init(named: "星星1"), for: .selected)
            btn.tag = index + 100
            self.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                if temView == nil
                {
                    make.left.equalTo(SCALE(size: 0))
                }else
                {
                    make.left.equalTo((temView?.snp.right)!).offset(SCALE(size: 5))
                }
                make.top.equalToSuperview()
                make.height.width.equalTo(SCALE(size: 20))
                if index == 9
                {
                    make.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                }

                
                temView = btn
            }

        }
    }
    func refreshUI(){
        for index  in 0..<10 {
            let btn : UIButton = self.viewWithTag(100 + index) as! UIButton
            btn.isSelected = index < rank
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
