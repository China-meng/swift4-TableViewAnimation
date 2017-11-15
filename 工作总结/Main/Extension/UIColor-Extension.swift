//
//  UIColor-Extension.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/6/16.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

extension UIColor {
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        /// rgb颜色
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    
    }
    /// 纯色（用于灰色）
    convenience init(gray: CGFloat) {
        self.init(red: gray/255.0 ,green: gray/255.0 ,blue: gray/255.0 ,alpha:1.0)
    }
    /// 随机色
    class func randomColor()->UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    

}
