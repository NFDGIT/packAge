//
//  PHLayoutView.swift
//  package
//
//  Created by Admin on 2019/2/20.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PHLayoutView: UIView {
    
    /// 布局对象
    var layout  : PHLayout = PHLayout.init()
    /// 一共有多少个单元
    var numberOfCell:(()->(Int))?
    /// 选择每个单元的回调
    var selectedCell:((Int)->())?
    /// 每个单元的内容
    var cellForIndex:((Int)->(UIView))?
    /// 每个单元的高度
    var heightOfCell:((Int)->(Double))?
   
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func reload()  {        
        var iterator = self.subviews.makeIterator()
        while let ele = iterator.next(){
            ele.removeFromSuperview()
        }
        if  self.layout.type == .collection {
            self.reloadForCollection()
        }else{
            self.reloadForTable()
        }

    }
    private func reloadForTable() {
        
        var temView : UIView?
        for index in 0..<self.numberOfCell!() {
            
            let view = self.cellForIndex!(index)
    
            if view.isKind(of: UIButton.classForCoder())
            {
                (view as! UIButton).phAddTarget(events: .touchUpInside) { (sender) in
                    if self.selectedCell != nil
                    {
                        self.selectedCell!(index)
                    }
                }
            }
            
            // 平均分为某些份
            self.addSubview(view)
            view.snp.makeConstraints { (make) in
                if self.layout.direction == .horizontal {
                    make.left.equalTo(temView == nil ? 0 : (temView?.snp.right)!)
                    make.width.equalToSuperview().dividedBy(self.numberOfCell!())
                    make.height.equalToSuperview()
                    make.top.equalToSuperview()
                }else{
                    make.top.equalTo(temView == nil ? 0 : (temView?.snp.bottom)!)
                    make.height.equalToSuperview().dividedBy(self.numberOfCell!())
                    make.width.equalToSuperview()
                    make.left.equalToSuperview()
                }
            }
            temView = view
        }
        
    }
    private func reloadForCollection()  {
        var leftTem : UIView?
        var topTem : UIView?
        for index in 0..<self.numberOfCell!() {
            
            let view = self.cellForIndex!(index)
            
            if view.isKind(of: UIButton.classForCoder())
            {
                (view as! UIButton).phAddTarget(events: .touchUpInside) { (sender) in
                    if self.selectedCell != nil
                    {
                        self.selectedCell!(index)
                    }
                }
            }
            
            
            self.addSubview(view)
            
            let column = index  % self.layout.column
            
            view.snp.makeConstraints { (make) in
                
                make.left.equalTo(leftTem == nil ? 0 : (leftTem?.snp.right)!)
                make.top.equalTo(topTem == nil ? 0 : ((topTem?.snp.bottom)!))
                make.width.equalToSuperview().dividedBy(self.layout.column)
       
                make.height.equalTo((self.heightOfCell != nil) ? self.heightOfCell!(index) : view.snp.width)
                
                leftTem = view
                if column == self.layout.column-1 {leftTem = nil}
                if column == self.layout.column-1 {topTem = view}
                if index == self.numberOfCell!()-1 {make.bottom.equalToSuperview()}
                
            }
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.reload()
//    }
}


enum PHLayoutDirection {
    case vertical;
    case horizontal
}
enum PHLayoutType {
    case table;
    case collection;
}
class PHLayout: NSObject {
    var type: PHLayoutType = .table
    var direction: PHLayoutDirection = .vertical
    
    var margin: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    var space : CGSize = CGSize.init(width: 0, height: 0)
    var minCellSize : CGSize = CGSize.init(width: 20, height: 20)
    
    var column : Int = 4 // 当type 为 collect 时 才会有效
}
