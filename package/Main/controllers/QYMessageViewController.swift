//
//  QYMessageViewController.swift
//  package
//
//  Created by Admin on 2019/3/5.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import MJRefresh

class QYMessageViewController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    var collectionView : UICollectionView?
    var data : Array<QYMessageModel> = Array.init()
    
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
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
        self.navigationItem.title = "消息"
    }

    override func initUI() {
        super.initUI()
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
        
        layout.estimatedItemSize = CGSize.init(width: UIScreen.main.bounds.width - 30, height: 50)
//
//        layout.estimatedItemSize = CGSize.init(width: 50, height: 30)
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
//        layout.headerReferenceSize = CGSize.init(width: self.view.frame.width, height: 20)

        
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.register(QYMessageCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collectionView!.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView!)
        collectionView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.refreshData()
        })
        collectionView?.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                self.collectionView?.mj_footer.endRefreshing()
            })
        })
        
    }
    
    func refreshData()  {
        self.data.removeAll()
        self.view.makeToastActivity(.center)
        Request.getMessage { (success, msg, data) -> (Void) in
            self.view.hideToastActivity()
            self.collectionView?.mj_header.endRefreshing()
            self.collectionView?.mj_footer.endRefreshing()
            
            if success {
                for dataitem in data
                {
                    self.data.append(QYMessageModel.init(dic: dataitem as! Dictionary<String, Any>))
                    self.collectionView?.reloadData()
                }
            }
            else
            {
                self.view.makeToast(msg,position:.center)
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
extension QYMessageViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : QYMessageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QYMessageCollectionViewCell
        cell.model = self.data[indexPath.section]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model : QYMessageModel = self.data[indexPath.section]
        
      let htmlString =  """
        <html>
        <head>
        <title>\(model.name)</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        </head>
        <body>
        <p  style="text-align:center;text-color:rgba(100,100,100,0.8)">
        \(model.content)
        </p>

        </body>
        </html>
        """
        let webVC = PHBaseWebViewController.init()
        webVC.webView.loadHTMLString(htmlString, baseURL: nil)
        webVC.webView.webLoadCallBack = { status in
            if (status == .finish)
            {
                webVC.title = webVC.webView.title
            }
            
        }
        
        self.navigationController?.pushViewController(webVC, animated: true)
        
    }
}
