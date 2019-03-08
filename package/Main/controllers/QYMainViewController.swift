//
//  ViewController.swift
//  package
//
//  Created by Admin on 2019/2/12.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Kingfisher
import MJRefresh

class QYMainViewController: BaseViewController {

    let mainScrollView : UIScrollView = UIScrollView.init(frame: CGRect.zero)
    var carouseDatas : Array<QYGoodsModel> = Array.init()
    let carouse = PHCarouselView.init(direction: .horizontal)
    
    var carouseDatas1 : Array<QYGoodsModel> = Array.init()
    let carouse1 = PHCarouselView.init(direction: .vertical)
    
    
    var layoutView1Data : Array<QYGoodsModel> = Array.init()
    let layoutView1 = PHLayoutView.init()
    
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
        self.showNavi = true
    
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        
    
        super.viewDidLoad()
        self.initNavi()
        
        self.initUI()
        self.refreshData()
   
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func initNavi() {
        super.initNavi()
     
        self.title = "首页"
    }
    
    
    
    override func initUI() {
        super.initUI()
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    
        mainScrollView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.refreshData()
        })
        mainScrollView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                self.mainScrollView.mj_footer.endRefreshing()
            })
        })
        
        
        mainScrollView.addSubview(carouse)
        carouse.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(SCALE(size: 20))
            make.right.equalTo(self.view.snp.right).offset(SCALE(size: -20))
            make.top.equalToSuperview()
            make.height.equalTo(SCALE(size: 200))
//            make.bottom.equalToSuperview()
        }
        carouse.scrollView.clipsToBounds = false
        carouse.numberCell = {
            return self.carouseDatas.count
        }
        carouse.cellForIndex = { index in
             let model = self.carouseDatas[index]
            
            let view = UIView.init()
            
        
            let img = UIImageView.init()
            img.contentMode = .scaleAspectFill
            img.isUserInteractionEnabled = false
            view.addSubview(img)
            img.backgroundColor = UIColor.phBgContent
            img.kf.setImage(with: URL.init(string: model.avatar))
            img.phLayer(cornerRadius: 10, borderWidth: 0)
            img.snp.makeConstraints({ (make) in
                make.left.top.equalTo(SCALE(size: 10))
                make.bottom.right.equalTo(SCALE(size: -10))
            })
    
            return view
        }
        carouse.selectedCell = {index in

            let model = self.carouseDatas[index]
            
            let detail = QYDetailViewController.init()
            detail.model = model
            
            self.navigationController?.pushViewController(detail, animated: true)
        }
        carouse.startAutoScroll()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
            self.carouse.reload()
        }



     
        
        mainScrollView.addSubview(carouse1)
    
        carouse1.backgroundColor = UIColor.phBgContent
        carouse1.pageControl.isHidden = true
        carouse1.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(carouse.snp.bottom)
            make.height.equalTo(SCALE(size: 50))

        }
        carouse1.numberCell = {
            return self.carouseDatas.count
        }
        carouse1.cellForIndex = { index in
            let model = self.carouseDatas[index]
            
            let view = UIView.init()
            
            let btn = UIButton.init()
            btn.isUserInteractionEnabled = false
            btn.phLayer(cornerRadius: 10, borderWidth: 0)
            btn.backgroundColor = UIColor.phBgContent
            btn.titleLabel?.font = UIFont.phMiddle
            view.addSubview(btn)
            btn.setTitle(model.name, for: .normal)
            btn.setTitleColor(UIColor.appTheme, for: .normal)
            btn.snp.makeConstraints({ (make) in
                make.left.top.equalToSuperview().offset(SCALE(size: 10))
                make.bottom.right.equalToSuperview().offset(SCALE(size: -10))
            })
            return view
        }
        carouse1.selectedCell = {index in
            
            let model = self.carouseDatas[index]
            
            let detail = QYDetailViewController.init()
            detail.model = model
            
            self.navigationController?.pushViewController(detail, animated: true)
        }
   
        carouse1.startAutoScroll()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            self.carouse1.reload()
        }

  
        
        

        layoutView1.layout.type = .table
        layoutView1.layout.isAutoHeight = true
        mainScrollView.addSubview(layoutView1)
        layoutView1.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview()
            make.top.equalTo(carouse1.snp.bottom)
            make.width.equalToSuperview()
            
            make.bottom.equalToSuperview()
        }
//        layoutView1.heightOfCell = { index in
//            return Double(SCALE(size: 5))
//        }
        layoutView1.numberOfCell = {
            return self.layoutView1Data.count
        }
        layoutView1.cellForIndex = {index in
            let model = self.layoutView1Data[index]
            
            let btn = UIButton.init()
            btn.backgroundColor = UIColor.phBgContent
        
            let cell : QYGoodsCellView = QYGoodsCellView.init()
            cell.isUserInteractionEnabled = false
            btn.addSubview(cell)
            
            
            cell.snp.makeConstraints({ (make) in
                make.left.top.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(SCALE(size: -1))
            })
            cell.model = model
//
            
            return btn
        }
        layoutView1.selectedCell = {index in
            let model = self.layoutView1Data[index]
            
            let detail = QYDetailViewController.init()
            detail.model = model
            
            self.navigationController?.pushViewController(detail, animated: true)
        }
        layoutView1.reload()

        
    }
    

    
    func refreshData(){

//        self.carouseDatas = [GoodsInfo.getRandomInfo(),GoodsInfo.getRandomInfo(),]
//        self.carouse.reload()
        
        self.carouseDatas.removeAll()
        Request.getCarousel { (success, msg, data) -> (Void) in
            if success {
                for dataitem in data
                    
                {
                    self.carouseDatas.append(QYGoodsModel.init(dic: dataitem as! Dictionary<String, Any>))
                    self.carouse.reload()
                }
            }
            else
            {
                self.view.makeToast(msg,position:.center)
            }
        }
        
        
        

        self.layoutView1Data.removeAll()
        self.view.makeToastActivity(.center)
        Request.getGoods { (success, msg, data) -> (Void) in
            self.view.hideToastActivity()
            self.mainScrollView.mj_header.endRefreshing()
            self.mainScrollView.mj_footer.endRefreshing()
            
            if success {
                for dataitem in data
     
                {
                    
                    self.layoutView1Data.append(QYGoodsModel.init(dic: dataitem as! Dictionary<String, Any>))
                    self.layoutView1.reload()
                }
            }
            else
            {
                self.view.makeToast(msg,position:.center)
            }
        }
    }
    
}
