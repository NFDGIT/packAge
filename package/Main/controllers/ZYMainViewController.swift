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
import JavaScriptCore

class ZYMainViewController: BaseViewController {

    let mainScrollView : UIScrollView = UIScrollView.init(frame: CGRect.zero)
    var carouseDatas : Array<ZYGoodsModel> = Array.init()
    let carouse = PHCarouselView.init(direction: .horizontal)
    
    var noticeDatas : Array<ZYGoodsModel> = Array.init()

    
    let layoutCategory = PHLayoutView.init()
    var layoutView1Data : Array<ZYGoodsModel> = Array.init()
    let layoutView1 = PHLayoutView.init()
    
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
        self.showNavi = false
    
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNavi()
        
        self.initUI()
        self.refreshData()
   
        
        let crypto = PHCryptoTool.shared();
        let result = crypto.encryptString("hello", keyString: "abc", iv: nil);
        
        let resul1 = crypto.decryptString(result, keyString: "abc", iv: nil);
        
        
        
//        let context = JSContext();
//        context?.exceptionHandler = { (jsContext:JSContext!,exception:JSValue!) ->Void in
//            jsContext.exception = exception;
//            print(exception);
//        }
//       
//
//
//        
//        
//        context?.evaluateScript("""
//                                    var fun = function(value){
//                                        return   value.split('').reverse().join('')
//                                     }
//                                """)
//        let fun = context?.objectForKeyedSubscript("fun")
//        let result =  fun?.call(withArguments: ["hello swift"])
//        
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
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(-Status_Height())
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(Status_Height())
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
            make.left.equalToSuperview()
            make.right.equalTo(self.view.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(SCALE(size: 200)+Status_Height())
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
                make.edges.equalToSuperview()
            })

            return view
        }
        carouse.selectedCell = {index in

            let model = self.carouseDatas[index]

            let detail = ZYGoodDetailViewController.init()
            detail.model = model

            self.navigationController?.pushViewController(detail, animated: true)
        }
        carouse.startAutoScroll()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
            self.carouse.reload()
        }


//        var categoryvalues = [(type:"铁观音",selected:true),(type:"金骏眉",selected:false),(type:"洞庭碧螺春",selected:false),(type:"大红袍",selected:false),(type:"西湖龙井",selected:false)]
        
        
        
        let layoutCategoryBg = UIScrollView.init()
        self.mainScrollView.addSubview(layoutCategoryBg)
        layoutCategoryBg.snp.makeConstraints { (make) in
            make.top.equalTo(carouse.snp.bottom)
            make.left.width.equalToSuperview()
            make.height.equalTo(SCALE(size: 160))
        }

        

        layoutCategoryBg.addSubview(layoutCategory)
        layoutCategory.numberOfCell = {return self.carouseDatas.count}
        layoutCategory.cellForIndex = {index in
            let model = self.carouseDatas[index]
            
            let btn = UIButton.init()
            btn.backgroundColor = UIColor.phBgContent
            
            let cell : ZYGoodsCellView = ZYGoodsCellView.init()
            cell.isUserInteractionEnabled = false
            btn.addSubview(cell)
            
            
            cell.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
                make.width.equalTo(SCALE(size: 100))
                
            })
            
            cell.model = model
            return btn
        }

        
        
        layoutCategory.layout.column = 0
        layoutCategory.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
//            make.width.equalToSuperview()
        }
        layoutCategory.selectedCell = {index in
            let model = self.layoutView1Data[index]
            
            let detail = ZYGoodDetailViewController.init()
            detail.model = model
            
            self.navigationController?.pushViewController(detail, animated: true)
        }
        layoutCategory.reload()

        

     
        
       
        
  
        
        


        layoutView1.layout.isAutoHeight = true
        mainScrollView.addSubview(layoutView1)
        layoutView1.snp.makeConstraints { (make) in
            make.top.equalTo(layoutCategoryBg.snp.bottom)
            make.left.width.bottom.equalToSuperview()
        }
//        layoutView1.heightOfCell = { index in
//            return Double(SCALE(size: 5))
//        }
        layoutView1.numberOfCell = {
            return self.layoutView1Data.count
        }
       layoutView1.layout.column = 2
        layoutView1.cellForIndex = {index in
            let model = self.layoutView1Data[index]
            
            let btn = UIButton.init()
            btn.backgroundColor = UIColor.phBgContent
        
            let cell : ZYGoodsCellView = ZYGoodsCellView.init()
            cell.isUserInteractionEnabled = false
            btn.addSubview(cell)
            
            
            cell.snp.makeConstraints({ (make) in
                make.left.top.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(SCALE(size: -1))
            })
            
            cell.model = model
            return btn
        }
        layoutView1.selectedCell = {index in
            let model = self.layoutView1Data[index]

            let detail = ZYGoodDetailViewController.init()
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
                    self.carouseDatas.append(ZYGoodsModel.init(dic: dataitem as! Dictionary<String, Any>))
                    self.carouse.reload()
                    self.layoutCategory.reload()
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

                    self.layoutView1Data.append(ZYGoodsModel.init(dic: dataitem as! Dictionary<String, Any>))
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
extension ZYMainViewController{
    func reverse(x:Int) -> Int {
        let xString : String = "\(x)"
        let isSign = xString.contains("-") || xString.contains("+")
        let count : Int = xString.count - (isSign ? 1 : 0) / 2
        
        
        for index in 0..<count {

        }

        return  Int(xString)!
    }
}
