//
//  BaseTableView.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/29.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    let placeholderView : PlaceholderView = PlaceholderView(frame: CGRect(x: 0, y: -100, width: kScreenW, height: kScreenH))
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame:frame, style:style)
        self.tableFooterView = UIView(frame: CGRect.zero)


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}
// MARK: - 公开给子类调用的方法
extension BaseTableView {
    func showEmptyView(){

        self.addSubview(placeholderView)
    }
    
    func removeEmptyView(){
        placeholderView.removeFromSuperview()
    }
}

