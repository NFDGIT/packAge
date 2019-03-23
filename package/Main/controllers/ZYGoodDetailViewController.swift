//
//  QYGoodDetailViewController.swift
//  package
//
//  Created by Admin on 2019/3/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYGoodDetailViewController: BaseViewController {

    var model : ZYGoodsModel?
    let page : PHPageViewController = PHPageViewController()
    
    
    var titles = [(title:"详情页",img:"",selected:true),(title:"评论",img:"",selected:false)]
    let layoutTitle = PHLayoutView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNavi()
        self.initUI()

        
        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        self.title = "\(model?.name ?? "")"
    }
    override func initUI() {
        super.initUI()

        
        

        self.view.addSubview(layoutTitle)
        layoutTitle.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(SCALE(size: 50))
        }

        layoutTitle.layout.column = 2
        layoutTitle.layout.isAutoHeight = true
        
        layoutTitle.numberOfCell = {return self.titles.count}
        layoutTitle.cellForIndex = {index in
            let  btn = UIButton.init()
            btn.setTitleColor(UIColor.phBlackText, for: .normal)
            btn.setTitleColor(UIColor.appTheme, for: .selected)
            
            btn.titleLabel?.font = UIFont.phMiddle
            btn.setTitle(self.titles[index].title, for: .normal)
            
            btn.isSelected = self.titles[index].selected
            
            btn.snp.makeConstraints({ (make) in
                make.height.equalTo(SCALE(size: 50))
            })
            return btn
        }

        layoutTitle.selectedCell = {index in
//            self.page
            self.selectCategory(page: index)
            self.page.setPage(page: index)
        }
        layoutTitle.reload()
        
        
        

        page.numberOfViewController = {return 2}
        page.viewControllerForPage = {page in
            if page == 0
            {
                let detail = ZYDetailViewController.init()
                detail.model = self.model!
                return detail
            }else{
                let message =  ZYCommentViewController.init()
                return message
            }
        }
        
        self.addChildViewController(page)
        self.view.addSubview(page.view)
        page.view.snp.makeConstraints { (make) in
            make.top.equalTo(layoutTitle.snp.bottom)
            make.left.bottom.right.equalToSuperview()

        }
   
        
        
        
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
extension ZYGoodDetailViewController{
    func selectCategory(page:Int){
        let temcategoryvalues = self.titles
        for (inde,value)  in temcategoryvalues.enumerated() {
            
            var temvalue = value
            temvalue.selected = false
            if inde == page{temvalue.selected = true}
            
            self.titles[inde] = temvalue
        }
        self.layoutTitle.reload()
    }
}
