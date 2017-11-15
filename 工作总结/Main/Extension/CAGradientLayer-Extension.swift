//
//  CAGradientLayer-Extension.swift
//  NavtiveAppToB
//
//  Created by mengxuanlong on 2017/9/27.
//  Copyright © 2017年 XiaoBangqiang. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    //获取彩虹渐变层
    func rainbowLayer() -> CAGradientLayer {
        //定义渐变的颜色（
        let gradientColors = [UIColor(r: 240, g: 90, b: 46).cgColor,  UIColor(r: 251, g: 113, b: 47).cgColor]
        //创建CAGradientLayer对象并设置参数
        self.colors = gradientColors
        return self
    }
}
