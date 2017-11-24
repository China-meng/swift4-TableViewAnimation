//
//  FriendsModel.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/23.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class FriendsModel: BigGroupsModel {

    @objc var vip : NSNumber = 1
    @objc var icon : String = ""
    @objc var intro : String = ""
    @objc var name : String = ""
    
    //自定义字典转模型的构造函数
    init(dic:[String :Any]) {
        super.init()
        setValuesForKeys(dic)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        return
    }



}
