//
//  PHCarouselView.swift
//  package
//
//  Created by Admin on 2019/2/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
enum PHCarouselViewDirection {
    case vertical;
    case horizontal
}
enum PHCarouselViewTransformDirection {
    case after;
    case before
}
class PHCarouselView: UIView ,UIScrollViewDelegate{
    var cellForIndex:((NSInteger)->(UIView))?
    var numberCell:(()->(NSInteger))?
    var selectedCell:((NSInteger)->())?

    
    var didEndScroll:((_ currentPage:NSInteger,_ beforePage:NSInteger)->())?
    
    
    
    var direction : PHCarouselViewDirection = .horizontal
    let scrollView : UIScrollView = UIScrollView.init()
    let pageControl : UIPageControl = UIPageControl.init()
    var currentPage : Int = 0

    private var leftView : UIView?
    private var middleView : UIView?
    private var rightView : UIView?
    private var timer : Timer?

    convenience init() {
        self.init(direction: .horizontal)
  
    }
    
    init(direction scrollDirection:PHCarouselViewDirection) {
        super.init(frame: CGRect.zero)
        direction = scrollDirection
        self.backgroundColor = UIColor.white
        self.initUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initUI(){
    
        self.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        var temView : UIView?
        for i in 0...2 {
            let view : UIView = UIView.init()
            scrollView.addSubview(view)
            
            view.snp.makeConstraints { (make) in
                make.width.height.equalToSuperview()
                
                if direction == .horizontal{make.top.equalToSuperview()}
                else{make.left.equalToSuperview()}
                if i == 2 {
                    if direction == .horizontal{ make.right.equalToSuperview()}
                    else{make.bottom.equalToSuperview()}
                }
                
                if temView == nil {
                    if direction == .horizontal{ make.left.equalTo(0)}
                    else{make.top.equalTo(0)}
                    
                    
                }
                else{
                    if direction == .horizontal{ make.left.equalTo((temView?.snp.right)!)}
                    else{make.top.equalTo((temView?.snp.bottom)!)}
                }
                temView = view

            }
            if i == 0 {leftView = view}
            if i == 1 {middleView = view
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(selectCell))
                middleView?.addGestureRecognizer(tap)
                
            }
            if i == 2 {rightView = view}
        }
        
        
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    // 根据 当前索引 刷新界面数据
    func reload()  {

        for view in scrollView.subviews {
            var iterator = view.subviews.makeIterator()
            while let ele = iterator.next(){
               ele.removeFromSuperview()
            }
        }
        
        
        var middleItem : UIView  = UIView.init()


        var rightItem : UIView =  UIView.init()

        var leftItem : UIView =  UIView.init()
   
        if self.numberCell!() != 0{
            middleItem = self.cellForIndex!(getValidPage(page: currentPage))
            rightItem = self.cellForIndex!(getValidPage(page: currentPage+1))
            leftItem = self.cellForIndex!(getValidPage(page: currentPage-1))
        }
        
        
        middleItem.isUserInteractionEnabled = false
        rightItem.isUserInteractionEnabled = false
        leftItem.isUserInteractionEnabled = false
        
        leftView!.addSubview(leftItem)
        leftItem.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        rightView!.addSubview(rightItem)
        rightItem.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        middleView!.addSubview(middleItem)
        middleItem.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        pageControl.numberOfPages = self.numberCell!()
        pageControl.currentPage = currentPage
        
        scrollView.contentOffset = CGPoint.init(x: direction == .horizontal ? scrollView.frame.width : 0, y: direction == .horizontal ? 0 : scrollView.frame.height)
    }
    
    /// 开始 自动滚动
    func startAutoScroll() {
      
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { (timer) in
                UIView.animate(withDuration: 1, animations: {
                    
                    self.scrollView.contentOffset = CGPoint.init(x: (self.direction == .horizontal ? self.scrollView.frame.width*2 : 0), y: (self.direction == .horizontal ? 0 : self.scrollView.frame.height * 2 ))
                }, completion: { (completed) in
                    self.endScroll()
                })
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    /// 结束自动滚动
    func stopAutoScroll()  {
        timer?.invalidate()
    }
    
    /// 滚动结束  计算 当前 索引
    func endScroll()  {
        if direction == .horizontal && scrollView.contentOffset.x == scrollView.frame.width {
            return
        }
        if direction == .vertical && scrollView.contentOffset.y == scrollView.frame.height {
            return
        }
        
        let beforePage = currentPage // 之前的 页码
        let offset = direction == .horizontal ? scrollView.contentOffset.x :  scrollView.contentOffset.y
        if offset == 0{
            currentPage -= 1
        }else{
            currentPage += 1
        }
        currentPage = getValidPage(page: currentPage)
    

        if self.didEndScroll != nil{ // 滚动结束的回调
            self.didEndScroll!(self.currentPage,beforePage)
        }
    
        self.reload()
    }
    func getValidPage(page:Int) -> Int  {
        var validPage = page
    
        if page > self.numberCell!()-1 {validPage = 0}
        if page < 0 {validPage = self.numberCell!() - 1}
        return validPage
    }
    @objc func selectCell() {
        if (selectedCell != nil)  {
            selectedCell!(currentPage)
        }
    }
    
    
    
}
extension PHCarouselView{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.endScroll()
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
extension UIView{
    func copyView(view:UIView) -> UIView {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: view)) as! UIView
    }
}


