//
//  LrcScrollView.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/8/12.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
private let LrcTableViewCellID = "LrcTableViewCellID"

protocol LrcScrollViewDelegate: class {
    func lrcScrollView(_ lrcView: LrcScrollView, currentText: String)
    func lrcScrollView(_ lrcView: LrcScrollView, progress: Double)
}
class LrcScrollView: UIScrollView {
    ///懒加载展示歌词的TableView
    fileprivate lazy var tableView: UITableView = UITableView()
    var lrcLineModelArray = [LrcLineModel]()
    
    var currentIndex: Int = 0
    weak var lrcDelegate: LrcScrollViewDelegate?


    
    // 暴露给外部的属性
//    internal var lrcString : String?
//    var lrcString = String()

    public var lrcString: String? {
        didSet{
            //歌词处理
            let lrcArray = lrcString?.components(separatedBy: "\n")
            for lrcString in lrcArray! {
                // 4.1.过滤不需要的歌词
                /*
                 [ti:简单爱]
                 [ar:周杰伦]
                 [al:范特西]
                 */
                if lrcString.contains("[ti:") || lrcString.contains("[ar:") || lrcString.contains("[al:") || !lrcString.contains("[") {
                    continue
                }
                
                lrcLineModelArray.append(LrcLineModel(lrclineString: lrcString))
            }
            printLog("歌词数组"+" --- \(lrcLineModelArray.count)")
            tableView.reloadData()

        }
    }
    
    
    
   
    
    var currentTime: TimeInterval = 0 {
        didSet {
//            guard let lrclines = lrcLineModelArray else {
//                return
//            }
            if self.lrcLineModelArray.count > 0 {
                let count = self.lrcLineModelArray.count
                
                for i in 0..<count {
                    let currentLrcLine = self.lrcLineModelArray[i]
                    
                    let nextIndex = i + 1
                    
                    if nextIndex > lrcLineModelArray.count - 1 {
                        break
                    }
                    
                    let nextLrcLine = lrcLineModelArray[nextIndex]
                    

                    if currentTime >= currentLrcLine.lrcTime && currentTime < nextLrcLine.lrcTime && currentIndex != i {
                        let indexPath = IndexPath(row: i, section: 0)
                        let previousPath = IndexPath(row: currentIndex, section: 0)
                        
                        currentIndex = i
                        
                        tableView.reloadRows(at: [previousPath, indexPath], with: .none)
                        
                        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        
                        lrcDelegate?.lrcScrollView(self, currentText: currentLrcLine.lrcText)
                    }
                    
                    if i == currentIndex {
                        let progress = (currentTime - currentLrcLine.lrcTime) / (nextLrcLine.lrcTime - currentLrcLine.lrcTime)
                        
                        let indexPath = IndexPath(row: i, section: 0)
                        
                        guard let cell = tableView.cellForRow(at: indexPath) as? LrcViewCell else {
                            continue
                        }
//                        printLog("currentLrcLine.lrcTime"+" --- \(currentLrcLine.lrcTime)")
                        cell.lrcLabel.progress = progress
                        
                        lrcDelegate?.lrcScrollView(self, progress: progress)
                    }
                }
                
            }
            

            }
            
      }
    
    //实现init(frame:)方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //初始化TableView相关设置
        setupTableView()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK:- 初始化回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //初始化TableView相关设置
        setupTableView()
    }
    // MARK:- 子控件布局回调函数
    override func layoutSubviews() {
        super.layoutSubviews()

        //设置tableView的Frame
        tableView.frame = self.bounds
        
        //设置tableView的位置
//        tableView.frame.origin.x = self.bounds.width
        //设置tableView的内边距
        tableView.contentInset = UIEdgeInsets(top: self.bounds.height * 0.5, left: 0, bottom: self.bounds.height * 0.5, right: 0)
    }
    
}
// MARK:- 初始化TableView相关设置
extension LrcScrollView {
    fileprivate func setupTableView() {
        //添加tableView
        self.addSubview(tableView)
        //设置背景颜色
        tableView.backgroundColor = UIColor.clear
        //设置数据源代理
        tableView.dataSource = self
        //注册cell
        tableView.register(LrcViewCell.self, forCellReuseIdentifier: LrcTableViewCellID)
        //取消分割线
        tableView.separatorStyle = .none
    }
}


// MARK:- 遵守TableView代理,并实现协议方法
extension LrcScrollView: UITableViewDataSource {
    
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lrcLineModelArray.count 
    }
    
    //cell的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //创建cell
        let cell = tableView.dequeueReusableCell(withIdentifier: LrcTableViewCellID, for: indexPath) as! LrcViewCell
        
        if indexPath.row == currentIndex {
            cell.lrcLabel.font = UIFont.systemFont(ofSize: 15)
        } else {
            cell.lrcLabel.font = UIFont.systemFont(ofSize: 13)
            cell.lrcLabel.progress = 0
        }
        
        cell.lrcLabel.text = lrcLineModelArray[indexPath.row].lrcText
        return cell
    }
}
