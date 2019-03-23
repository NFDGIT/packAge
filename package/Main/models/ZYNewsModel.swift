//
//  QYNewsModel.swift
//  package
//
//  Created by Admin on 2019/3/6.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYNewsModel: NSObject {

    var name : String = ""    // 用户名称
    var content : String = "" // 内容
    var avatar : String = "" // 内容
    var imgs : Array<Dictionary<String,Any>> = Array.init()
    
    func getDiction()->Dictionary<String, Any>  {
        let dic : Dictionary = ["name":name,
                                "content":content,
                                "avatar":avatar,
                                "imgs":imgs,
                                ] as [String : Any]
        
        return dic
    }
    convenience init(dic:Dictionary<String, Any>)  {
        self.init()
    
        self.name =      "\(dic["name"] ?? "")"
        self.content =   "\(dic["content"] ?? "")"
        self.avatar =    "\(dic["avatar"] ?? "")"
        self.imgs =      (dic["imgs"] as! Array<Dictionary<String, Any>>)
    
    }
}
