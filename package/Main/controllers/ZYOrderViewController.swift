//
//  QYOrderViewController.swift
//  package
//
//  Created by Admin on 2019/3/11.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ZYOrderViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource  {
    
    var type : Int = 0
    
    var data: Array<ZYOrderModel> = Array.init()
    let tableView : UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavi()
        self.initUI()
        self.refreshData()
    }
    override func initNavi() {
        super.initNavi()
        self.title = "订单"
    }
    override func initUI() {
        super.initUI()
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QYOrderTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.addEmptyView(emptyView: QYEmptyView.init( tip: "该类订单为空"))
        
    }
    func refreshData()  {
        
        self.data.removeAll()
        self.view.makeToastActivity(.center)
        let userid : String = "\(Request.getLocalUserInfo()["user_id"] ?? "")"
        Request.getOrderList(userId: userid) { (success, msg, data) -> (Void) in
            self.view.hideToastActivity()

            if success {
                
            
                for datadic in data
                {
                    if self.type == 0
                    {
                       self.data.append(ZYOrderModel.init(dic: datadic) )
                    }

                }
                self.tableView.reloadData()
            }
            else
            {
                self.view.makeToast(msg,position:.center)
            }
            
            self.tableView.setIsEmpty(isEmpty: self.data.count == 0)
        }
        
//                self.data.append(QYGoodsModel.init())
//                self.tableView.reloadData()
    }

}
extension ZYOrderViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : QYOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QYOrderTableViewCell
        cell.indexPath = indexPath
        cell.model = self.data[indexPath.section]
        cell.cancelCallBack = {indexP in
            
            let currentmodel = self.data[indexP.section]
            Request.cancelOrder(orderId: currentmodel.orders_id, response: { (success, msg, data) -> (Void) in

                
                if success {
                    
                    self.view.makeToast("取消成功",position:.center)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
                        self.refreshData()
                    })
                }
                else
                {
                    self.view.makeToast(msg,position:.center)
                }
                
            })
        }
        return cell
    }
}


class QYOrderTableViewCell: UITableViewCell {
    private var _model : ZYOrderModel?
    var model : ZYOrderModel?{
        get{
            return _model
        }
        set{
            _model = newValue
            self.refreshUI()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initUI()
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var cancelCallBack:((IndexPath)->())?
    
    var btn1 : UIButton = UIButton.init()
    var btn2 : UIButton = UIButton.init()
    var btn3 : UIButton = UIButton.init()
    var btn4 : UIButton = UIButton.init()
    var btn5 : UIButton = UIButton.init()
    var btn6 : UIButton = UIButton.init()
    var btn7 : UIButton = UIButton.init()

    
    
    func initUI()  {
        self.contentView.addSubview(btn1)
        btn1.setTitleColor(UIColor.phBlackText, for: .normal)
        btn1.contentHorizontalAlignment = .left
        btn1.titleLabel?.font = UIFont.phMiddle
        
        self.contentView.addSubview(btn2)
        btn2.setTitleColor(UIColor.phBlackText, for: .normal)
        btn2.contentHorizontalAlignment = .right
        btn2.titleLabel?.font = UIFont.phMiddle
        
        self.contentView.addSubview(btn3)
        btn3.setTitleColor(UIColor.phBlackText, for: .normal)
        btn3.contentHorizontalAlignment = .left
        btn3.titleLabel?.font = UIFont.phMiddle
        
        self.contentView.addSubview(btn4)
        btn4.setTitleColor(UIColor.phBlackText, for: .normal)
        btn4.contentHorizontalAlignment = .right
        btn4.titleLabel?.font = UIFont.phMiddle
        
        self.contentView.addSubview(btn5)
        btn5.setTitleColor(UIColor.phBlackText, for: .normal)
        btn5.contentHorizontalAlignment = .left
        btn5.titleLabel?.font = UIFont.phMiddle
        
        self.contentView.addSubview(btn6)
        btn6.setTitleColor(UIColor.phBlackText, for: .normal)
        btn6.contentHorizontalAlignment = .right
        btn6.titleLabel?.font = UIFont.phMiddle
        
        self.contentView.addSubview(btn7)
        btn7.phLayer(cornerRadius: 5, borderWidth: 0)
        btn7.setBackgroundImage(UIImage.phInit(color: UIColor.appTheme), for: .normal)
        btn7.setTitleColor(UIColor.white, for: .normal)
        btn7.titleLabel?.font = UIFont.phMiddle
        btn7.setTitle("取消订单", for: .normal)
        btn7.phAddTarget(events: .touchUpInside) { (sender) in
            if self.cancelCallBack != nil
            {
                self.cancelCallBack!(self.indexPath!)
            }
        }

    }
    func layout() {
        btn1.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(SCALE(size: 10))
            make.height.equalTo(SCALE(size: 20))
            make.width.equalTo(SCALE(size: 200))
        }
        
        
        btn2.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(SCALE(size: 10))
            make.right.equalToSuperview().offset(SCALE(size: -10))
            make.height.equalTo(SCALE(size: 20))
            make.width.equalTo(SCALE(size: 200))
        }
        
        
        btn3.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(SCALE(size: 10))
            make.top.equalTo(btn1.snp.bottom).offset(SCALE(size: 5))
            make.height.equalTo(SCALE(size: 20))
            make.width.equalTo(SCALE(size: 200))
        }
        
        
        btn4.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(SCALE(size: -10))
            make.top.equalTo(btn1.snp.bottom).offset(SCALE(size: 5))
            make.height.equalTo(SCALE(size: 20))
            make.width.equalTo(SCALE(size: 200))
        }
        
        
        btn5.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(SCALE(size: 10))
            make.top.equalTo(btn3.snp.bottom).offset(SCALE(size: 5))
            make.height.equalTo(SCALE(size: 20))
            make.width.equalTo(SCALE(size: 200))
        }
        
        
        btn6.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(SCALE(size: -10))
            make.top.equalTo(btn3.snp.bottom).offset(SCALE(size: 5))
            make.height.equalTo(SCALE(size: 20))
            make.width.equalTo(SCALE(size: 200))
        }
        
        
        btn7.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(SCALE(size: -10))
            make.top.equalTo(btn5.snp.bottom).offset(SCALE(size: 10))
            make.height.equalTo(SCALE(size: 30))
            make.width.equalTo(SCALE(size: 100))
            make.bottom.equalToSuperview().offset(SCALE(size: -10))
        }
        
    }
    func refreshUI()  {
        btn1.setTitle("订单号：\(model?.orders_outtradeno ?? "")", for: .normal)
        btn2.setTitle("日期：\(model?.orders_date ?? "")", for: .normal)
        btn3.setTitle("用户：\(model?.orders_name ?? "")", for: .normal)
        btn4.setTitle("\(model?.orders_tel ?? "")", for: .normal)
        btn5.setTitle("订单号：\(model?.orders_outtradeno ?? "")", for: .normal)
        btn6.setTitle("商品编号：\(model?.orders_wuid ?? "")", for: .normal)
        
        
    }
}
