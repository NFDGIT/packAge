//
//  DetailViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class ZYDetailViewController: BaseViewController {
    let scrollView : UIScrollView = UIScrollView.init()
    var model : ZYGoodsModel = ZYGoodsModel()
    
    let carouse : PHCarouselView  = PHCarouselView.init()
    let layout1 = PHLayoutView.init()
    
    let userView : UserCellView = UserCellView.init()
    let layout2 = PHLayoutView.init()
    
    let labtalCommend : UILabel = UILabel.init()
    
//    let layout4 = PHLayoutView.init()

    
//    var info : GoodsInfo = GoodsInfo()
    var Id : String = ""
    
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        self.refreshData()

        // Do any additional setup after loading the view.
    }
    override func initNavi() {
        super.initNavi()
        self.title = "详情页"
    }
    override func initUI() {
        super.initUI()
        
        
        let  btnCar = UIButton.init()
        btnCar.setImage(UIImage.init(named: "购物车to"), for: .normal)
        btnCar.backgroundColor = UIColor.white
        self.view.addSubview(btnCar)
        btnCar.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Bottom_Tool_Height())
            make.height.equalTo(SCALE(size: 60))
            make.width.equalTo(SCALE(size: 80))
        }
        btnCar.phAddTarget(events: .touchUpInside) { (sender) in
            self.navigationController?.popToRootViewController(animated: true)
            ((UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as! PHBaseTabBarController).selectedIndex = 2
        }
        
        
        
        let layout2Datas : [(img:String,title:String)] = [("联系","联系"),("预约","下单")]
        

        self.view.addSubview(layout2)
        layout2.layout.column = 2
        layout2.snp.makeConstraints { (make) in
            make.left.equalTo(btnCar.snp.right)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Bottom_Tool_Height())

        }
        
        layout2.numberOfCell = {
            return layout2Datas.count
        }
        layout2.cellForIndex = {index in
            let layout2Data = layout2Datas[index]
            
            let view = UIButton.init()
            
            
            let btn  : UIButton = UIButton.init(normalTitle: layout2Data.title, normalTextColor: UIColor.white, font: UIFont.phBig)
            btn.layer.cornerRadius = SCALE(size: 5)
            btn.layer.masksToBounds = true
            btn.isUserInteractionEnabled = false
            view.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.top.equalToSuperview().offset(SCALE(size: 5))
                make.right.bottom.equalToSuperview().offset(SCALE(size: -5))
                make.height.equalTo(SCALE(size: 50))
            })
            
            
            if index == 1 {
                btn.setBackgroundImage(UIImage.phInit(color: UIColor.phRed), for: .normal)
                btn.setTitleColor(UIColor.white, for: .normal)
            }
            if index == 0 {
                btn.setBackgroundImage(UIImage.phInit(color: UIColor.appTheme), for: .normal)
                Request.judgeIsServer(goodsId: self.model.goodsId, response: { (success, msg, data) -> (Void) in
                    if success {
                        btn.setTitle("已加入购物车", for: .normal)
                    }
                    else{
                        btn.setTitle("加入购物车", for: .normal)
                    }
                })
                
            }

            return view
        }
        layout2.selectedCell = {index in
            if !(UIApplication.shared.delegate as! AppDelegate).login()
            {
              return
            }
            
            
            if  index == 1 {
                let placeorder = ZYPlaceOrderViewController.init()
                placeorder.goodids = [self.model.goodsId]
                self.navigationController?.pushViewController(placeorder, animated: true)
                placeorder.submitCallBack = {
      

                    let alert = UIAlertController.init(title: "下单成功！", message: "是否前去查看?", preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "去查看", style: .destructive, handler: { (action) in
                        let order = ZYOrderViewController.init()
                        order.type = 0
                        self.navigationController?.pushViewController(order, animated: true)
                    })
                    let action1 = UIAlertAction.init(title: "取消", style: .destructive, handler: { (action) in
                        
                    })
                    alert.addAction(action)
                    alert.addAction(action1)
                    self.present(alert, animated: true, completion: {
                        
                    })
                }
                
            }
            if index == 0 {
                
                
                
                Request.judgeIsServer(goodsId: self.model.goodsId, response: { (success, msg, data) -> (Void) in
                    if success {
                        self.view.makeToast("该商品已加入购物车！！",position:.center)
                        return
                    }
                    
                    
                    
                    Request.addServer(goodsId: self.model.goodsId, response: { (success, msg, data) -> (Void) in
                        if success {
                
                            self.layout2.reload()
                            
                            let alert = UIAlertController.init(title: "加入成功！", message: "是否前去查看?", preferredStyle: .alert)
                            let action = UIAlertAction.init(title: "去查看", style: .destructive, handler: { (action) in
                                self.navigationController?.popToRootViewController(animated: true)
                                ((UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as! PHBaseTabBarController).selectedIndex = 2
                            })
                            let action1 = UIAlertAction.init(title: "取消", style: .destructive, handler: { (action) in
                                
                            })
                            alert.addAction(action)
                            alert.addAction(action1)
                            self.present(alert, animated: true, completion: {
                                
                            })
                            
                        }else{
                            self.view.makeToast(msg,position:.center)
                        }

                    })

                    
                })
                
                
            }
            
        }
        layout2.reload()
        
        
        
        
        
        
        
    
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(layout2.snp.top)
        }
        


        
        self.scrollView.addSubview(carouse)
        carouse.snp.makeConstraints { (make) in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(self.view.snp.width).multipliedBy(0.8)
        }
        carouse.numberCell = {
            return 1
        }
        carouse.cellForIndex = {index in
            
            let img : ImageView = ImageView.init()
            img.contentMode = .scaleAspectFill
            
            if self.model.avatar.count <= 0 {
                self.model.avatar = "1"
            }
        
            img.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: self.model.avatar)!),placeholder: UIImage.init(named: "default"))
            return img
        }
        carouse.reload()
        

        
        
        


        self.scrollView.addSubview(layout1)
        layout1.snp.makeConstraints { (make) in
            make.top.equalTo(carouse.snp.bottom).offset(SCALE(size: 10))
            make.left.equalToSuperview()
            make.width.equalToSuperview()
//            make.height.equalTo(80)
        }
//        layout1.layout.column = 2
        layout1.numberOfCell = {
            return 2
        }
        layout1.cellForIndex = {index in
            let view = UIView.init()
            
            
            let btn  : UIButton = UIButton.init(normalTitle: index == 0 ? "840元/月" : "三室一厅一卫", normalTextColor: UIColor.appTheme, font: UIFont.phBig)
            view.addSubview(btn)
            
            btn.backgroundColor = UIColor.phBgContent
            btn.snp.makeConstraints({ (make) in
                make.left.top.equalToSuperview().offset(SCALE(size: 5))
                make.right.bottom.equalToSuperview().offset(SCALE(size: -5))
            })
            
            
            btn.titleLabel?.numberOfLines = 0
            btn.titleLabel?.textAlignment = .center
            if  index == 0 {

                let att1 = NSMutableAttributedString.init(string: "¥\(self.model.price)")
                let att2 = NSAttributedString.init(string: "\n\n只支持线下支付", attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText,NSAttributedStringKey.font:UIFont.phMiddle])
                att1.append(att2)

                btn.setAttributedTitle(att1, for: .normal)
            }
            if  index == 1 {
                let att1 = NSMutableAttributedString.init(string: "\(self.model.type)")
                let att2 = NSAttributedString.init(string: "\n\n七天包换-正品保障", attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText,NSAttributedStringKey.font:UIFont.phMiddle])
                att1.append(att2)
                btn.setAttributedTitle(att1, for: .normal)
            }
            
            return view
        }
        layout1.reload()

        

        
        let layout3 = PHLayoutView.init();
        self.scrollView.addSubview(layout3)
        layout3.snp.makeConstraints { (make) in
            make.top.equalTo(layout1.snp.bottom)
            make.width.equalToSuperview()
            make.left.equalToSuperview()
        }
        layout3.layout.isAutoHeight = true
        layout3.numberOfCell = {return 2}
        layout3.cellForIndex = {index in
            let view = UIView.init()
            
            
            let btn  : UIButton = UIButton.init(normalTitle: index == 0 ? "840元/月" : "三室一厅一卫", normalTextColor: UIColor.phBlackText, font: UIFont.phMiddle)
            view.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.top.equalToSuperview().offset(SCALE(size: 5))
                make.right.bottom.equalToSuperview().offset(SCALE(size: -5))
            })
            btn.backgroundColor = UIColor.phBgContent
   
            btn.titleLabel?.numberOfLines = 1
            btn.titleLabel?.textAlignment = .left
            
            if  index == 0 {
                let att1 = NSMutableAttributedString.init(string: "\(self.model.name)")
                let att2 = NSAttributedString.init(string: "", attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText,NSAttributedStringKey.font:UIFont.phMiddle])
                att1.append(att2)
                btn.setAttributedTitle(att1, for: .normal)
            }else
            {
                let att1 = NSMutableAttributedString.init(string: "\(self.model.decorationCompanyDesc)")
                let att2 = NSAttributedString.init(string: "", attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText,NSAttributedStringKey.font:UIFont.phMiddle])
                att1.append(att2)
                btn.setAttributedTitle(att1, for: .normal)
            }

            
            btn.snp.makeConstraints({ (make) in
                make.height.equalTo(30)
            })
            
            return view
            
        }
        layout3.reload()
//        userView.imgView.phLayer(cornerRadius: SCALE(size: 40), borderWidth: 0)
//        userView.snp.makeConstraints { (make) in
//            make.top.equalTo(layout1.snp.bottom)
//            make.left.width.equalToSuperview()
//
//        }
//

        

        labtalCommend.backgroundColor = UIColor.white
        labtalCommend.font = UIFont.phMiddle
        labtalCommend.textColor = UIColor.phBlackText
        labtalCommend.text = "\n—— 详情页 ——"
        labtalCommend.numberOfLines = 0
        labtalCommend.textAlignment = .center
        scrollView.addSubview(labtalCommend)
        labtalCommend.snp.makeConstraints { (make) in
            make.top.equalTo(layout3.snp.bottom)
            make.left.width.equalToSuperview()
            make.height.equalTo(SCALE(size: 40))
            
        }
        
        
        
        

//        layout4.layout.type = .collection
//        layout4.layout.column = 2
//        self.scrollView.addSubview(layout4)
//        layout4.snp.makeConstraints { (make) in
//            make.top.equalTo(labtalCommend.snp.bottom)
//            make.left.width.equalToSuperview()
////            make.bottom.equalToSuperview()
//        }
//        layout4.numberOfCell = {
//            return self.model.imgs.count
//        }

        
//        layout4.cellForIndex = {index in
//            let btn = UIButton.init()
//            let imgDic = self.model.imgs[index]
//
//            let img = UIImageView.init()
//            img.contentMode = .scaleAspectFill
//            img.clipsToBounds = true
//            img.backgroundColor = UIColor.phBgContent
//            img.kf.setImage(with: URL.init(string: "\(imgDic["url"] ?? "0")"))
//            btn.addSubview(img)
//            img.snp.makeConstraints({ (make) in
//                make.left.top.equalToSuperview().offset(SCALE(size: 2))
//                make.right.bottom.equalToSuperview().offset(SCALE(size: -2))
//            })
//            return btn
//        }
//        layout4.selectedCell = {index in
//
//
//            let browser : PHPhotoBrowser = PHPhotoBrowser.init()
//
//
//            var imgs : Array<(url: URL, title: String)> = Array.init()
//            for imgDic in (self.model.imgs){
//                var imgIi : (url: URL, title: String) = (url:URL.init(string: "0")!,title:"")
//                imgIi.url = URL.init(string: imgDic["url"] as! String)!
//                imgIi.title = ""
//
//
//                imgs.append(imgIi)
//            }
//
//            browser.datas = imgs
//            browser.index = index
//            browser.appear()
//        }
//        layout4.reload()
        
        

        
        let webview = PHBaseWebView.init()
        self.scrollView.addSubview(webview)
        

        let imgurl = "\(baseUrl)resource/detail/\(model.goodsId).png"
        webview.loadHTMLString(getImgWeb(imgUrl: imgurl), baseURL: nil)
//        webview.load(URLRequest.init(url: URL.init(string: "https://m.intl.taobao.com/detail/detail.html?id=528603968600&ali_refid=a3_430125_1006:1107689385:N:%E9%93%81%E8%A7%82%E9%9F%B3:3ea11759b9918dea427245c73fb1b5bb&ali_trackid=1_3ea11759b9918dea427245c73fb1b5bb")!))
        
        webview.snp.makeConstraints { (make) in
            make.top.equalTo(labtalCommend.snp.bottom)
            make.left.width.equalToSuperview()
            make.height.equalTo(SCALE(size: 1))
            make.bottom.equalToSuperview()
        }
        webview.scrollView.isScrollEnabled = false
        webview.webLoadCallBack = {status in
            if status == .finish{
//                webview.evaluateJavaScript("document.getElementById('desc').innerHTML;", completionHandler: { (result, err) in
//                    
//                    self.view.makeToast("\(result)",position:.center)
//                })
//                webview.evaluateJavaScript(self.getDetailOfTBScript(), completionHandler: { (result, err) in
//
//                })
                
                webview.evaluateJavaScript("document.body.offsetHeight;", completionHandler: { (result, err) in
                    let heightStr  = "\(result!)"
                    let height = Float(heightStr)
                    
                    webview.snp.remakeConstraints({ (make) in
                        make.top.equalTo(self.labtalCommend.snp.bottom)
                        make.left.width.equalToSuperview()
                        make.height.equalTo(height!)
                        make.bottom.equalToSuperview()
                    })
                })
            }
            
        }
        
        
        
        
    }
    func refreshData()  {
        self.refreshUI()
    }
    func refreshUI()  {
        
        self.carouse.reload()
        self.layout1.reload()
        self.userView.imgView.image = UIImage.init(named: "avatar")
        self.userView.labelTitle.text = model.decorationCompany
        self.userView.labelSubtitle.text = model.decorationCompanyDesc
        
//        self.layout3.reload()
//        self.userView.labelTitle.text = self.info.name
//        self.userView.labelSubtitle.text = self.info.address
        
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
extension ZYDetailViewController{
    func getImgWeb(imgUrl:String) -> String {
        return """
        <html>
        <head>
        <title>包含图片的网页</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        </head>
        <body>
        </br>
        <img  src="\(imgUrl)" style="width:100%">
        </img>
        </body>
        </html>
        """
    }
    
//    document.getElementsByClassName('toolbar transformed')[0].remove();
//
//    document.getElementsByClassName('smartbanner-wrapper')[0].remove();
//    document.getElementsByClassName('smartbanner-wrapper')[0].remove();
//    document.getElementsByClassName('smartbanner-wrapper')[0].remove();
//
//
//    document.getElementsByClassName('split')[0].remove();
//    document.getElementsByClassName('split')[0].remove();
//    document.getElementsByClassName('split')[0].remove();
//    document.getElementsByClassName('split')[0].remove();
//
//    document.getElementsByClassName('recommend')[0].remove();
    func getDetailOfTBScript()-> String {
        let script = """
                        document.getElementsByClassName('bar')[0].remove();
                        """
        
        
        return script
    }
}

