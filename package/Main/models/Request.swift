//
//  Request.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON

let baseUrl = "https://nfdgit.github.io/apis/ccc/"
let baseUrl1 = "http://47.95.242.241/zis/"

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
        NetTool.send(url: "\(baseUrl)jsons/message.json") { (res) -> (Void) in
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
        NetTool.send(url: "\(baseUrl)jsons/carousel.json") { (res) -> (Void) in
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
        NetTool.send(url: "\(baseUrl)jsons/goods.json") { (res) -> (Void) in
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
        NetTool.send(url: "\(baseUrl)jsons/news.json") { (res) -> (Void) in
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
                response(false,"加入失败，已预约过",Dictionary.init())
            }
            else
            {
                Request.reserverList.append(goodsId)
                Request.reserverList = Request.reserverList
                response(true,"加入成功",Dictionary.init())
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
    static func deleteServer(goodsIds:[String], response:@escaping (_ success:Bool,_ msg:String,_ data:Array<Any>)->(Void)){
        for goodsid in goodsIds
        {
            Request.reserverList = Request.reserverList.filter({ (string) -> Bool in
                return string != goodsid
            })
        }
        Request.reserverList = Request.reserverList
        response(true,"下单成功",[])
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

// MARK: - 订单
extension Request{
    static func palceOrder(goodsId:String,userId:String,num:String,name:String,address:String,tel:String, response:@escaping (_ success:Bool,_ msg:String,_ data:Dictionary<String,Any>)->(Void))  {
        
    
        NetTool.send(url: "\(baseUrl1)submit.php",
                     param: ["wu_id":goodsId,
                             "user_id":userId,
                             "num":num,
                             "name":name,
                             "address":address,
                             "tel":tel]) { (res) -> (Void) in
                                
                                
                                if  res.success {
                                    let code : Int  = res.data["code"] as! Int
                                    if code == 0
                                    {
                                        response(false,"失败",Dictionary.init())
                                        
                                    }else if code == 1
                                    {
                                        response(true,"成功",res.data)

                                    }else if code == 2
                                    {
                                        response(false,"信息录入不完整",Dictionary.init())
                                    }else{
                                        response(false,"未知错误",Dictionary.init())
                                    }
                                    
                                    
                                }else{
                                    response(res.success,res.msg,res.data)
                                }
        }
        
        
        
    }
    static func getOrderList(userId:String, response:@escaping (_ success:Bool,_ msg:String,_ data:Array<Dictionary<String,Any>>)->(Void))  {
        
        
        NetTool.send(url: "\(baseUrl1)myorders.php",
                     param: ["user_id":userId]) { (res) -> (Void) in
                                
                        
                                if  res.success {
                                    let code : Int  = res.data["code"] as! Int
                                    if code == 0
                                    {
                                        response(false,"失败",Array.init())
                                        
                                    }else if code == 1
                                    {
                                        response(true,"成功",res.data["list"] as! Array<Dictionary<String, Any>>)

                                    }else if code == 2
                                    {
                                        response(false,"信息录入不完整",Array.init())
                                    }else{
                                        response(false,"未知错误",Array.init())
                                    }
                                    
                                    
                                }else{
                                    response(res.success,res.msg,Array.init())
                                }
        }
        
        
        
    }
    static func cancelOrder(orderId:String, response:@escaping (_ success:Bool,_ msg:String,_ data:Dictionary<String,Any>)->(Void))  {
        
        
        NetTool.send(url: "\(baseUrl1)channel.php",
        param: ["orders_id":orderId]) { (res) -> (Void) in
            
            
            if  res.success {
                let code : Int  = res.data["code"] as! Int
                if code == 0
                {
                    response(false,"失败",Dictionary.init())
                    
                }else if code == 1
                {
                    response(true,"成功",res.data)
                    
                }else if code == 2
                {
                    response(false,"信息录入不完整",Dictionary.init())
                }else{
                    response(false,"未知错误",Dictionary.init())
                }
                
                
            }else{
                response(res.success,res.msg,Dictionary.init())
            }
        }
        
        
        
    }


}

// MARK: - 用户管理
extension Request{
    static func getLocalUserInfo() -> Dictionary<String, Any>{
        var userinfo : Dictionary<String, Any> = Dictionary.init()
        if  (UserDefaults.standard.value(forKey: "userInfo") != nil) {
            userinfo = UserDefaults.standard.value(forKey: "userInfo") as! Dictionary<String, Any>
        }
        
        return userinfo
    }
    static func setLocalUserInfo(userInfo:Dictionary<String,Any>) {
        UserDefaults.standard.set(userInfo, forKey: "userInfo")
    }
    
    
    static func login(username:String,pwd:String, response:@escaping (_ success:Bool,_ msg:String,_ data:Dictionary<String,Any>)->(Void))  {
        
        NetTool.send(url: "\(baseUrl1)login.php",
                     param: ["user_username":username,
                             "user_pwd":pwd]) { (res) -> (Void) in

            
                    
                                if  res.success {
                                    let code : Int  = res.data["code"] as! Int
                                    if code == 0
                                    {
                                        response(false,"失败",Dictionary.init())
                                        
                                    }else if code == 1
                                    {
                                        response(true,"成功",res.data)
                                        Request.setLocalUserInfo(userInfo: res.data["user"] as! Dictionary<String, Any>)
                                    }else if code == 2
                                    {
                                        response(false,"信息录入不完整",Dictionary.init())
                                    }else if code == 3
                                    {
                                        response(false,"密码不正确",Dictionary.init())
                                    }else{
                                        response(false,"未知错误",Dictionary.init())
                                    }


                                }else{
                                    response(res.success,res.msg,res.data)
                                }
        }
        
        
        
    }
    static func register(username:String,pwd:String,email:String, response:@escaping (_ success:Bool,_ msg:String,_ data:Dictionary<String,Any>)->(Void))  {
        
        NetTool.send(url: "\(baseUrl1)register.php",
                     param: ["user_username":username,
                             "user_pwd":pwd,
                             "user_email":email]) { (res) -> (Void) in
                                
                                if  res.success {
                                    let code : Int  = res.data["code"] as! Int
                                    if code == 0
                                    {
                                        response(false,"失败",res.data)
                                        
                                    }else if code == 1
                                    {
                                        response(true,"成功",res.data)

                                    }else if code == 2
                                    {
                                        response(false,"信息录入不完整",res.data)
                                    }else if code == 3
                                    {
                                        response(false,"用户已存在",res.data)
                                    }else{
                                        response(false,"未知错误",res.data)
                                    }
                                    
                                    
                                }else{
                                    response(res.success,res.msg,res.data)
                                }
        }
        
        
        
    }
    
}

