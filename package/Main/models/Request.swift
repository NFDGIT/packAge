//
//  Request.swift
//  package
//
//  Created by Admin on 2019/2/14.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON
class GoodsInfo : NSObject {
    var userId : String = ""  // 用户id
    var name : String = ""    // 用户名称
    var address : String = "" // 地址
    var price : String = ""   // 价格
    var praise : String = ""  // 点赞数
    var avatar : String = ""  // 头像
    var phone : String = ""   // 手机号
    var password : String = "" // 密码
    
    var bedroomNum : String = "" // 卧室数量
    var liveroomNum : String = "" //    客厅数量
    var restroomNum : String = ""  // 卫生间数量
    var roomArea : String = ""  // 面积
    var decorationState : String = ""  // 装修情况
    var rentType : String = "" // 出租方式
    var orientation : String = ""  // 朝向

    
    func getDiction()->Dictionary<String, Any>  {
        let dic : Dictionary = ["userId":userId,
                                "name":name,
                                "address":address,
                                "price":price,
                                "praise":praise,
                                "avatar":avatar,
                                "phone":phone,
                                "password":password,

                                "bedroomNum":bedroomNum,
                                "liveroomNum":liveroomNum,
                                "restroomNum":restroomNum,
                                "roomArea":roomArea,
                                "decorationState":decorationState,
                                "rentType":rentType,
                                "orientation":orientation,
                                ]
        
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
        
    
        self.bedroomNum =     "\(dic["bedroomNum"] ?? "")"
        self.liveroomNum =  "\(dic["liveroomNum"] ?? "")"
        self.restroomNum =    "\(dic["restroomNum"] ?? "")"
        self.roomArea =   "\(dic["roomArea"] ?? "")"
        self.decorationState =   "\(dic["decorationState"] ?? "")"
        self.rentType =    "\(dic["rentType"] ?? "")"
        self.orientation = "\(dic["orientation"] ?? "")"
    }
    static func getRandomInfo() -> GoodsInfo {
        
        
        let imgs  = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551176267682&di=cc1b5bcd0ee9707330605567407a79da&imgtype=0&src=http%3A%2F%2Fimg4.tuituifang.com%2F11%2Fsh%2Fpic%2F20170820%2F56%2F15031904361532540101.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551176286658&di=f3dce2e84b07b6cd5e40cc398658fbf9&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D1702435313%2C3429504201%26fm%3D214%26gp%3D0.jpg",
                     "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1329366175,659067313&fm=26&gp=0.jpg",
                     "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3369772135,3277835804&fm=26&gp=0.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551348775626&di=907b5ca78f243ce2f72b9a0031cd98b3&imgtype=0&src=http%3A%2F%2Ffocusimg.focus.cn%2Fesftop%2F201801%2F201801050522225710.jpg",
                     "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3521836519,2887135150&fm=26&gp=0.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551348775619&di=6ba1f4b70c1d85492c2a37d7a4038d7c&imgtype=0&src=http%3A%2F%2Fimg.juhaof.com%2F4%2Fpic%2F20140808%2F09%2F1407504789176014317.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551348843052&di=fc8e0fb3f6bcec0f00556eed4af26d9f&imgtype=0&src=http%3A%2F%2Fcdnsfb.soufunimg.com%2Fviewimage%2F1%2F2017_11%2F12%2FM17%2F59%2F8ca4231f13f0421bb259120c27e912ee%2F690x440c.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551348843052&di=4551104cbb7f3adff8d479255387f284&imgtype=0&src=http%3A%2F%2Fimg1.f.itc.cn%2Fesf%2F19815%2F600x450_198151466.jpg"]
        let lastNames  = ["齐","鲁","晋","宋","郑","吴","越","秦","楚","卫","韩","赵","魏","燕","陈","蔡","曹","胡","许"]
        let firstNames = ["横","慧","辉","翔","纬","简","空","极","菲菲"]
        let rentTypes = ["整租","合租"]
        let orientations = ["东","西","南","北"]
        let decorationStates = ["精装","简装"]
        let addresss = ["天通苑","景园","玉质花园","唐宁一号","永丰乐城","永威祥龙城","锦艺城"]
        
        let goodsInfo : GoodsInfo = GoodsInfo()
        goodsInfo.name = "\(lastNames[PHConstant.getRandomNumber(min: 0, max: lastNames.count-1)])\(firstNames[PHConstant.getRandomNumber(min: 0, max: firstNames.count-1)])"
        goodsInfo.avatar = "\(imgs[PHConstant.getRandomNumber(min: 0, max: imgs.count-1)])"
        goodsInfo.praise = "20"
        goodsInfo.address = "\(addresss[PHConstant.getRandomNumber(min: 0, max: addresss.count-1)])"
        
        
        goodsInfo.price = "\(PHConstant.getRandomNumber(min: 1000, max: 2000))"
        goodsInfo.roomArea = "\(PHConstant.getRandomNumber(min: 67, max: 150))"
        goodsInfo.restroomNum = "\(PHConstant.getRandomNumber(min: 1, max: 3))"
        goodsInfo.liveroomNum = "\(PHConstant.getRandomNumber(min: 1, max: 3))"
        goodsInfo.bedroomNum = "\(PHConstant.getRandomNumber(min: 1, max: 5))"
        
        
        goodsInfo.rentType = "\(rentTypes[PHConstant.getRandomNumber(min: 0, max: rentTypes.count-1)])"
        goodsInfo.orientation = "\(orientations[PHConstant.getRandomNumber(min: 0, max: orientations.count-1)])"
        goodsInfo.decorationState = "\(decorationStates[PHConstant.getRandomNumber(min: 0, max: decorationStates.count-1)])"
        
        
        
        goodsInfo.phone = "1\(PHConstant.getRandomNumber(min: 3, max: 9))\(PHConstant.getRandomNumber(min: 3, max: 9))\(PHConstant.getRandomNumber(min: 3, max: 9))\(PHConstant.getRandomNumber(min: 3, max: 9))\(PHConstant.getRandomNumber(min: 3, max: 9))\(PHConstant.getRandomNumber(min: 3, max: 9))\(PHConstant.getRandomNumber(min: 3, max: 9))\(PHConstant.getRandomNumber(min: 3, max: 9))\(PHConstant.getRandomNumber(min: 3, max: 9))\(PHConstant.getRandomNumber(min: 3, max: 9))"
        goodsInfo.password = "666368"
        
        return goodsInfo
    }
}
class Request: NSObject {
    private static var _userList : Array<Any>?
    static var userList : Array<Any>{
        get{
            if _userList == nil
            {
                if UserDefaults.standard.value(forKey: "userList") == nil {
                    var datas : Array<Any> = Array.init()
                    for _ in 0...10
                    {
                        datas.append(GoodsInfo.getRandomInfo().getDiction())
                    }
                    _userList = datas
                }else{
                    _userList = (UserDefaults.standard.value(forKey: "userList") as! Array<Any>)
                }
            }
            if _userList == nil
            {
                var datas : Array<Any> = Array.init()
                for _ in 0...10
                {
                    datas.append(GoodsInfo.getRandomInfo().getDiction())
                }
                _userList = datas
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
    
    
    
    static func login(userName:String,password:String,response:@escaping (_ success:Bool,_ msg:String,_ data:GoodsInfo?)->(Void)){
        
        getGoodsInfo(userName: userName) { (success, msg, GoodsInfo) -> (Void) in
            if success {
                if GoodsInfo?.password == password {
                    response(true,msg,GoodsInfo)
                }else{
                    response(false,"密码错误",nil)
                }
            }else{
                response(success,msg,GoodsInfo)
            }
        }
    }
    static func getUsers(pageNum:Int,response:@escaping (_ success:Bool,_ msg:String,_ data:Array<Any>)->(Void)){

        
        
        NetTool.post(url: "http://47.95.242.241/zis/hots.php") { (res) -> (Void) in
            if res.success
            {
                let list : Array = self.userList
                response(true,"获取成功",list)
            }
            else{
                response(false,"网络连接失败",Array.init())
            }
        }
        
        
        
    }
    static func getGoodsInfo(userId:String,response:@escaping ((_ success:Bool,_ msg:String,_ data:GoodsInfo?)->(Void))){
        let list = self.userList
    
        for item in list {
            let model = GoodsInfo.init(dic: item as! Dictionary<String, Any>)
            
            if( userId == model.userId)
            {
                response(true,"获取成功",model)
                return
            }

        }
             response(false,"用户不存在",nil)
    }
    static func getGoodsInfo(userName:String,response:@escaping ((_ success:Bool,_ msg:String,_ data:GoodsInfo?)->(Void))){
        let list = self.userList
        
        
        for item in list {
            let model  : GoodsInfo = GoodsInfo.init(dic: item as! Dictionary<String, Any>)
            
            if(userName  == model.phone)
            {
                response(true,"获取成功",model)
                return
            }
        }
        response(false,"用户不存在",nil)
    }
    static func register(goodsInfo:GoodsInfo,response:@escaping ((_ success:Bool,_ msg:String,_ data:Dictionary<String, Any>)->(Void))){
   
     
        goodsInfo.userId = "\(self.userList.count)"
        
        
        var list = self.userList
        list.append(goodsInfo.getDiction())
        self.userList = list
        
        
        response(true,"保存成功",[:])
        
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


