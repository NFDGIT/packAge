//
//  DetailViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {
    let scrollView : UIScrollView = UIScrollView.init()
    
    
    let carouse : PHCarouselView  = PHCarouselView.init()
    let layout1 = PHLayoutView.init()
    
    let layout3 = PHLayoutView.init()

    let userView : UserCellView = UserCellView.init()
    
    let layout4 = PHLayoutView.init()
    
    var layout3Datas : [(title:String,content:String)] = []
    var layout4Datas : Array<GoodsInfo> = Array.init()
    var info : GoodsInfo = GoodsInfo()
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
        
        let btnPhone : UIButton = UIButton.init(normalImg: UIImage.init(named: "detail_phone"))
        self.view.addSubview(btnPhone)
        btnPhone.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.bottom.equalToSuperview().offset(SCALE(size: -50))
            make.centerX.equalToSuperview()
        }
        btnPhone.phAddTarget(events: .touchUpInside) { (sender) in
            self.dial(phone: self.info.phone)
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
            
            
            if self.info.avatar.count <= 0 {
                self.info.avatar = "1"
            }
            
            img.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: self.info.avatar)!),placeholder: UIImage.init(named: "default"))
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
            let btn  : UIButton = UIButton.init(normalTitle: index == 0 ? "840元/月" : "三室一厅一卫", normalTextColor: UIColor.appTheme, font: nil)
            btn.titleLabel?.numberOfLines = 0
            btn.titleLabel?.textAlignment = .center
            if  index == 0 {
                
//                btn.setTitle("\(self.info.price)元/月\n价格", for: .normal)
                let att1 = NSMutableAttributedString.init(string: "\(self.info.price)元/月")
                let att2 = NSAttributedString.init(string: "\n价格", attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText])
                att1.append(att2)
                
                btn.setAttributedTitle(att1, for: .normal)
            }
            if  index == 1 {
//                btn.setTitle("\(self.info.bedroomNum)室\(self.info.liveroomNum)厅\(self.info.restroomNum)卫/月\n房型", for: .normal)
                let att1 = NSMutableAttributedString.init(string: "\(self.info.bedroomNum)室\(self.info.liveroomNum)厅\(self.info.restroomNum)卫")
                let att2 = NSAttributedString.init(string: "\n房型", attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText])
                att1.append(att2)
                btn.setAttributedTitle(att1, for: .normal)
            }
            
            return btn
        }
        layout1.reload()

        
        let layout2Datas : [(img:String,title:String)] = [("WIFI","WIFI"),("床","床"),("衣柜","衣柜"),("沙发","沙发"),("电视","电视"),("空调","空调")]
        let layout2 = PHLayoutView.init()
        layout2.layout.direction = .horizontal
        self.scrollView.addSubview(layout2)
        layout2.snp.makeConstraints { (make) in
            make.top.equalTo(layout1.snp.bottom).offset(SCALE(size: 10))
            make.left.width.equalToSuperview()
            make.height.equalTo(80)
        }
        layout2.numberOfCell = {
            return layout2Datas.count
        }
        layout2.cellForIndex = {index in
            let layout2Data = layout2Datas[index]
            
            let btn  : UIButton = UIButton.init(normalTitle: layout2Data.title, normalImg:UIImage.init(named: layout2Data.img), normalTextColor: UIColor.phBlackText, font: UIFont.phSmall)
            if index == 0 {}
            if index == 1 {}
            return btn
        }
        layout2.reload()
        for item in layout2.subviews {
            (item as! UIButton).phImagePosition(at: .top, space: 5)
        }
        



        layout3.layout.type = .collection
        layout3.layout.column = 2
        self.scrollView.addSubview(layout3)
        layout3.snp.makeConstraints { (make) in
            make.top.equalTo(layout2.snp.bottom).offset(SCALE(size: 10))
            make.left.width.equalToSuperview()

        }
        layout3.numberOfCell = {
            return self.layout3Datas.count
        }
        layout3.heightOfCell = { index in
            return 30
        }
        layout3.cellForIndex = {index in
            let layout3Data = self.layout3Datas[index]
            
            let btn  : UIButton = UIButton.init(normalTitle: layout3Data.title, normalTextColor: UIColor.phLightGrayText, font: nil)
            btn.contentHorizontalAlignment = .left
            
            let att1 = NSMutableAttributedString.init(string: "\(layout3Data.title)")
            let att2 = NSMutableAttributedString.init(string: layout3Data.content, attributes: [NSAttributedStringKey.foregroundColor:UIColor.phBlackText])
            att1.append(att2)
            
            btn.setAttributedTitle(att1, for: .normal)
            return btn
        }

        layout3.reload()
    
        
        
        self.scrollView.addSubview(userView)
        userView.snp.makeConstraints { (make) in
            make.top.equalTo(layout3.snp.bottom).offset(SCALE(size: 10))
            make.left.width.equalToSuperview()
        }
        userView.imgView.image = UIImage.init(named: "avatar")
        userView.labelTitle.text = "高旭先生"
        userView.labelSubtitle.text = "helo swift"
        
        
        
        let labtalCommend : UILabel = UILabel.init()
        labtalCommend.backgroundColor = UIColor.white
        labtalCommend.font = UIFont.phBig
        labtalCommend.textColor = UIColor.phBlackText
        labtalCommend.text = "\n推荐房源"
        labtalCommend.numberOfLines = 0
        labtalCommend.textAlignment = .center
        scrollView.addSubview(labtalCommend)
        labtalCommend.snp.makeConstraints { (make) in
            make.top.equalTo(userView.snp.bottom).offset(SCALE(size: 10))
            make.left.width.equalToSuperview()
            make.height.equalTo(SCALE(size: 40))
            
        }
        
        
        
        

        layout4.layout.type = .collection
        layout4.layout.column = 2
        self.scrollView.addSubview(layout4)
        layout4.snp.makeConstraints { (make) in
            make.top.equalTo(labtalCommend.snp.bottom)
            make.left.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        layout4.numberOfCell = {
            return self.layout4Datas.count
        }

        
        layout4.cellForIndex = {index in
            let model : GoodsInfo = self.layout4Datas[index]
            
            let btn : UIButton = UIButton.init()
            
            let  cell  : GoodsCollectionViewCell = GoodsCollectionViewCell.init(frame: CGRect.zero)
            cell.isUserInteractionEnabled = false
            cell.model = model
            
            btn.addSubview(cell)
            cell.snp.makeConstraints({ (make) in
                make.top.left.equalToSuperview().offset(SCALE(size: 10))
                make.right.bottom.equalToSuperview().offset(SCALE(size: -10))
            })
            
            return btn
        }
        layout4.selectedCell = {index in
            
        
            let model : GoodsInfo =  self.layout4Datas[index]
            let detail = DetailViewController.init()
            detail.Id = model.userId
            self.navigationController?.pushViewController(detail, animated: true)
        }
        layout4.reload()
    }
    func refreshData()  {
        Request.getGoodsInfo(userId: Id) { (success, msg, data) -> (Void) in
            if success {
                self.info = data!
                self.layout3Datas = [("   面积  ",self.info.roomArea),
                                     ("   方式  ",self.info.rentType),
                                     ("   装修  ",self.info.decorationState),
                                     ("   朝向  ",self.info.orientation)]
                
                
                self.refreshUI()


                
            }
        }
        Request.getUsers(pageNum: 0) { (success, msg, data) -> (Void) in
            if success {
                
                var i = 0
                while (i < data.count){
                    self.layout4Datas.append(GoodsInfo.init(dic: data[data.count-i-1] as! Dictionary<String, Any>))
                    
                    if i == 3 {
                        i = data.count
                    }
                    
                    
                    i = i + 1
                }
                self.layout4.reload()
                
                
            }
        }
        
        
    }
    func refreshUI()  {
        
        self.carouse.reload()
        self.layout1.reload()
        self.layout3.reload()
        self.userView.labelTitle.text = self.info.name
        self.userView.labelSubtitle.text = self.info.address
        
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
