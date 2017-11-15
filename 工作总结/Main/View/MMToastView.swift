//
//  MMToastView.swift
//  4.MMToastView
//
//  Created by mengxuanlong on 17/7/30.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
private func bgColor(_ alpha: CGFloat) -> UIColor {
    return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
}
class MMToastView: UIView {
    // 外部接口
    internal var font:CGFloat?  // 字体大小 (默认字体大小为15)
    internal var color:UIColor?  // 背景颜色(默认为黑色，透明度为0.6)
    internal var disapperTime:CGFloat? // 设置toast显示的时间，多久之后消失
    internal var distanceY:CGFloat?  // 设置距离顶部或则底部要显示的距离

    var widthAndheight : CGRect?
    lazy var toastWindows : UIWindow = UIWindow()
    lazy var textLabel : UILabel = UILabel()


    open func showTopOnlyTextToast(_ contentText: String ,autoRemove: Bool = true) {
        textLabel.text = contentText
        widthAndheight = contentText.getTextRectSize(text: contentText , font: UIFont.systemFont(ofSize: font==nil ? 15 : font!), size: CGSize(width: 320, height: 1000))
        
        textLabel.text = contentText
        creatToastUI()
        
        self.frame = CGRect(x: toastWindows.screen.bounds.midX-(widthAndheight?.size.width)!/2, y: kScreenH/2, width: (widthAndheight?.size.width)! + 10, height: (widthAndheight?.size.height)! + 10)
        
        hiddeToas()

    }
    
    open func showBottomOnlyTextToast(_ contentText: String ,autoRemove: Bool = true) {
        textLabel.text = contentText
        widthAndheight = contentText.getTextRectSize(text: contentText , font: UIFont.systemFont(ofSize: font==nil ? 15 : font!), size: CGSize(width: 320, height: 1000))
        
        textLabel.text = contentText
        creatToastUI()
        
        let distanY = distanceY==nil ? 100 : distanceY

        self.frame = CGRect(x: toastWindows.screen.bounds.midX-(widthAndheight?.size.width)!/2, y: kScreenH - distanY!, width: (widthAndheight?.size.width)! + 10, height: (widthAndheight?.size.height)! + 10)
        
        hiddeToas()
        
    }
    

}


extension MMToastView {
    fileprivate func hiddeToas(){
        let s = disapperTime==nil ? 3 : disapperTime
        let time = DispatchTime.now() + Double(Int64(Double(s!) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            UIView.animate(withDuration: 0.5, animations: {
                //self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
                self.isHidden = true
            }, completion: { (flag) in

            })
        }
    }
    
    fileprivate func creatToastUI() {
        self.isHidden = false
        self.backgroundColor = color==nil ? bgColor(0.6):color
        self.layer.cornerRadius = 5;
        

        textLabel.textColor = UIColor.white
        textLabel.font = font==nil ? UIFont.systemFont(ofSize: 15) : UIFont.systemFont(ofSize: font!)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byTruncatingTail
        
        textLabel.frame = CGRect(x: 5, y: 5, width: (widthAndheight?.size.width)! , height: (widthAndheight?.size.height)!)
        self.addSubview(textLabel)

    
    }
    



}
