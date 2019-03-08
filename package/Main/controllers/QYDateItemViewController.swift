//
//  QYDateItemViewController.swift
//  package
//
//  Created by Admin on 2019/3/6.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class QYDateItemViewController: BaseViewController {
    var year : Int = 2019
    var month : Int = 1
    
    var selectedDate:((Date)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()


        
        // Do any additional setup after loading the view.
    }
    override func initUI() {
        super.initUI()
        self.view.backgroundColor = UIColor.white
        
        
        let  calendar : PHCalendarView = PHCalendarView.init()
        calendar.currentYear = year
        calendar.currentMonth = month
        self.view.addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
        }
    
//        calendar.initUI()
        calendar.cellForDate = {date in
            let btn  : UIButton =   UIButton.init(normalTitle: "\(date.components?.day ?? 0)", normalTextColor: UIColor.phBlackText, font: UIFont.phBig)
            if date.components?.month != calendar.currentMonth
            {
                btn.setTitleColor(UIColor.phLightGrayText, for: .normal)
                btn.isUserInteractionEnabled = false
                btn.isHidden = true
            }
            
//            if index < (components.weekday! - 1){btn.isHidden = true}
            
            btn.phLayer(cornerRadius: UIScreen.main.bounds.width/14, borderWidth:0 )
            btn.setBackgroundImage(UIImage.phInit(color: UIColor.appTheme), for: .highlighted)
            return btn
        }
        calendar.selectedCell = {index in
            let date : Date = PHCalendarView.getDate(year: calendar.currentYear, month: calendar.currentMonth, day: index)
            if (self.selectedDate != nil)
            {
                self.selectedDate!(date)
            }
            
        }
        calendar.reload()
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
