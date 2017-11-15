//
//  UploadPicController.swift
//  swiftLight
//
//  Created by mengxuanlong on 17/8/15.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
import Alamofire
class UploadPicController: UIViewController {
    lazy var toastView : MMToastView = MMToastView()

    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


// MARK: - 设置UI界面
extension UploadPicController {
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(toastView)

        imageView.frame = CGRect(x: 0, y: 64, width: 150, height: 150)
        imageView.centerX = self.view.centerX
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 150 / 2
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        
        let fileManager = FileManager.default
        let homeDirectory = NSHomeDirectory()
        let documentPath = homeDirectory + "/Documents"
        let filePath: String = String(format: "%@%@", documentPath, "/image.png")
        
        if (fileManager.fileExists(atPath: filePath)){
             imageView.image = UIImage(contentsOfFile: filePath)

        } else {
            imageView.image = UIImage(named: "fire.jpg")

        }
        

        
        let upBtn = UIButton(type: .custom)
        upBtn.frame = CGRect(x: 0, y: 300, width: kScreenW, height: 50)
        upBtn.setTitle("上传图片", for: .normal)
        upBtn.addTarget(self, action: #selector(upBtnClick), for: .touchUpInside)
        upBtn.backgroundColor = UIColor.gray
        view.addSubview(upBtn)
        
 
    }
    func upBtnClick(){
        let actionSheet = UIAlertController(title: "上传图片", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        
        let takePhotos = UIAlertAction(title: "拍照", style: .destructive, handler: {
            (action: UIAlertAction) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
                
            }
            else {
                printLog("模拟其中无法打开照相机,请在真机中使用");
            }
            
        })
        
        let selectPhotos = UIAlertAction(title: "相册选取", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
  
}

extension UploadPicController :UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    // 用户选取图片之后
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let type: String = (info[UIImagePickerControllerMediaType] as! String)
        //当选择的类型是图片
        if type == "public.image"{
            //修正图片的位置
            let image = self.fixOrientation((info[UIImagePickerControllerOriginalImage] as! UIImage))
            printLog("image"+" --- \(image)")
            
            //先把图片转成NSData
            let data = UIImageJPEGRepresentation(image, 0.5)
   
            //图片保存的路径
            //这里将图片放在沙盒的documents文件夹中
            
            //Home目录
            let homeDirectory = NSHomeDirectory()
            let documentPath = homeDirectory + "/Documents"
            //文件管理器
            let fileManager: FileManager = FileManager.default
            //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
            do {
                try fileManager.createDirectory(atPath: documentPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                printLog("error"+" --- \(error)")
            }
            fileManager.createFile(atPath: documentPath + "/image.png", contents: data, attributes: nil)
            //得到选择后沙盒中图片的完整路径
            let filePath: String = String(format: "%@%@", documentPath, "/image.png")
            printLog("filePath"+" --- \(filePath)")
            
            self.toastView.showBottomOnlyTextToast("正在上传中.....", autoRemove: true)
            let url = kBaseURL + "uploadFile.do"
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    
                    let lastData = NSData(contentsOfFile: filePath)
//                    multipartFormData.append(lastData as! Data, withName: "file", mimeType: "image/png")
                    multipartFormData.append(lastData! as Data, withName: "file", fileName: "file", mimeType: "image/png")
                    /*
                     把剩下的两个参数作为字典,利用 multipartFormData.appendBodyPart(data: name: )添加参数,
                     因为这个方法的第一个参数接收的是NSData类型,所以要利用 NSUTF8StringEncoding 把字符串转为NSData
                     */

                    let param = ["accessToken" : "f77058c7f3f4067989020ce844adcb4b", "accountId" : "8"]
                    for (key, value) in param {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
            },
                to: url,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseString { response in
//                            debugPrint(response)
                            printLog("response"+" --- \(response)")
                            printLog("服务器根据URL的响应: \(String(describing: response.response))")
                            printLog("服务器返回的result: \(response.result)")
                            printLog("服务器返回的value: \(String(describing: response.result.value))")

                            self.imageView.image = UIImage(data: data!)
                        }
                    case .failure(let encodingError):
                        printLog(encodingError)
                    }
            }
            )
            
            
            

            picker.dismiss(animated: true, completion: nil)
 
        
        }
        
    }
    
    
    
    
    
    func fixOrientation(_ aImage: UIImage) -> UIImage {
        // No-op if the orientation is already correct
        if aImage.imageOrientation == .up {
            return aImage
        }
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch aImage.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2))
        default:
            break
        }
        
        switch aImage.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: aImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        
        
        
        let ctx: CGContext = CGContext(data: nil, width: Int(aImage.size.width), height: Int(aImage.size.height), bitsPerComponent: aImage.cgImage!.bitsPerComponent, bytesPerRow: 0, space: aImage.cgImage!.colorSpace!, bitmapInfo: aImage.cgImage!.bitmapInfo.rawValue)!
        ctx.concatenate(transform)
        switch aImage.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.height, height: aImage.size.width))
        default:
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.width, height: aImage.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg: CGImage = ctx.makeImage()!
        let img: UIImage = UIImage(cgImage: cgimg)
        return img
    }
    
}
