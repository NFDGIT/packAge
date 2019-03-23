//
//  QYGoodsModel.swift
//  package
//
//  Created by Admin on 2019/3/6.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYGoodsModel: NSObject {
    var goodsId : String = ""    // 商品id
    var name : String = ""    // 商品名称
    var content : String = "" // 内容
    var avatar : String = "" // 内容
    var price : String = ""  // 价格
    
    var decorationCompany : String = "" // 装修公司
    var decorationCompanyDesc : String = "" // 公司描述
    var phone : String = "" // 手机号
    
    var style : String = ""     // 风格
    var type : String = "" // 户型
    
    
    
    var imgs : Array<Dictionary<String,Any>> = Array.init()
    
    func getDiction()->Dictionary<String, Any>  {
        let dic : Dictionary = [
                                "goodsId":goodsId,
                                "name":name,
                                "content":content,
                                "avatar":avatar,
                                "price":price,
                                "decorationCompanyDesc":decorationCompanyDesc,
                                "decorationCompany":decorationCompany,
                                "phone":phone,
                                "style":style,
                                "type":type,
                                "imgs":imgs,
                                ] as [String : Any]
        
        return dic
    }
    convenience init(dic:Dictionary<String, Any>)  {
        self.init()
        self.goodsId =      "\(dic["goodsId"] ?? "")"
        self.name =      "\(dic["name"] ?? "")"
        self.content =   "\(dic["content"] ?? "")"
        self.avatar =    "\(dic["avatar"] ?? "")"
        self.price =   "\(dic["price"] ?? "")"
        
        self.decorationCompanyDesc =    "\(dic["decorationCompanyDesc"] ?? "")"
        self.decorationCompany =   "\(dic["decorationCompany"] ?? "")"
        self.phone =    "\(dic["phone"] ?? "")"
        self.style =   "\(dic["style"] ?? "")"
        self.type =    "\(dic["type"] ?? "")"
        
        if  dic.keys.contains("imgs") {
            self.imgs =      (dic["imgs"] as! Array<Dictionary<String, Any>>)
        }

        
    }
}
