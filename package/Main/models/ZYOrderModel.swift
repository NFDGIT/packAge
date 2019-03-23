//
//  QYOrderModel.swift
//  package
//
//  Created by Admin on 2019/3/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYOrderModel: NSObject {
    var orders_id : String = ""    // 编号
    var orders_outtradeno : String = ""    // 订单号
    var orders_wuid : String = "" // 就是wu_id
    var orders_userid : String = "" // userid
    var orders_name : String = ""  // 姓名
    
    var orders_address : String = "" // 地址
    var orders_tel : String = "" // 电话
    var orders_date : String = "" // 下单日期

    
    
    
    var imgs : Array<Dictionary<String,Any>> = Array.init()
    
    func getDiction()->Dictionary<String, Any>  {
        let dic : Dictionary = [
            "orders_id":orders_id,
            "orders_outtradeno":orders_outtradeno,
            "orders_wuid":orders_wuid,
            "orders_userid":orders_userid,
            "orders_name":orders_name,
            "orders_address":orders_address,
            "orders_tel":orders_tel,
            "orders_date":orders_date,
            ] as [String : Any]
        
        return dic
    }
    convenience init(dic:Dictionary<String, Any>)  {
        self.init()
        self.orders_id =      "\(dic["orders_id"] ?? "")"
        self.orders_outtradeno =      "\(dic["orders_outtradeno"] ?? "")"
        self.orders_wuid =   "\(dic["orders_wuid"] ?? "")"
        self.orders_name =    "\(dic["orders_name"] ?? "")"
        self.orders_address =   "\(dic["orders_address"] ?? "")"
        
        self.orders_tel =    "\(dic["orders_tel"] ?? "")"
        self.orders_date =   "\(dic["orders_date"] ?? "")"
    }
}
