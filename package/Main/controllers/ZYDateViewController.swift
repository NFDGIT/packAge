//
//  DateViewController.swift
//  package
//
//  Created by Admin on 2019/2/21.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYDateViewController: BaseViewController ,UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    let btnTitle  = UIButton.init()
    var selectedDate:((Date)->())?
    
    
    let pageVC = UIPageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        self.refreshBtnTitle()
        
        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        self.navigationItem.title = "选择日期"
    }
    override func initUI() {
        super.initUI()
        
        btnTitle.setTitleColor(UIColor.phBlackText, for: .normal)
        btnTitle.titleLabel?.font = UIFont.phBig
        self.view.addSubview(btnTitle)
        btnTitle.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        
        
        let titles : Array<String> = ["日","一","二","三","四","五","六"]
        let titleView : PHLayoutView = PHLayoutView.init()
        self.view.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(btnTitle.snp.bottom)
            make.height.equalTo(SCALE(size: 40))
        }
        

        titleView.numberOfCell = {
            return titles.count
        }
        titleView.cellForIndex = {index in
            let btn = UIButton.init()
            btn.setTitleColor(UIColor.phBlackText, for: .normal)
            btn.setTitle("\(titles[index])", for: .normal)
            return btn
        }
        
        titleView.reload()
        
        
        self.addChildViewController(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        pageVC.setViewControllers([getDateItemVC(year: 2019, month: 3)], direction: .forward, animated: true) { (completed) in
            
        }
        
        pageVC.delegate = self
        pageVC.dataSource = self
    
        
    }
    
    func getBeforeMonth(year:Int,month:Int) -> (year:Int,month:Int) {
        var resultYear : Int = 0
        var resultMonth : Int  = 0
        
        if month <= 1
        {
            resultMonth = 12
            resultYear = year - 1
        }
        else
        {
            resultMonth = month - 1
            resultYear = year
        }
        return (resultYear,resultMonth)
    }
    func getAfterMonth(year:Int,month:Int) -> (year:Int,month:Int) {
        var resultYear : Int = 0
        var resultMonth : Int  = 0
        
        if month >= 12
        {
            resultMonth = 1
            resultYear = year + 1
        }
        else
        {
            resultMonth = month + 1
            resultYear = year
        }
        return (resultYear,resultMonth)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func refreshBtnTitle()  {
        btnTitle.setTitle(
            """
            \((pageVC.viewControllers?.first as! ZYDateItemViewController).year)年\((pageVC.viewControllers?.first as! ZYDateItemViewController).month)月
            """, for: .normal)
    }
}
extension ZYDateViewController{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
  
        let year = self.getBeforeMonth(year: (viewController as! ZYDateItemViewController).year, month: (viewController as! ZYDateItemViewController).month).year
        let month = self.getBeforeMonth(year: (viewController as! ZYDateItemViewController).year, month: (viewController as! ZYDateItemViewController).month).month
        return getDateItemVC(year: year, month: month)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let year = self.getAfterMonth(year: (viewController as! ZYDateItemViewController).year, month: (viewController as! ZYDateItemViewController).month).year
        let month = self.getAfterMonth(year: (viewController as! ZYDateItemViewController).year, month: (viewController as! ZYDateItemViewController).month).month
        return getDateItemVC(year: year, month: month)
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        
        
        self.refreshBtnTitle();
        
//        btnTitle.setTitle(
//            """
//            \((pageViewController.viewControllers?.first as! QYDateItemViewController).year)/\((pageViewController.viewControllers?.first as! QYDateItemViewController).month)
//            """, for: .normal)
        

    }
    func getDateItemVC(year:Int,month:Int) -> ZYDateItemViewController{
        let datevc = ZYDateItemViewController.init()
        datevc.year=year
        datevc.month = month
        datevc.selectedDate = {date in
            if (self.selectedDate != nil)
            {
                self.selectedDate!(date)
            }
        }
        
        return datevc
    }
    
  
}
