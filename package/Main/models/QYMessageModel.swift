//
//  QYMessageModel.swift
//  package
//
//  Created by Admin on 2019/3/5.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class QYMessageModel: NSObject {
    var name : String = ""    // 用户名称
    var content : String = "" // 内容

    
    func getDiction()->Dictionary<String, Any>  {
        let dic : Dictionary = ["name":name,
                                "content":content,

                                ] as [String : Any]
        
        return dic
    }
    convenience init(dic:Dictionary<String, Any>)  {
        self.init()
        
        self.name =      "\(dic["name"] ?? "")"
        self.content =   "\(dic["content"] ?? "")"
        
    }
}
