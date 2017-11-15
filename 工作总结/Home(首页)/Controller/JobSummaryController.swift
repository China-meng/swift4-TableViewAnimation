//
//  JobSummaryController.swift
//  工作总结
//
//  Created by mengxuanlong on 17/9/10.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
private let kCellIdentify = "kCellIdentify"


class JobSummaryController: UIViewController {
    lazy var bigGroupsModel :[BigGroupsModel] = [BigGroupsModel]()
    
    
    fileprivate lazy var tableView : UITableView = {[unowned self]in
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
// MARK: - 设置UI界面
extension JobSummaryController {
    fileprivate func setupUI(){
        view.addSubview(tableView)
        view.backgroundColor = UIColor.white
        
    }
}
extension JobSummaryController {
    fileprivate func initData(){
        
        //1.获取json文件的地址
        guard let jsonPath:String = Bundle.main.path(forResource: "ceshi.json", ofType: nil) else {return}
        //2.获取json文件的数据
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {return}
        //3.将json文件的数据转化为swift可读数据
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {return}
        guard let dataArray = anyObject as? [[String:AnyObject]] else {return}
        for dict in dataArray{
            self.bigGroupsModel.append(FriendsModel(dic: dict))
        }
        
        
        tableView.sectionHeaderHeight = 40
        tableView.register(GroupHeaderView.self, forHeaderFooterViewReuseIdentifier: "kGroupHeaderView")
        
        
        /*
         tableView.register(GroupHeaderView(), forHeaderFooterViewReuseIdentifier:"kGroupHeaderView")
         tableView.register(UINib(nibName: "GroupHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: GroupHeaderView)
         */
        
        
        
    }
}

// MARK: - 遵守UICollectionView的数据源方法
extension JobSummaryController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.bigGroupsModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bigGroupsModel[section].isOpenGroup ? self.bigGroupsModel[section].friendsModel.count : 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentify, for: indexPath)
        var cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentify)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: kCellIdentify)
        }
        
        cell?.imageView?.image = UIImage(named: self.bigGroupsModel[indexPath.section].friendsModel[indexPath.row].icon)
        cell?.textLabel?.text = self.bigGroupsModel[indexPath.section].friendsModel[indexPath.row].name
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier:"kGroupHeaderView") as! GroupHeaderView
        
        //        headerView.bigGroupsModel = self.bigGroupsModel[section]
        //        print("测试 = ",self.bigGroupsModel[section].nameGroup);
        //        textF.text="测试ddd "
        //        return headerView
        
        //        let view = UIView()
        //        view.backgroundColor = UIColor.lightGray
        //        let textF = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        //        textF.text="测试"
        //        view.addSubview(textF)
        //        return view
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 40))
        btn.backgroundColor = UIColor.groupTableViewBackground
        btn.contentHorizontalAlignment = .left
        
        btn.setImage(UIImage(named: "sanjiao"), for: .normal)
        //修改图片的模式
        btn.imageView?.contentMode = .center
        //让多出来的部分不要切割
        btn.imageView?.clipsToBounds = false
        
        btn.setTitle(self.bigGroupsModel[section].nameGroup, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        //显示文字的边距
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        //修改按钮的内边距
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn.tag = section;
        
        if self.bigGroupsModel[section].isOpenGroup {
            btn.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2));
            
        } else {
            btn.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(0));
            
        }
        
        return btn
    }
    func btnClick (_ btn:UIButton){
        
        self.bigGroupsModel[btn.tag].isOpenGroup = !self.bigGroupsModel[btn.tag].isOpenGroup;
        
        tableView .reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //闭包的使用
        if  indexPath.section == 0 {
            if indexPath.row == 0 {
                let closureVC = ClosureController()
                self.navigationController?.pushViewController(closureVC, animated: true)
                
            } else if indexPath.row == 1 {
                let vc = PlaceholderController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 2 {
                let vc = ChangeColorController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let vc = MusicPlayerController()
                self.navigationController?.pushViewController(vc, animated: true)

                
            } else if indexPath.row == 1 {
                let vc = VideoPlayerController()
                self.navigationController?.pushViewController(vc, animated: true)


                
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let vc = PullCollectionController()
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            } else if indexPath.row == 1 {
                //                let vc = TestVerticalGifCollectionViewController()
                //                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
            let vc = TransitionController()
            self.navigationController?.pushViewController(vc, animated: true)
          
                
                
            } else if indexPath.row == 1 {
                
            }
        } else if indexPath.section == 4 {
            if indexPath.row == 0 {
            let vc = UploadPicController()
            self.navigationController?.pushViewController(vc, animated: true)
                
                
            } else if indexPath.row == 1 {
                let vc = ScanCodeController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        } else if indexPath.section == 5 {
            if indexPath.row == 0 {
                let vc = BarViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.row == 1 {
                let vc = PieChartViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
        
        
        
    }
}
