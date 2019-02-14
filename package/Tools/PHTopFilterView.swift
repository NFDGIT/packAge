//
//  PHTopFilterView.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PHTopFilterView: UIView {
    var callBack:((Int)->())?
    
    private var _selectedIndex : Int = 0
    var selectedIndex : Int{
        get{
            return _selectedIndex
        }
        set{
            _selectedIndex = newValue
            self.refreshBtn()
        }
        
    }
    private var _datas : [UIButton]?
    var datas:[UIButton]?{
        get{
            return _datas
        }
        set{
            _datas = newValue
            self.refreshUI()
        }
    }
    

    init() {
       super.init(frame: CGRect.zero)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func refreshUI() {
        for item in self.subviews {
            item.removeFromSuperview()
        }
        
        var temBtn : UIButton?
        for (index, btn) in (self.datas?.enumerated())! {
            self.addSubview(btn)
            btn.tag = 100 + index
            btn.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.height.equalToSuperview()
                make.width.equalToSuperview().dividedBy(self.datas!.count)
                make.left.equalTo(temBtn == nil ? 0 : (temBtn?.snp.right)!)
            }
            temBtn = btn
            btn.addTarget(events: .touchUpInside) { (sender) in
                self.selectedIndex = sender.tag - 100
                self.callBack!(self.selectedIndex)
            }
        }
    }
    func refreshBtn() {
        for item in self.subviews {
            (item as! UIButton).isSelected = item.tag - 100 == selectedIndex
        }
    }
}
