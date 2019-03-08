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
    static func send(url:String,param:[String:Any]? = nil,response:@escaping ((_ res:(success:Bool,msg:String,data:Dictionary<String, Any>))->(Void)))
    {
        Alamofire.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (res) in
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
    static func upload(url:String,fileUrl:URL,response:@escaping ((_ res:(success:Bool,msg:String,data:Dictionary<String, Any>))->(Void))){
      
        Alamofire.upload(
            //同样采用post表单上传
            multipartFormData: { multipartFormData in
                multipartFormData.append(fileUrl, withName: "file", fileName: "123456.mp4", mimeType: "video/mp4")
                //服务器地址
        },to: url,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //json处理
                upload.responseJSON { res in
                    //解包
//                    guard let result = res.result.value else { return }
       
                    
                    
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
                    
//                    print("json:\(result)")
                }
                //上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("视频上传进度: \(progress.fractionCompleted)")
                }
                
                
            case .failure(let encodingError):
                print(encodingError)
                let resultDic : NSMutableDictionary = NSMutableDictionary.init()
                response((false,"服务器访问失败",resultDic as! Dictionary<String, Any>))
            }
        })
        
        
        
        
    }
}
