//
//  LocationViewController.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class LocationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let districtView : PHDistrictView = PHDistrictView.init(frame: CGRect.zero)
        
        
        let itemvalues : [(title:String,url:String)] = [("list",""),("collect","")]
        let layoutView = PHLayoutView.init()
        
        self.view.addSubview(layoutView)
        layoutView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(50)
        }
        layoutView.layout.type = .table
        layoutView.layout.direction = .horizontal
        
        layoutView.numberOfCell = {
            return itemvalues.count
        }
        layoutView.cellForIndex = {index in
            let item = itemvalues[index]
            let btn = UIButton.init(normalTitle: item.title, normalImg:UIImage.init(named: "选中"), normalTextColor: UIColor.phBlackText , font: UIFont.phMiddle)
            return btn
        }
        layoutView.reload()
        layoutView.selectedCell = {index in
            districtView.setType(type: index == 0 ? .list : .collection)
        }
        
        for item in layoutView.subviews {
            (item as! UIButton).phImagePosition(at: .right, space: SCALE(size: 5))
        }
        

        

        self.view.addSubview(districtView)
        districtView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(layoutView.snp.bottom)
        }
  

        
        NetTool.post(url: "https://restapi.amap.com/v3/config/district",param: ["key":"a9370bed5a49fd3a9585ba1db78005da","subdistrict":"2"] ) { (res) -> (Void) in
            if res.success
            {
                
            }
            else
            {
                
            }
            
        }
        // Do any additional setup after loading the view.
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
