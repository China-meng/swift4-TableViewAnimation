//
//  UIBarButtonItem-Extension.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/6/16.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName : String , highImageName :  String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for: .highlighted)
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        //创建UIBarButtonItem
        self.init(customView:btn)
    }


}
