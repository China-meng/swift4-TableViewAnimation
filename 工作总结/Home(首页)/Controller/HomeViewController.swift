//
//  HomeViewController.swift
//  工作总结
//
//  Created by mengxuanlong on 17/9/10.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
private let kTitleViewH :CGFloat = 40

class HomeViewController: UIViewController {
    // MARK: - 懒加载pageTitleView
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self]in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["工作总结", "直播技术", "VR", "周杰伦","詹姆斯","科比"]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        
        return titleView
        
        }()
    
    // MARK: - 懒加载pageContentView
    fileprivate lazy var pageContentView :PageContentView = {[weak self]in
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        var childVCs = [UIViewController]()
        childVCs.append(JobSummaryController())
        for _ in 0..<5 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVCs.append(vc)
        }
        printLog("childVCs"+" --- \(childVCs.count)")
        let contentView = PageContentView(frame: contentFrame, childVcs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //不需要调整scrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
// MARK: - 设置UI界面
extension HomeViewController {
    fileprivate func setupUI(){
        //不需要调整scrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        
        
    }
    fileprivate func setupNavigationBar(){
        navigationController?.navigationBar.tintColor = UIColor.orange
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        
    }
    
}
// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController :PageTitleViewDelegate {
    func pageTitleViewMethed(_ titleView: PageTitleView, selectedIndex index: Int) {
        //然后把点击的index传给PageContentView
        pageContentView.setCurrentIndex(index)
    }
}
// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController :PageContentViewdelegate {
    func pageContentViewMethed(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //把三个参数传递给PageTitleView
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

