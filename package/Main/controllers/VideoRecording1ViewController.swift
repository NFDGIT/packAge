//
//  VideoRecording1ViewController.swift
//  package
//
//  Created by Admin on 2019/2/18.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class VideoRecording1ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let capture =  PHCaptureObject.init()
        
        let layer = capture.previewLayer
        layer?.frame = self.view.layer.frame
        self.view.layer.addSublayer(layer!)

        
        PHCaptureManager.init().startRecord(captureSession: capture.captureSession,fileOut: capture.fileOut)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            capture.captureSession.stopRunning()
        }

        // Do any additional setup after loading the view.
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
