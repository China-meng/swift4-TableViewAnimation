//
//  ScanCodeController.swift
//  swiftLight
//
//  Created by mengxuanlong on 17/9/5.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
import AVFoundation
let kMagin : CGFloat = 10

class ScanCodeController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    // MARK: - 懒加载导航条
    fileprivate lazy var navView :UIView = { [unowned self]in
        let navView = UIView()
        navView.backgroundColor = UIColor(r: 17, g: 17, b: 27)
        navView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kStatusBarH + kNavigationBarH)
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: kStatusBarH + kMagin, width: 100, height: kStatusBarH + kMagin)
        button.setImage(UIImage(named:"whiteBack"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -65, 0, 0)
        button.addTarget(self, action: #selector(backToPrevious), for: .touchUpInside)
        navView.addSubview(button)
        
        let midTitle = UILabel()
        navView.addSubview(midTitle)
        midTitle.textColor = UIColor.white
        midTitle.text = "幕瞄"
        //        midTitle.font = UIFont.systemFont(ofSize: 15)
        midTitle.textAlignment = .center
        midTitle.snp.makeConstraints({ (make) in
            make.width.equalTo(kStatusBarH * 2)
            make.height.equalTo(kStatusBarH + kMagin)
            make.center.equalTo(navView.snp.center)
            make.centerY.equalTo(button.snp.centerY)
            
        })
        return navView
        }()
    
    let screen_w = UIScreen.main.bounds.width
    let screen_h = UIScreen.main.bounds.height
    let top = (UIScreen.main.bounds.height - 220)/2
    let left = (UIScreen.main.bounds.width - 220)/2
    let kScanRect = CGRect.init(x: (UIScreen.main.bounds.width - 220)/2,y: (UIScreen.main.bounds.height - 220)/2,width: 220,height: 220)
    
    var num : CGFloat?
    var upOrDown : Bool?
    var timer : Timer?
    var cropLayer : CAShapeLayer?
    
    
    var device : AVCaptureDevice?
    var input : AVCaptureDeviceInput?
    var output : AVCaptureMetadataOutput?
    var session : AVCaptureSession?
    var preView : AVCaptureVideoPreviewLayer?
    
    var line : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setBack()
        configView()
        setCamera()
        view.addSubview(navView)
    }
    
    func configView() {
        
        let imageView = UIImageView.init(frame: kScanRect)
        imageView.image = #imageLiteral(resourceName: "pick_bg")
        view.addSubview(imageView)
        
        upOrDown = false
        num = 0
        line = UIImageView.init(frame: .init(x: left, y: top + 10, width: 220, height: 2))
        line?.image = #imageLiteral(resourceName: "line")
        view.addSubview(line!)
        
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
    }
    
    func animation() {
        
        if upOrDown! {
            num! -= 1
            line?.frame = CGRect.init(x: left, y: top + 10 + 2 * num!, width: 220, height: 2)
            if num == 0 {
                upOrDown = false
            }
        } else {
            num! += 1
            line?.frame = CGRect.init(x: left, y: top + 10 + 2 * num!, width: 220, height: 2)
            if 2 * num! == 200 {
                upOrDown = true
            }
        }
    }
    
    func setCamera() {
        
        device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if device == nil {
            let alert = UIAlertController.init(title: "提示", message: "请使用真机测试!", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
                
            }))
            present(alert, animated: true, completion: nil)
            return
        }
        
        do {
            try input = AVCaptureDeviceInput(device: device)
            output = AVCaptureMetadataOutput()
            output?.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //设置扫描区域
            let Top = top/screen_h
            let Left = left/screen_w
            let Width = 220/screen_w
            let Height = 220/screen_h
            
            output?.rectOfInterest = .init(x: Top, y: Left, width: Height, height: Width)
            
            //session
            session = AVCaptureSession()
            //精度
            session?.sessionPreset = AVCaptureSessionPreset1920x1080
            if (session?.canAddInput(input))! {
                session?.addInput(input)
            }
            if (session?.canAddOutput(output))! {
                session?.addOutput(output)
            }
            
            //条码类型
            output?.metadataObjectTypes = [AVMetadataObjectTypeQRCode,
                                           AVMetadataObjectTypeUPCECode,
                                           AVMetadataObjectTypeCode39Code,
                                           AVMetadataObjectTypeCode39Mod43Code,
                                           AVMetadataObjectTypeEAN13Code,
                                           AVMetadataObjectTypeEAN8Code,
                                           AVMetadataObjectTypeCode93Code,
                                           AVMetadataObjectTypeCode128Code,
                                           AVMetadataObjectTypePDF417Code,
                                           AVMetadataObjectTypeAztecCode,
                                           AVMetadataObjectTypeInterleaved2of5Code,
                                           AVMetadataObjectTypeITF14Code,
                                           AVMetadataObjectTypeDataMatrixCode,]
            //预览图层
            preView = AVCaptureVideoPreviewLayer(session: session)
            preView?.videoGravity = AVLayerVideoGravityResizeAspectFill
            preView?.frame = self.view.layer.bounds
            view.layer.insertSublayer(preView!, at: 0)
            //启动
            session?.startRunning()
        } catch {
            print("初始化失败")
        }
    }
    
    //MARK: -AVCaptureMetadataOutputObjectsDelegate
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects.count > 0 {
            session?.stopRunning()
            timer?.fireDate = NSDate.distantFuture
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            let alert = UIAlertController.init(title: "扫码结果", message: metadataObject.stringValue!, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
                
            }))
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    /// 返回按钮设置
    func setBack() {
        
//        let backBtn = UIButton.init(frame: .init(x: 0, y: 0, width: 44, height: 44))
//        backBtn.addTarget(self, action: #selector(pop), for: .touchUpInside)
//        backBtn.setTitle("返回", for: .normal)
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        
    }
    
    func backToPrevious() {
        
        self.dismiss(animated: true, completion: nil)
    }
}



