//
//  PHVideoRecord.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import AVFoundation
class PHCaptureManager: NSObject,AVCaptureFileOutputRecordingDelegate {
    
    
    func startRecord(captureSession:AVCaptureSession,fileOut:AVCaptureMovieFileOutput) {
        captureSession.startRunning()
        
        //  设置录像保存地址，在 Documents 目录下，名为 当前时间.mp4
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = path[0] as String
        let filePath: String? = "\(documentDirectory)/\(Date()).mp4"
        let fileUrl: NSURL? = NSURL(fileURLWithPath: filePath!)
        //  启动视频编码输出
        fileOut.startRecording(to: fileUrl! as URL, recordingDelegate: self as AVCaptureFileOutputRecordingDelegate)
    }
    
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
    }
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        
    }
    
    
    //  MARK: - 录像代理方法
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        //  开始
    }
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        //  结束
        //        self.operatorView.getVideoUrl(outputFileURL)
    }
    
    
}
class PHCaptureObject: NSObject {

    //  MARK: - Properties ，
    //  视频捕获会话，他是 input 和 output 之间的桥梁，它协调着 input 和 output 之间的数据传输
    let captureSession = AVCaptureSession()
    
    
    //  视频输入设备，前后摄像头
    private  var camera: AVCaptureDevice?
    //  展示界面
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    //  音频输入设备
    private let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
    //  将捕获到的视频输出到文件
    let fileOut = AVCaptureMovieFileOutput()
    //  MARK: - Private Methods
    
    override init() {
        super.init()
        
        camera = self.cameraWithPosition(position: AVCaptureDevice.Position.back)
        
        //  设置视频清晰度，这里有很多选择
        captureSession.sessionPreset = AVCaptureSession.Preset.vga640x480
        
        //  添加视频、音频输入设备
        if let videoInput = try? AVCaptureDeviceInput(device: self.camera!) {
            self.captureSession.addInput(videoInput)
        }
        if let audioInput = try? AVCaptureDeviceInput(device: self.audioDevice!) {
            self.captureSession.addInput(audioInput)
        }

        
        //  添加视频捕获输出
        self.captureSession.addOutput(fileOut)
        
        
        
        //  使用 AVCaptureVideoPreviewLayer 可以将摄像头拍到的实时画面显示在 ViewController 上
        let videoLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
//        videoLayer.frame = view.bounds
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        view.layer.addSublayer(videoLayer)
        
        previewLayer = videoLayer
        
        //  启动 Session 会话
//        self.captureSession.startRunning()
    }
    //  选择摄像头
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        
        let devices = AVCaptureDevice.devices(for: AVMediaType.video)
        for item in devices {
            if item.position == position {
                return item
            }
        }
        return nil
    }
    
    
}




