//
//  NetTool.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetTool: NSObject {
    static func post(url:String,param:[String:Any]? = nil,response:@escaping ((_ res:(success:Bool,msg:String,data:Dictionary<String, Any>))->(Void)))
    {
        Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (res) in
            var resultDic : NSMutableDictionary = NSMutableDictionary.init()

            if res.response?.statusCode == 200
            {
                // parse response
                let json = JSON(res.data as Any)
                resultDic =  NSMutableDictionary.init(dictionary: json.dictionaryObject! as NSDictionary)
                response((true,"服务器访问成功",resultDic as! Dictionary<String, Any>))
            }
            else
            {
                response((false,"服务器访问失败",resultDic as! Dictionary<String, Any>))
            }
        }
    }
}
