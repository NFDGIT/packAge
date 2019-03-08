//
//  PHPhotoBrowser.swift
//  package
//
//  Created by Admin on 2019/3/1.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PHPhotoBrowser: UIView ,UIScrollViewDelegate,UIGestureRecognizerDelegate{
    let scrollView : UIScrollView = UIScrollView.init()
    
    private var _datas : Array<(url:URL,title:String)> = Array.init()
    var datas : Array<(url:URL,title:String)> {
        get{
            return _datas
        }
        set{
            _datas = newValue
            self.reload()
        }
    }
    var _index : Int = 0
    var index : Int{
        get{
            return _index
        }
        set{
            _index = newValue
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
               self.scrollView.contentOffset = CGPoint.init(x: CGFloat(self.index)*self.scrollView.frame.width, y: 0)
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.initUI()
//        self.reload()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI()  {
        self.backgroundColor = UIColor.black
        self.addGesture()
        
        
        scrollView.isPagingEnabled = true
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
     
    }
    func reload()  {
        
        
        var temView : UIView?
        for i in 0..<self.datas.count {
            
            let subScroll  : UIScrollView = UIScrollView.init()
            scrollView.addSubview(subScroll)
            subScroll.delegate = self
            subScroll.minimumZoomScale = 1
            subScroll.maximumZoomScale = 4
        
            subScroll.snp.makeConstraints { (make) in
                if temView == nil {
                    make.left.equalTo(0)
                }else{
                    make.left.equalTo((temView?.snp.right)!)
                }
                
                make.top.width.height.equalToSuperview()
                if i == self.datas.count - 1 {
                    make.right.equalToSuperview()
                }
                temView = subScroll
            }
            
            let data = datas[i]
            let  img : UIImageView = UIImageView.init()
            subScroll.addSubview(img)
            
            img.tag = 100
            img.contentMode = .scaleAspectFit
            img.backgroundColor = UIColor.black
//            img.backgroundColor = UIColor.init(red: CGFloat(PHConstant.getRandomNumber(min: 0, max: 9)) / 10.00, green: CGFloat(PHConstant.getRandomNumber(min: 0, max: 9)) / 10.00, blue: CGFloat(PHConstant.getRandomNumber(min: 0, max: 9)) / 10.00, alpha: 1)
            img.kf.setImage(with: data.url)
            
            img.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.width.height.equalToSuperview()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.scrollView.contentSize = CGSize.init(width: CGFloat(self.datas.count) * self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
        }

    }
    
    
    func addGesture()  {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
        
        
//        let ges : UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(ges:)))
//        ges.delegate = self as UIGestureRecognizerDelegate
//        self.addGestureRecognizer(ges)
    }
    
    @objc func panAction(ges:UIGestureRecognizer) {
       
    }
    @objc func tapAction(tap:UITapGestureRecognizer)  {
        self.disAppear()
    }
    
    
    
    func appear() {
    
        self.alpha = 0
        (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1
        }) { (completed) in
        }
    }
    func disAppear()  {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { (completed) in
            self.removeFromSuperview()
        }
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        let subScroll = scrollView.viewWithTag(100)
        return subScroll
    }
    
}

