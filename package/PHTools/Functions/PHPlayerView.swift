//
//  PHPlayerView.swift
//  package
//
//  Created by Admin on 2019/3/4.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import AVFoundation

class PHPlayerView: UIView {
    

    var _url:URL?
    var url:URL{
        get{
            return _url!
        }
        set{
            _url = newValue
            self.refreshUI()
        }
    }
    private var currentPlayerItem : AVPlayerItem{
        get{
            return AVPlayerItem.init(url: self.url)
        }
    }
    private let playerLayer : AVPlayerLayer = AVPlayerLayer.init()
    private let player : AVPlayer = AVPlayer.init()
    
    
    private static let  shared : PHPlayerView = PHPlayerView.init()
    static func shared(url:URL) -> PHPlayerView{
        shared.url = url
        return shared
    }

    init() {
        super.init(frame: CGRect.zero)
    }
    init(url:URL) {
        super.init(frame: CGRect.zero)
        self.initUI()
        self.url = url
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initUI(){
        
        self.playerLayer.player = player
        self.playerLayer.frame = self.bounds
        self.layer.addSublayer(self.playerLayer)
    }
    func refreshUI() {
        self.player.replaceCurrentItem(with: self.currentPlayerItem)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer.frame = self.bounds
        
    }
    
    func startPlay()  {
        self.player.play()
        
    }
    func play(url:URL) {
        
        let urll = self.url
        self.url = urll
    }
    func stopPlay() {
        self.player.pause()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
