//
//  QYPlaceOrderViewController.swift
//  package
//
//  Created by Admin on 2019/3/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYPlaceOrderViewController: BaseViewController {
   
    var goodids:Array<String> = Array.init()
    private var goods:Array<ZYGoodsModel> = Array.init()
    var submitCallBack:(()->())?
    let goodsLayout = PHLayoutView.init()
    
    
    let tfName : PHTextField = PHTextField.init()
    let tfPhone : PHTextField = PHTextField.init()
    let tfAddress : PHTextField = PHTextField.init()
    let labeDesc = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        self.refreshData()
        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        self.title = "确认下单"
    }
    override func initUI() {
        super.initUI()
        
        
        
        
        let addressView = UIView.init()
        addressView.backgroundColor = UIColor.white
        self.view.addSubview(addressView)
        addressView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(SCALE(size: 100))
        }
        
        let labelName : UILabel = UILabel.init()
        labelName.font = UIFont.phMiddle
        labelName.textColor = UIColor.phBlackText
        labelName.text = "姓  名："
        
        let labelPhone : UILabel = UILabel.init()
        labelPhone.font = UIFont.phMiddle
        labelPhone.textColor = UIColor.phBlackText
        labelPhone.text = "手机号："
        
        let labelAddress : UILabel = UILabel.init()
        labelAddress.font = UIFont.phMiddle
        labelAddress.textColor = UIColor.phBlackText
        labelAddress.text = "地  址："
        
        

        tfName.font = UIFont.phMiddle
        tfName.textColor = UIColor.phBlackText
        tfName.placeholder = "请输入姓名"
        

        tfPhone.font = UIFont.phMiddle
        tfPhone.textColor = UIColor.phBlackText
        tfPhone.placeholder = "请输入手机号"
        

        tfAddress.font = UIFont.phMiddle
        tfAddress.textColor = UIColor.phBlackText
        tfAddress.placeholder = "请输入地址"
        
        addressView.addSubview(labelName)
        addressView.addSubview(labelPhone)
        addressView.addSubview(labelAddress)
        
        addressView.addSubview(tfName)
        addressView.addSubview(tfPhone)
        addressView.addSubview(tfAddress)
        
        labelName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(SCALE(size: 20))
            make.top.equalToSuperview().offset(SCALE(size: 10))
            make.height.equalTo(SCALE(size: 20))
            make.width.equalTo(SCALE(size: 80))
        }
        
        labelPhone.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(SCALE(size: 20))
            make.height.equalTo(SCALE(size: 20))
            make.width.equalTo(SCALE(size: 80))
            make.centerY.equalToSuperview()
        }
        
        
        labelAddress.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(SCALE(size: 20))
            make.height.equalTo(SCALE(size: 20))
            make.width.equalTo(SCALE(size: 80))
            make.bottom.equalToSuperview().offset(SCALE(size: -10))
        }
        
        tfName.snp.makeConstraints { (make) in
            make.left.equalTo(labelName.snp.right)
            make.height.equalTo(SCALE(size: 20))
            make.right.equalToSuperview()
            make.top.equalTo(labelName.snp.top)
        }
        
        
        tfPhone.snp.makeConstraints { (make) in
            make.left.equalTo(labelPhone.snp.right)
            make.height.equalTo(SCALE(size: 20))
            make.right.equalToSuperview()
            make.top.equalTo(labelPhone.snp.top)
        }
        
        tfAddress.snp.makeConstraints { (make) in
            make.left.equalTo(labelAddress.snp.right)
            make.height.equalTo(SCALE(size: 20))
            make.right.equalToSuperview()
            make.top.equalTo(labelAddress.snp.top)
        }
        
        

        goodsLayout.numberOfCell = {return self.goods.count}
        goodsLayout.cellForIndex = {index in
            let goodsview = ZYGoodsCellView.init()
            goodsview.model = self.goods[index]
            return goodsview
        }
        
        self.view.addSubview(goodsLayout)
        goodsLayout.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(addressView.snp.bottom)
        }

        goodsLayout.reload()
        
        
        let values : [(title:String,content:String)] = [("配送方式","到付"),("支付方式","货到付款")]
        
        var temView : UIView?
        for value in values
        {
            let view = UIView.init()
            self.view.addSubview(view)
            view.backgroundColor = UIColor.white
            view.snp.makeConstraints { (make) in
                make.left.width.equalToSuperview()
                if temView == nil {make.top.equalTo(goodsLayout.snp.bottom).offset(SCALE(size: 10))}
                else {make.top.equalTo(temView!.snp.bottom).offset(SCALE(size: 10))}
                make.height.equalTo(SCALE(size: 50))
                
            }
            
            
            
            let labelTile : UILabel = UILabel.init()
            view.addSubview(labelTile)
            labelTile.font = UIFont.phMiddle
            labelTile.textColor = UIColor.phBlackText
            labelTile.text = value.title
            labelTile.snp.makeConstraints { (make) in
                make.left.equalTo(SCALE(size: 10))
                make.top.bottom.equalToSuperview()
                make.width.equalTo(SCALE(size: 80))
            }
            
            
            let labelContent : UILabel = UILabel.init()
            labelContent.textAlignment = .right
            view.addSubview(labelContent)
            labelContent.font = UIFont.phMiddle
            labelContent.textColor = UIColor.phBlackText
            labelContent.text = value.content
            labelContent.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(SCALE(size: -10))
                make.top.bottom.equalToSuperview()
                make.width.equalTo(SCALE(size: 100))
            }
            
            temView = view
        }

        
        

        
        
        let bottomView = UIView.init()
        bottomView.backgroundColor = UIColor.white
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(SCALE(size: 50))
            make.bottom.equalToSuperview().offset(-Bottom_Tool_Height())
        }
        
        
        
        
        
        
        let btnConfirm = UIButton.init()
        btnConfirm.setBackgroundImage(UIImage.phInit(color: UIColor.appTheme), for: .normal)
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.setTitle("提交订单", for: .normal)
        btnConfirm.titleLabel?.font = UIFont.phBig
        bottomView.addSubview(btnConfirm)
        btnConfirm.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(btnConfirm.snp.height).multipliedBy(2)
        }
        btnConfirm.phAddTarget(events: .touchUpInside) { (sender) in
            self.submit()
        }

        labeDesc.font = UIFont.phSmall
        bottomView.addSubview(labeDesc)
        labeDesc.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(btnConfirm.snp.left).offset(SCALE(size: -10))
        }
        labeDesc.textAlignment = .right
        
        
        
        
        
    }
    
    func refreshData()  {
        
        
        self.view.makeToastActivity(.center)
        goods.removeAll()
        Request.getGoods { (success, msg, data) -> (Void) in
            self.view.hideToastActivity()
            
            if success
            {
                for datadic in data{
                    self.goods.append(ZYGoodsModel.init(dic: datadic as! Dictionary<String, Any>))
                }
                self.goods = self.goods.filter({ (model) -> Bool in
                    
                    var contain = false
                    for goodsid in self.goodids
                    {
                        if goodsid == model.goodsId
                        {
                            contain = true
                        }
                    }
                    return contain
                })
                
               
            }
            self.refreshUI()
            
            
        }
    }
    func refreshUI()  {
        self.goodsLayout.reload()
        
        
        self.tfName.text = "张先生"
        self.tfPhone.text = "13099989743"
        self.tfAddress.text = "天通苑西三区28号楼1907"
        
        
    
        var totalAmount : Float = 0.00
        for model  in self.goods {
            totalAmount = totalAmount + Float(model.price)!
        }

        
        
        
        let att1 = NSMutableAttributedString.init(string: "共\(self.goods.count)件,总金额", attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText])
        att1.addAttributes([NSAttributedStringKey.foregroundColor:UIColor.appTheme], range: NSRange.init(location: 1, length: 1))
        let att2 = NSMutableAttributedString.init(string: "¥\(totalAmount)    ", attributes: [NSAttributedStringKey.foregroundColor:UIColor.appTheme,NSAttributedStringKey.font:UIFont.phBig])
        att1.append(att2)
   
        self.labeDesc.attributedText = att1
        
        
    }
    func submit()  {
        self.view.makeToastActivity(.center)
        Request.deleteServer(goodsIds: self.goodids) { (success, msg, data) -> (Void) in
            self.view.hideToastActivity()
            //            self.view.makeToast(msg,position:.center)
            if success {
                self.refreshData()
//                self.bottomView.reload()
            }
            
        }
        
        let userid : String = "\(Request.getLocalUserInfo()["user_id"] ?? "")"
        let username : String = "\(Request.getLocalUserInfo()["user_username"] ?? "")"
        Request.palceOrder(goodsId: self.goodids.first!, userId: userid, num: "\(self.goodids.count)", name: username, address: "", tel: "") { (success, msg, data) -> (Void) in
            self.view.makeToast(msg,position:.center)
            if success {
                self.navigationController?.popViewController(animated: true)
                
                if self.submitCallBack != nil
                {
                    self.submitCallBack!()
                    

                }
      
                
                
  
            }
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
