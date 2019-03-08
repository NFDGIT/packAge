//
//  Request.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON

let baseUrl = "https://nfdgit.github.io/jsons/"

class Request: NSObject {
    private static var _reserverList : Array<String>?
    static var reserverList : Array<String>{
        get{
            if _reserverList == nil
            {
                if UserDefaults.standard.value(forKey: "reserverList") == nil {
                    let datas : Array<String> = Array.init()

                    _reserverList = datas
                }else{
                    _reserverList = (UserDefaults.standard.value(forKey: "reserverList") as! Array<String>)
                }
            }
            if _reserverList == nil
            {
                let datas : Array<String> = Array.init()
      
                _reserverList = datas
            }
    
            return _reserverList!
        }
        set{
            _reserverList = newValue
            UserDefaults.standard.set(_reserverList, forKey: "reserverList")
        }
    }

    
    
    
    
    
    static func getDistrict()
    {
        
    }
    
    
    




    static func getAboutUs(response:@escaping (_ success:Bool,_ msg:String,_ data:Dictionary<String,Any>)->(Void)){
        
        NetTool.post(url: "http://47.95.242.241/zis/letus.php") { (res) -> (Void) in
            if res.success
            {
                response(true,"获取成功",res.data)
            }
            else{
                response(false,"网络连接失败",Dictionary.init())
            }
        }
    }
    
    
    static func getMessage(response:@escaping (_ success:Bool,_ msg:String,_ data:Array<Any>)->(Void)){
        NetTool.send(url: "\(baseUrl)message.json") { (res) -> (Void) in
            if res.success {
                let success : Bool = res.data["success"] as! Bool
                let message : String = res.data["message"] as! String
                let data : Array<Dictionary<String, Any>> = res.data["data"] as! Array<Dictionary<String, Any>>
                
                response(success,message,data)
            }
            else
            {
                response(res.success,res.msg,Array.init())
            }
            
        }
    }
    static func getCarousel(response:@escaping (_ success:Bool,_ msg:String,_ data:Array<Any>)->(Void)){
        NetTool.send(url: "\(baseUrl)carousel.json") { (res) -> (Void) in
            if res.success {
                let success : Bool = res.data["success"] as! Bool
                let message : String = res.data["message"] as! String
                let data : Array<Dictionary<String, Any>> = res.data["data"] as! Array<Dictionary<String, Any>>
                
                response(success,message,data)
            }
            else
            {
                response(res.success,res.msg,Array.init())
            }
            
        }
    }

    static func getGoods(response:@escaping (_ success:Bool,_ msg:String,_ data:Array<Any>)->(Void)){
        NetTool.send(url: "\(baseUrl)goods.json") { (res) -> (Void) in
            if res.success {
                let success : Bool = res.data["success"] as! Bool
                let message : String = res.data["message"] as! String
                let data : Array<Dictionary<String, Any>> = res.data["data"] as! Array<Dictionary<String, Any>>
                
                response(success,message,data)
            }
            else
            {
                response(res.success,res.msg,Array.init())
            }
            
        }
    }

    static func getNews(response:@escaping (_ success:Bool,_ msg:String,_ data:Array<Any>)->(Void)){
        NetTool.send(url: "\(baseUrl)news.json") { (res) -> (Void) in
            if res.success {
                let success : Bool = res.data["success"] as! Bool
                let message : String = res.data["message"] as! String
            let data : Array<Dictionary<String, Any>> = res.data["data"] as! Array<Dictionary<String, Any>>
                
                
                response(success,message,data)
            }
            else
            {
                response(res.success,res.msg,Array.init())
            }
            
        }
    }
    static func addServer(goodsId:String, response:@escaping (_ success:Bool,_ msg:String,_ data:Dictionary<String,Any>)->(Void)){
        Request.judgeIsServer(goodsId: goodsId) { (success, msg, data) -> (Void) in
            
            if success {
                response(false,"预约失败，已预约过",Dictionary.init())
            }
            else
            {
                Request.reserverList.append(goodsId)
                Request.reserverList = Request.reserverList
                response(true,"预约成功",Dictionary.init())
            }
            
        }
    }
    static func judgeIsServer(goodsId:String, response:@escaping (_ success:Bool,_ msg:String,_ data:Dictionary<String,Any>)->(Void)){
        for reserver in reserverList {
            if goodsId == reserver
            {
                response(true,"该商品已预约",Dictionary.init())
                return
            }
        }
        response(false,"该商品没有预约",Dictionary.init())
    }
    static func deleteServer(goodsId:String, response:@escaping (_ success:Bool,_ msg:String,_ data:Array<Any>)->(Void)){
        
    }
    
}
extension NSObject {
    func phGet(key:String) -> Any{
        struct strut{
            static var key: String = ""
        }
        strut.key = key
        let value = objc_getAssociatedObject(self, &strut.key)
        return value as Any
    }
    func phSet(key:String,value:Any){
        struct strut{
            static var key: String = ""
        }
        strut.key = key
        objc_setAssociatedObject(self, &strut.key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }
    
    
    
}


