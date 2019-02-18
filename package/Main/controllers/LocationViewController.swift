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
        
        let top = PHTabbarView.init()
        self.view.addSubview(top)
        top.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(50)
        }
        top.datas = [UIButton.init(normalTitle: "list", normalTextColor: UIColor.phBlackText, font: UIFont.phBig),UIButton.init(normalTitle: "collect", normalTextColor: UIColor.phBlackText, font: UIFont.phBig)]
        top.callBack = { index in
            districtView.setType(type: index == 0 ? .list : .collection)
        }
        
        

        self.view.addSubview(districtView)
        districtView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(top.snp.bottom)
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
