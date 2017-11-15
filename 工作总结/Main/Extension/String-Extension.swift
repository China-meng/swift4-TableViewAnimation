//
//  String-Extension.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/30.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

extension String {
    //获取字符串的宽度和高度
    func getTextRectSize(text:String, font:UIFont , size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option =
            NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes:
            attributes, context: nil)
        // println("rect:\(rect)");
        return rect;
    }
    
    func validatePhoneNum(phoneNum:String)-> Bool {
        // 手机号以 13 14 15 18 开头   八个 \d 数字字符
        let phoneRegex = "^((13[0-9])|(17[0-9])|(14[^4,\\D])|(15[^4,\\D])|(18[0-9]))\\d{8}$|^1(7[0-9])\\d{8}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@" , phoneRegex)
        return (phoneTest.evaluate(with: phoneNum));
        
    }
    
}
