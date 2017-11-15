//
//  Common.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/6/16.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
let kStatusBarH : CGFloat = 20
let kNavigationBarH : CGFloat = 44
let kTabbarH : CGFloat = 44

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

// 自适应屏幕宽度
func FIT_SCREEN_WIDTH(_ size: CGFloat) -> CGFloat {
    return size * kScreenW / 375.0
}
// 自适应屏幕高度
func FIT_SCREEN_HEIGHT(_ size: CGFloat) -> CGFloat {
    return size * kScreenH / 667.0
}
// 自适应屏幕字体大小
func AUTO_FONT(_ size: CGFloat) -> UIFont {
    let autoSize = size * kScreenW / 375.0
    return UIFont.systemFont(ofSize: autoSize)
}
let toolBarViewH: CGFloat = FIT_SCREEN_HEIGHT(40)
let Padding = FIT_SCREEN_WIDTH(10)

let kBaseURL = "这里是你服务器地址";

func printLog<T>( _ message: T, file: String = #file, method: String = #function, line: Int = #line){
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

// RGB颜色
func RGB_COLOR(_ r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
}

class GlobalUtil: NSObject {
    
    /** 计算文本尺寸 */
    static func textSizeWithString(_ str: String, font: UIFont, maxSize:CGSize) -> CGSize {
        let dict = [NSFontAttributeName: font]
        let size = (str as NSString).boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dict, context: nil).size
        return size
    }
    
}
