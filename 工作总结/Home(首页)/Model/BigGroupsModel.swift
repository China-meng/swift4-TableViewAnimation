//
//  BigGroupsModel.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/23.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class BigGroupsModel: NSObject {
    ///
    var nameGroup : String = ""
    var online : NSNumber = 1
    var isOpenGroup = false

    ///
    lazy var friendsModel :[FriendsModel] = [FriendsModel]()
    ///
    var friends :[[String :NSObject]]? {
        didSet{
            guard let friends = friends else {return}
            for dict in friends {
                friendsModel.append(FriendsModel(dic: dict))
            }
        }
    
    }



}
