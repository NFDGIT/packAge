//
//  QYPlayerView.swift
//  package
//
//  Created by Admin on 2019/3/4.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit


class ZYPlayerView: UIView {
    var url : URL?
    
    var playerView : PHPlayerView?
    
    init(url:URL) {
        super.init(frame: CGRect.zero)
        self.url = url
        
        self.initUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI()  {
        playerView = PHPlayerView.init(url: self.url!)
        self.addSubview(playerView!)
        playerView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
     
        
        let btn : UIButton = UIButton.init()
        btn.backgroundColor = UIColor.red
        self.addSubview(btn)
        btn.snp.makeConstraints({ (make) in
            make.width.height.equalTo(SCALE(size: 40))
            make.center.equalToSuperview()
        })
        btn.phAddTarget(events: .touchUpInside, callBack: { (sender) in
            self.playerView!.startPlay()
        })
        
        
        let btn1 : UIButton = UIButton.init()
        btn1.phLayer(cornerRadius: SCALE(size: 20), borderWidth: 0)
        btn1.backgroundColor = UIColor.phBgContent
        self.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            make.height.width.equalTo(SCALE(size: 40))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
