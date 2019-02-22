//
//  Request.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserInfo : NSObject {
    var userId : String = ""  // 用户id
    var name : String = ""    // 用户名称
    var address : String = "" // 地址
    var price : String = ""   // 价格
    var praise : String = ""  // 点赞数
    var avatar : String = ""  // 头像
    var phone : String = ""   // 手机号
    var password : String = "" // 密码
    
    func getDiction()->Dictionary<String, Any>  {
        let dic : Dictionary = ["userId":userId,
                                "name":name,
                                "address":address,
                                "price":price,
                                "praise":praise,
                                "avatar":avatar,
                                "phone":phone,
                                "password":password]
        return dic
    }
    convenience init(dic:Dictionary<String, Any>)  {
        self.init()
    
        
        self.userId =   "\(dic["userId"] ?? "")"
        self.name =     "\(dic["name"] ?? "")"
        self.address =  "\(dic["address"] ?? "")"
        self.price =    "\(dic["price"] ?? "")"
        self.praise =   "\(dic["praise"] ?? "")"
        self.avatar =   "\(dic["avatar"] ?? "")"
        self.phone =    "\(dic["phone"] ?? "")"
        self.password = "\(dic["password"] ?? "")"
    }
}
class Request: NSObject {
    private static var _userList : Array<Any>?
    static var userList : Array<Any>{
        get{
            if _userList == nil
            {
                if UserDefaults.standard.value(forKey: "userList") == nil {
                   _userList = Array.init()
                }else{
                    _userList = (UserDefaults.standard.value(forKey: "userList") as! Array<Any>)
                }
            }
            if _userList == nil
            {
                _userList = Array.init()
            }
    
            return _userList!
        }
        set{
            _userList = newValue
            UserDefaults.standard.set(_userList, forKey: "userList")
        }
    }
    
    static func getDistrict()
    {
        
    }
    
    
    
    static func login(userName:String,password:String,response:@escaping (_ success:Bool,_ msg:String,_ data:UserInfo?)->(Void)){
        
        getUserInfo(userName: userName) { (success, msg, userInfo) -> (Void) in
            if success {
                if userInfo?.password == password {
                    response(true,msg,userInfo)
                }else{
                    response(false,"密码错误",nil)
                }
            }else{
                response(success,msg,userInfo)
            }
        }
    }
    static func getUsers(pageNum:Int,response:@escaping (_ success:Bool,_ msg:String,_ data:Array<Any>)->(Void)){
        let list = self.userList
        response(true,"获取成功",list)
    }
    static func getUserInfo(userId:String,response:@escaping ((_ success:Bool,_ msg:String,_ data:UserInfo?)->(Void))){
        let list = self.userList
    
        for item in list {
            if( userId == (item as! UserInfo).userId)
            {
                response(true,"获取成功",(item as! UserInfo))
                return
            }

        }
             response(false,"用户不存在",nil)
    }
    static func getUserInfo(userName:String,response:@escaping ((_ success:Bool,_ msg:String,_ data:UserInfo?)->(Void))){
        let list = self.userList
        
        
        for item in list {
            let model  : UserInfo = UserInfo.init(dic: item as! Dictionary<String, Any>)
            
            if(userName  == model.phone)
            {
                response(true,"获取成功",model)
                return
            }
        }
        response(false,"用户不存在",nil)
    }
    static func register(userInfo:UserInfo,response:@escaping ((_ success:Bool,_ msg:String,_ data:Dictionary<String, Any>)->(Void))){
   
     
        userInfo.userId = "\(self.userList.count)"
        
        
        var list = self.userList
        list.append(userInfo.getDiction())
        self.userList = list
        
        
        response(true,"保存成功",[:])
        
    }
}
