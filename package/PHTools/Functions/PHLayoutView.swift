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
//    var heightOfCell:((Int)->(Double))?
    
    
    
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
        
        self.reloadForCollection()


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
            
            let totalColumn = self.layout.column == 0 ? self.numberOfCell!() : self.layout.column
            
            let column = index  % totalColumn
            
//            view.snp.width.
            
            view.snp.makeConstraints { (make) in
                
                make.left.equalTo(leftTem == nil ? 0 : (leftTem?.snp.right)!)
                make.top.equalTo(topTem == nil ? 0 : ((topTem?.snp.bottom)!))
                
                
                
                if index+1 == self.numberOfCell!() {
                    make.bottom.equalToSuperview();
                    
                    if self.layout.column == 0
                    {
                        make.right.equalToSuperview();
                    }
                }
                if self.layout.column != 0{
                    make.width.equalToSuperview().dividedBy(totalColumn)
                }


                
                leftTem = view
                if column == totalColumn-1 {leftTem = nil}
                if column == totalColumn-1 {topTem = view}

                
            }
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.reload()
//    }
}


//enum PHLayoutDirection {
//    case vertical;
//    case horizontal
//}
//enum PHLayoutType {
//    case table;
//    case collection;
//}
class PHLayout: NSObject {
//    var type: PHLayoutType = .table
//    var direction: PHLayoutDirection = .vertical
    
    var margin: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    var space : CGSize = CGSize.init(width: 0, height: 0)
    var minCellSize : CGSize = CGSize.init(width: 20, height: 20)
    
    var isAutoHeight : Bool = false // true 高度 由外部指定 仅对 table 类型有效
    
    var column : Int = 1 // 当type 为 collect 时 才会有效
}
