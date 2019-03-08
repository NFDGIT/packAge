//
//  DetailViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class QYDetailViewController: BaseViewController {
    let scrollView : UIScrollView = UIScrollView.init()
    var model : QYGoodsModel = QYGoodsModel()
    
    let carouse : PHCarouselView  = PHCarouselView.init()
    let layout1 = PHLayoutView.init()
    
    let userView : UserCellView = UserCellView.init()
    let layout2 = PHLayoutView.init()
    
    let layout4 = PHLayoutView.init()

    
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
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        

        
        self.scrollView.addSubview(carouse)
        carouse.snp.makeConstraints { (make) in
            make.left.width.top.equalToSuperview()
            make.height.equalTo(200)
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
        

        
        
        

        layout1.layout.direction = .horizontal
        self.scrollView.addSubview(layout1)
        layout1.snp.makeConstraints { (make) in
            make.top.equalTo(carouse.snp.bottom).offset(SCALE(size: 10))
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(80)
        }
        layout1.numberOfCell = {
            return 2
        }
        layout1.cellForIndex = {index in
            let btn  : UIButton = UIButton.init(normalTitle: index == 0 ? "840元/月" : "三室一厅一卫", normalTextColor: UIColor.appTheme, font: UIFont.phBig)
            btn.titleLabel?.numberOfLines = 0
            btn.titleLabel?.textAlignment = .center
            if  index == 0 {

                let att1 = NSMutableAttributedString.init(string: "\(self.model.style)")
                let att2 = NSAttributedString.init(string: "\n\n风格", attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText,NSAttributedStringKey.font:UIFont.phMiddle])
                att1.append(att2)

                btn.setAttributedTitle(att1, for: .normal)
            }
            if  index == 1 {
                let att1 = NSMutableAttributedString.init(string: "\(self.model.houseType)")
                let att2 = NSAttributedString.init(string: "\n\n户型", attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText,NSAttributedStringKey.font:UIFont.phMiddle])
                att1.append(att2)
                btn.setAttributedTitle(att1, for: .normal)
            }
            
            return btn
        }
        layout1.reload()

        

        self.scrollView.addSubview(userView)
        userView.imgView.phLayer(cornerRadius: SCALE(size: 40), borderWidth: 0)
        userView.snp.makeConstraints { (make) in
            make.top.equalTo(layout1.snp.bottom).offset(SCALE(size: 10))
            make.left.width.equalToSuperview()

        }
        
        
        
        let layout2Datas : [(img:String,title:String)] = [("联系","联系"),("预约","预约")]
   
        layout2.layout.direction = .horizontal
        self.scrollView.addSubview(layout2)
        layout2.snp.makeConstraints { (make) in
            make.top.equalTo(userView.snp.bottom).offset(SCALE(size: 1))
            make.left.width.equalToSuperview()
            make.height.equalTo(SCALE(size: 50))
        }
        layout2.numberOfCell = {
            return layout2Datas.count
        }
        layout2.cellForIndex = {index in
            let layout2Data = layout2Datas[index]
            
            let btn  : UIButton = UIButton.init(normalTitle: layout2Data.title, normalTextColor: UIColor.white, font: UIFont.phBig)
            if index == 0 {
                btn.setTitleColor(UIColor.appTheme, for: .normal)
            }
            if index == 1 {
                btn.setBackgroundImage(UIImage.phInit(color: UIColor.appTheme), for: .normal)
                Request.judgeIsServer(goodsId: self.model.goodsId, response: { (success, msg, data) -> (Void) in
                    if success {
                        btn.setTitle("已预约", for: .normal)
                        btn.setBackgroundImage(UIImage.phInit(color: UIColor.red), for: .normal)
                    }
                    else{
                        btn.setTitle("预约", for: .normal)
                    }
                })

            }
            return btn
        }
        layout2.selectedCell = {index in
            if  index == 0 {
                self.dial(phone: self.model.phone)
            }
            if index == 1 {
                Request.judgeIsServer(goodsId: self.model.goodsId, response: { (success, msg, data) -> (Void) in
                    if success {
                        self.view.makeToast("该商品已预约！！",position:.center)
                        return
                    }
                    
                    let  datevc : QYDateViewController = QYDateViewController.init()
                    self.navigationController?.pushViewController(datevc, animated: true)
                    datevc.selectedDate = {date in
                        
                        let alert = QYReseverSubmitAlertView.init()
                        
                        alert.dateClosure = {
                            return date
                        }
                        alert.appear()
                        alert.submitClosure = {phone in
                            if phone.count <= 0{
                                (UIApplication.shared.delegate as! AppDelegate).window!.makeToast("请输入手机号",position:.center)
                                return
                            }
                            
                            alert.disAppear()
                            self.navigationController?.popViewController(animated: true)
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
                                
                                Request.addServer(goodsId: self.model.goodsId, response: { (success, msg, data) -> (Void) in
                                    if success {
                                        self.layout2.reload()
                                    }else{
                                        
                                    }
                                    self.view.makeToast(msg,position:.center)
                                })
                            })
                            
                            
                        }
                    }
                })
                
                
                
                
                
                
                
                
                
            }
            
        }
        layout2.reload()
     
        

        
        let labtalCommend : UILabel = UILabel.init()
        labtalCommend.backgroundColor = UIColor.white
        labtalCommend.font = UIFont.phMiddle
        labtalCommend.textColor = UIColor.phBlackText
        labtalCommend.text = "\n效果图"
        labtalCommend.numberOfLines = 0
        labtalCommend.textAlignment = .center
        scrollView.addSubview(labtalCommend)
        labtalCommend.snp.makeConstraints { (make) in
            make.top.equalTo(layout2.snp.bottom).offset(SCALE(size: 10))
            make.left.width.equalToSuperview()
            make.height.equalTo(SCALE(size: 40))
            
        }
        
        
        
        

        layout4.layout.type = .collection
        layout4.layout.column = 3
        self.scrollView.addSubview(layout4)
        layout4.snp.makeConstraints { (make) in
            make.top.equalTo(labtalCommend.snp.bottom)
            make.left.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        layout4.numberOfCell = {
            return self.model.imgs.count
        }

        
        layout4.cellForIndex = {index in
            let btn = UIButton.init()
            let imgDic = self.model.imgs[index]
            
            let img = UIImageView.init()
            img.contentMode = .scaleAspectFill
            img.clipsToBounds = true
            img.backgroundColor = UIColor.phBgContent
            img.kf.setImage(with: URL.init(string: "\(imgDic["url"] ?? "0")"))
            btn.addSubview(img)
            img.snp.makeConstraints({ (make) in
                make.left.top.equalToSuperview().offset(SCALE(size: 10))
                make.right.bottom.equalToSuperview().offset(SCALE(size: -10))
            })
            return btn
        }
        layout4.selectedCell = {index in
            
        
            let browser : PHPhotoBrowser = PHPhotoBrowser.init()
            
            
            var imgs : Array<(url: URL, title: String)> = Array.init()
            for imgDic in (self.model.imgs){
                var imgIi : (url: URL, title: String) = (url:URL.init(string: "0")!,title:"")
                imgIi.url = URL.init(string: imgDic["url"] as! String)!
                imgIi.title = ""
                
                
                imgs.append(imgIi)
            }
            
            browser.datas = imgs
            browser.index = index
            browser.appear()
        }
        layout4.reload()
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
