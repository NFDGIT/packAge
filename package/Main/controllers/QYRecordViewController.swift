//
//  QYRecordViewController.swift
//  package
//
//  Created by Admin on 2019/3/4.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import AVFoundation
import Photos


class QYRecordViewController: BaseViewController ,AVCaptureFileOutputRecordingDelegate{

    
    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = false
        self.showNavi = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //视频捕获会话。它是input和output的桥梁。它协调着intput到output的数据传输
    let captureSession = AVCaptureSession()
    //视频输入设备
    let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
    //音频输入设备
    let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
    //将捕获到的视频输出到文件
    let fileOutput = AVCaptureMovieFileOutput()
    
    //开始、停止按钮
    var startButton, stopButton : UIButton!
    //表示当时是否在录像中
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //添加视频、音频输入设备
        let videoInput = try! AVCaptureDeviceInput(device: self.videoDevice!)
        self.captureSession.addInput(videoInput)
        let audioInput = try! AVCaptureDeviceInput(device: self.audioDevice!)
        self.captureSession.addInput(audioInput);
        
        //添加视频捕获输出
        self.captureSession.addOutput(self.fileOutput)
        
        //使用AVCaptureVideoPreviewLayer可以将摄像头的拍摄的实时画面显示在ViewController上
        let videoLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        videoLayer.frame = self.view.bounds
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(videoLayer)
        
        //创建按钮
        self.setupButton()
        //启动session会话
        self.captureSession.startRunning()
        // Do any additional setup after loading the view.
    }
    
    
    //创建按钮
    func setupButton(){
        
        
        //创建开始按钮
        self.startButton = UIButton(frame: CGRect.init(x: 0, y: 0, width:120 , height: 50))
        self.startButton.backgroundColor = UIColor.red;
        self.startButton.layer.masksToBounds = true
        self.startButton.setTitle("开始", for: .normal)
        self.startButton.layer.cornerRadius = 20.0
        self.startButton.layer.position = CGPoint(x: self.view.bounds.width/2 - 70,
                                                  y:self.view.bounds.height-50)
        self.startButton.addTarget(self, action: #selector(onClickStartButton(sender:)), for: .touchUpInside)
        
        //创建停止按钮
        self.stopButton = UIButton(frame: CGRect.init(x: 0, y: 0, width:120 , height: 50))
        self.stopButton.backgroundColor = UIColor.gray
        self.stopButton.layer.masksToBounds = true
        self.stopButton.setTitle("停止", for: .normal)
        self.stopButton.layer.cornerRadius = 20.0
        
        self.stopButton.layer.position = CGPoint(x: self.view.bounds.width/2 + 70,
                                                 y:self.view.bounds.height-50)
        self.stopButton.addTarget(self, action: #selector(onClickStopButton(sender:)), for: .touchUpInside)
        
        //添加按钮到视图上
        self.view.addSubview(self.startButton);
        self.view.addSubview(self.stopButton);
    }


    
    
    //开始按钮点击，开始录像
    @objc func onClickStartButton(sender: UIButton){
        if !self.isRecording {
            //设置录像的保存地址（在Documents目录下，名为temp.mp4）
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                            .userDomainMask, true)
            let documentsDirectory = paths[0] as String
            let filePath : String? = "\(documentsDirectory)/temp.mp4"
            let fileURL : NSURL = NSURL(fileURLWithPath: filePath!)
            //启动视频编码输出
            fileOutput.startRecording(to: fileURL as URL, recordingDelegate: self)
            
            //记录状态：录像中...
            self.isRecording = true
            //开始、结束按钮颜色改变
            self.changeButtonColor(target: self.startButton, color: UIColor.gray)
            self.changeButtonColor(target: self.stopButton, color: UIColor.red)
        }
    }
    
    //停止按钮点击，停止录像
    @objc func onClickStopButton(sender: UIButton){
        if self.isRecording {
            //停止视频编码输出
            fileOutput.stopRecording()
            
            //记录状态：录像结束
            self.isRecording = false
            //开始、结束按钮颜色改变
            self.changeButtonColor(target: self.startButton, color: UIColor.red)
            self.changeButtonColor(target: self.stopButton, color: UIColor.gray)
        }
    }
    //修改按钮的颜色
    func changeButtonColor(target: UIButton, color: UIColor){
        target.backgroundColor = color
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

extension QYRecordViewController{
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        
        self.view.makeToastActivity(.center)
        NetTool.upload(url: "http://192.168.10.6:5000", fileUrl: outputFileURL) { (res) -> (Void) in
            self.view.hideToastActivity()
            
            if res.success {
                
            }
            
            self.view!.makeToast("\(res.data)",position:.center)
        }
//        var message:String!
//        //将录制好的录像保存到照片库中
//        PHPhotoLibrary.shared().performChanges({
//            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL as URL)
//        }) { (isSuccess, error) in
//            if isSuccess {
//                message = "保存成功!"
//            } else{
//                message = "保存失败：\(error!.localizedDescription)"
//            }
//            DispatchQueue.main.async(execute: {
//                //弹出提示框
//                let alertController = UIAlertController(title: message,
//                                                        message: nil, preferredStyle: .alert)
//                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//                alertController.addAction(cancelAction)
//                self.present(alertController, animated: true, completion: {
//
//                })
//
//            })
//        }
//

        
    }
   

}
