//
//  DateViewController.swift
//  package
//
//  Created by Admin on 2019/2/21.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DateViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        
        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        self.navigationItem.title = "选择档期"
    }
    override func initUI() {
        super.initUI()
        
        let btnTitle : UIButton = UIButton.init(normalTitle: "0", normalTextColor: UIColor.phBlackText, font: UIFont.phBig)
        self.view.addSubview(btnTitle)
        btnTitle.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        
        let carouse : PHCarouselView = PHCarouselView.init(direction: .horizontal)
        self.view.addSubview(carouse)
        carouse.snp.makeConstraints { (make) in
            make.top.equalTo(btnTitle.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        
        
        let month  = 1
        let year = 2019
        
        
        
        carouse.currentPage = month-1
        carouse.numberCell = {
            return 12
        }
        
        carouse.cellForIndex = { index in
            
            
            let calenday =  PHCalendarView.init()
            calenday.currentYear = year
            calenday.currentMonth = index + 1
            
            
            
            calenday.initUI()
            calenday.reload()
            
            return calenday
        }
        
        carouse.didEndScroll = {(currentIndex,beforeIndex) in
            btnTitle.setTitle("\(year)/\(currentIndex + 1)", for: .normal)
        }
        
        carouse.reload()
        
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
