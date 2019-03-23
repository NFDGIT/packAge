//
//  QYCategoryViewController.swift
//  package
//
//  Created by Admin on 2019/3/10.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYCategoryViewController: BaseViewController {
    
    var categoryvalues = [(type:"餐具套装",selected:true),(type:"饭盒",selected:false),(type:"不粘锅",selected:false),(type:"碗碟",selected:false),(type:"筷子",selected:false)]
    let categoryView = PHLayoutView.init()
    let pagevc = PHPageViewController.init()
    
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()

        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        self.navigationItem.title = "分类"
    }
    override func initUI() {
        super.initUI()
        

   
        
        
        
        
        
        
        
        

        pagevc.navigationOrientation = .horizontal
        pagevc.numberOfViewController = {return self.categoryvalues.count}
        pagevc.viewControllerForPage = {page in
            let item = ZYCategoryItemViewController.init()
            item.type = self.categoryvalues[page].type
            return  item
        }
        pagevc.finishTransitionCallBack = {page in
//            self.view.makeToast("\(page)",position:.center)
//            self.categoryView.selectedCell!(page)
            self.selectCategory(page: page)
        }
        self.addChildViewController(pagevc)
        self.view.addSubview(pagevc.view)
        pagevc.view.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
        }

        
        
        
        
        
        
        
        
        
        
        let layoutCategoryBg = UIScrollView.init()
        self.view.addSubview(layoutCategoryBg)
        layoutCategoryBg.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(SCALE(size: 60))
            make.bottom.equalTo(pagevc.view.snp.top)
            
        }
        
        layoutCategoryBg.layer.shadowOpacity = 0.5
        layoutCategoryBg.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        layoutCategoryBg.layer.shadowColor = UIColor.lightGray.cgColor
        
        
        
        layoutCategoryBg.addSubview(categoryView)
        categoryView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
//            make.width.equalToSuperview()
        }
        categoryView.layout.isAutoHeight = true
        categoryView.layout.column = 0
        categoryView.numberOfCell = {return self.categoryvalues.count}
        categoryView.cellForIndex = {index in
            
            
            let btnback = UIButton.init()

            
            let btn =  UIButton.init()
            btn.isUserInteractionEnabled = false
            btnback.addSubview(btn)
            
            btn.setTitleColor(UIColor.phBlackText, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            
            btn.setBackgroundImage(UIImage.phInit(color: UIColor.phBgContent), for: .normal)
            btn.setBackgroundImage(UIImage.phInit(color: UIColor.appTheme), for: .selected)
            
            
            btn.setTitle(self.categoryvalues[index].type, for: .normal)
            
            //            btn.phLayer(cornerRadius: 5, borderWidth: 0)
            btn.layer.cornerRadius = 4
            btn.layer.masksToBounds = true

            btn.titleLabel?.font = UIFont.phMiddle
            btn.setTitle(self.categoryvalues[index].type, for: .normal)
            btn.sizeToFit()
            
            btn.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(SCALE(size: 20))
                make.top.equalToSuperview().offset(SCALE(size: 10))
                make.right.bottom.equalToSuperview().offset(SCALE(size: -10))
                
                make.height.equalTo(30)
                make.width.equalTo(btn.frame.width+10)
            })
            
            
            btnback.snp.makeConstraints({ (make) in
//                make.height.equalTo(SCALE(size: 60))
                
            })
            
            
            btn.isSelected = self.categoryvalues[index].selected
            return btnback
            
        }
        categoryView.selectedCell = {index in
            self.selectCategory(page: index)
            
            self.pagevc.pageVC?.setViewControllers([self.pagevc.getVC(page: index)!], direction: .forward, animated: false, completion: nil)
        }
        categoryView.reload()
     
    }
    
    func selectCategory(page:Int){
        let temcategoryvalues = self.categoryvalues
        for (inde,value)  in temcategoryvalues.enumerated() {
            
            var temvalue = value
            temvalue.selected = false
            if inde == page{temvalue.selected = true}
            
            categoryvalues[inde] = temvalue
        }
        self.categoryView.reload()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
