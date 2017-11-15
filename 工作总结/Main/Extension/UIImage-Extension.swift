//
//  UIImage-Extension.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/8/11.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

extension UIImage {
    
    // 将当前图片缩放到指定尺寸
    func scaleImageToSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    
    //获取图片中的颜色
    //pos 坐标点
    func getPixelColor(pos:CGPoint) -> UIColor {
        let pixelData = self.cgImage!.dataProvider!.data
        let data = CFDataGetBytePtr(pixelData)
        let pixelInfo = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let red = CGFloat((data?[pixelInfo])!) / 255
        let green = CGFloat((data?[pixelInfo + 1])!) / 255
        let blue = CGFloat((data?[pixelInfo + 2])!) / 255
        let alpha = CGFloat((data?[pixelInfo + 3])!) / 255
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    
    //本地图片生成圆形图片
    func toCircle() -> UIImage {
        //取最短边长
        let shotest = min(self.size.width, self.size.height)
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        self.draw(in: CGRect(x: (shotest-self.size.width)/2,
                             y: (shotest-self.size.height)/2,
                             width: self.size.width,
                             height: self.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }
    
  
    

}




