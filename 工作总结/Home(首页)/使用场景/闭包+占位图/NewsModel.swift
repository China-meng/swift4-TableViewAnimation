//
//  NewsModel.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/29.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    //定义属性
    var replyCount :Int = 0
    var title :String = ""
    var source :String = ""
    var imgsrc :String = ""
    //定义字典转模型的构造函数
    init(dic :[String :Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
