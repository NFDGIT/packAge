//
//  QYCarViewController.swift
//  package
//
//  Created by Admin on 2019/3/10.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import MJRefresh

class ZYCarViewController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    var data : Array<ZYGoodsModel> = Array.init()
    var collectionView : UICollectionView?
    let bottomView : PHLayoutView = PHLayoutView.init()
    
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
        self.showNavi = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavi()
        self.initUI()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshData()
    }
    
    override func initNavi() {
        super.initNavi()
        self.navigationItem.title = "购物车"
    }
    
    override func initUI() {
        super.initUI()
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        layout.minimumLineSpacing = 1
        
        layout.minimumInteritemSpacing = 10
        
        layout.estimatedItemSize = CGSize.init(width: UIScreen.main.bounds.width-SCALE(size: 20), height: 50)
        //
        //        layout.estimatedItemSize = CGSize.init(width: 50, height: 30)
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        layout.sectionInset = UIEdgeInsetsMake(SCALE(size: 10), SCALE(size: 10), SCALE(size: 10), SCALE(size: 10))
        
        layout.headerReferenceSize = CGSize.init(width: self.view.frame.width, height: 1)
        
        
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.register(ZYCarCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collectionView!.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView!)
        collectionView!.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Status_Height())
            make.left.right.equalToSuperview()
        }
        collectionView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.refreshData()
        })
        collectionView?.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                self.collectionView?.mj_footer.endRefreshing()
            })
        })
        collectionView?.addEmptyView(emptyView: QYEmptyView.init(tip: "购物车为空"))
        
        
        
        
        
        self.view.addSubview(bottomView)
        bottomView.layout.column = 3
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo((collectionView?.snp.bottom)!)
            make.bottom.equalToSuperview().offset(-(Bottom_Tool_Height()+44))
        }
        bottomView.numberOfCell = {return 3}
        bottomView.cellForIndex = { index in
            let view : UIButton = UIButton.init()
         
            
            
            let btn = UIButton.init()
            btn.isUserInteractionEnabled = false
            view.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.top.equalToSuperview().offset(SCALE(size: 5))
                make.bottom.right.equalToSuperview().offset(SCALE(size: -5))
                

                make.height.equalTo(SCALE(size: 50))
            })
            
            
            if   index == 0 {
                btn.setTitleColor(UIColor.phBlackText, for: .normal)
                btn.setTitle("全选", for: .normal)
                btn.titleLabel?.font = UIFont.phMiddle
                btn.setImage(UIImage.init(named: "选择"), for: .normal)
                btn.setImage(UIImage.init(named: "选择1"), for: .selected)
                btn.isSelected = self.isAllSelected()
        
            }
            if index == 1{
    
                btn.setTitleColor(UIColor.phBlackText, for: .normal)
                btn.titleLabel?.font = UIFont.phMiddle
                btn.setTitle("合计：\(self.totalPrice())元", for: .normal)
            }
            if   index == 2{
                btn.backgroundColor = UIColor.appTheme
                btn.setTitle("结算", for: .normal)
                btn.phLayer(cornerRadius: SCALE(size: 25), borderWidth: 0)
                
            }

            
            return view
        }
        bottomView.selectedCell = {index in
            if index == 0
            {
                if self.data.count == 0
                {
                    self.view.makeToast("购物车为空",position:.center)
                    return
                    
                }
                
                self.toAllSelect(isAllSelect: !self.isAllSelected())
                self.collectionView?.reloadData()
                self.bottomView.reload()
                

  
            }
            
            if index == 2 {
                
                self.placeOrder()
            }

        }
        bottomView.reload()
    
        
        
        
    }
    func refreshData()  {
        self.data.removeAll()
        self.view.makeToastActivity(.center)
        Request.getGoods { (success, msg, data) -> (Void) in
            self.view.hideToastActivity()
            self.collectionView?.mj_header.endRefreshing()
            self.collectionView?.mj_footer.endRefreshing()
            
            if success {
                self.collectionView?.setIsEmpty(isEmpty:true)
                
                for dataitem in data
                {
                    let model = ZYGoodsModel.init(dic: dataitem as! Dictionary<String, Any>)
                    
                    for reserver in Request.reserverList
                    {
                        if reserver == model.goodsId
                        {
                            self.data.append(model)
                               self.collectionView?.setIsEmpty(isEmpty:false)
                        }
                    }
                }
                
                
                self.collectionView?.reloadData()
            }
            else
            {
                self.collectionView?.setIsEmpty(isEmpty: true)
                self.view.makeToast(msg,position:.center)
            }
            
        }
    }
    
    func toAllSelect(isAllSelect:Bool)  {
        let temdata = self.data
        
        for (index,dataitem) in temdata.enumerated(){
            dataitem.isSelected = isAllSelect
            self.data[index] = dataitem
        }
    }
    func isAllSelected() -> Bool {
        var isAllSelected = true
        if  self.data.count != 0 {
            for dataitem in self.data
            {
                if dataitem.isSelected == false
                {
                    isAllSelected = false
                }
            }
        }else
        {
            isAllSelected = false
        }
        

        return isAllSelected
    }
    func totalPrice() -> Float {
        var totalPrice  : Float = 0.00
        for dataitem in self.data
        {
            if dataitem.isSelected == true
            {
                totalPrice = totalPrice + Float(dataitem.price)! * (Float(dataitem.number!))
            }
        }
        return totalPrice
    }
    func placeOrder()  {
        
        
        var  selectGoodids : Array<String> = Array.init()
        for dataitem in self.data
        {
            if dataitem.isSelected == true
            {
                selectGoodids.append(dataitem.goodsId)
            }
        }
        if self.data.count <= 0
        {
            self.view.makeToast("购物车为空！",position:.center)
            return
        }
        if selectGoodids.count <= 0 {
            self.view.makeToast("请选择商品！",position:.center)
            return
        }
        let placeorder = ZYPlaceOrderViewController.init()
        placeorder.goodids = selectGoodids
        self.navigationController?.pushViewController(placeorder, animated: true)
        placeorder.submitCallBack = {
            self.refreshData()
            self.bottomView.reload()
            
            
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension ZYCarViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ZYCarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZYCarCollectionViewCell
        cell.indexPath = indexPath
        cell.model = self.data[indexPath.section]
        cell.selectCallBack = {indexP in
            let model : ZYGoodsModel = self.data[indexP.section]
            model.isSelected = !model.isSelected!
            self.data[indexP.section] = model
            self.collectionView?.reloadData()
            self.bottomView.reload()
        }
        cell.numberChangeCallback = {(indexP,numbe) in
            let model : ZYGoodsModel = self.data[indexP.section]
            model.number = numbe
            if numbe <= 0
            {
                self.data.remove(at: indexP.section)
                Request.deleteServer(goodsIds: [model.goodsId], response: { (success, msg, data) -> (Void) in
                    
                })
            }else
            {
                self.data[indexP.section] = model
            }
            
            

            self.collectionView?.reloadData()
            self.bottomView.reload()
            
            
            
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.data[indexPath.section]
        
        let detail = ZYDetailViewController.init()
        detail.model = model
        
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
extension ZYCarViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
}
