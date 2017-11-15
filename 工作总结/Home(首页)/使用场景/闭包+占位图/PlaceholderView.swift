//
//  PlaceholderView.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/29.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
//enum PlaceholderType {
//    /** 无网络 */
//    case NoPlaceholderTypeNetwork
//    /** 无订单 */
//    case NoPlaceholderTypeOrder
//    
//}



class PlaceholderView: UIView {
    var labelClickCallBack:(() -> ())?

    //懒加载的基本实现
    //1、借助关键词lazy
    //2、懒加载的好处：延迟创建、避免解包的烦恼
    //3、懒加载要指明类型
    lazy var imageView: UIImageView = UIImageView()
    lazy var topLabel: UILabel = UILabel()
    lazy var bottomLabel: UILabel = UILabel()
    
    // MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        //setupPlaceholderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK:- 设置UI界面
extension PlaceholderView {
    func setupUI(){
        //图片
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        //内容描述
        topLabel = UILabel()
        topLabel.textAlignment = .center
        self.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.right.equalTo(self)
            make.height.equalTo(20)
        }
        //提示点击重新加载
        bottomLabel = UILabel()
        bottomLabel.textAlignment = .center
        self.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(topLabel.snp.bottom).offset(10)
            make.left.right.equalTo(self)
            make.height.equalTo(20)
        }
 
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(bottomLabelClick(sender:)))
        bottomLabel.addGestureRecognizer(gesture)
        bottomLabel.isUserInteractionEnabled = true
        
        self.setPlaceholderUI(imageName:"订单无数据" , topLabelText:"暂时没有订单",bottomLabelText: "点击重试")

    }
}
extension PlaceholderView {
    func setPlaceholderUI(imageName:String , topLabelText:String ,bottomLabelText:String ){
        self.imageView.image = UIImage(named: imageName)
        self.topLabel.text = topLabelText
        self.bottomLabel.text = bottomLabelText

    }
    
    func bottomLabelClick(sender: UITapGestureRecognizer){
//        print("点击重试")
        if  labelClickCallBack != nil{
            labelClickCallBack!()
        }
    }
}


// MARK:- 占位图 
//extension PlaceholderView {
//    fileprivate func setupPlaceholderView() {
//        MatchPlaceholderType(.NoPlaceholderTypeNetwork)
//   
//    }
//}
//fileprivate func MatchPlaceholderType (_ type:PlaceholderType){
//    switch type {
//    case .NoPlaceholderTypeNetwork:
//        print("NoPlaceholderTypeNetwork")
//        setPlaceholderUI(imageName:UIImage(named:"网络异常")! , topLabelText:"貌似没有网络",bottomLabelText: "点击重试")
//        
//    case .NoPlaceholderTypeOrder:
//        print("NoPlaceholderTypeOrder")
//
//    }
//}

