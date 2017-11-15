//
//  PageContentView.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/6/16.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
private let ContentCellID = "ContentCellID"
// MARK: -  代理的使用:①定义协议 class 表示这个协议只能被类遵守 和代理方法
protocol PageContentViewdelegate:class {
    func pageContentViewMethed(_ contentView :PageContentView ,progress : CGFloat, sourceIndex : Int, targetIndex : Int)}

class PageContentView: UIView {


    fileprivate var childVcs :[UIViewController]
    /*
     小bug: PageContentView强引用HomeViewController,
     在HomeViewController中是对PageContentView是强引用
     所以这里用weak ,weak只能修饰可选类型
     */
    fileprivate weak var parentViewController:UIViewController?
    fileprivate var startOffsetX :CGFloat = 0
    //当有点击标题的事件了,没必要执行PageContentView中的代理方法
    fileprivate var isForbidScrollDelegate :Bool = false
    
    // 代理的使用:②定义代理属性
    weak var delegate:PageContentViewdelegate?
    
    //闭包里面有self ,加[weak self] in 防止循环引用
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout =  UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()

    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension PageContentView {
    fileprivate func setupUI(){
        for childVc in childVcs {
            //上面防止循环引用,加的weak,这里使用可选链调用
            parentViewController?.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    
    }

}
// MARK: - 遵守UICollectionViewDataSource
extension PageContentView :UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
// MARK:- 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 判断是否是点击事件,如果是点击事件,直接return
        if isForbidScrollDelegate { return }
        
        //滚动处理
        var progress : CGFloat = 0
        var sourceIndex :Int = 0
        var targetIndex :Int = 0
        // 判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
//        print("currentOffsetX --- \(currentOffsetX)  startOffsetX --  \(startOffsetX)")
        if currentOffsetX > startOffsetX {//左滑
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
//            print(" === \(currentOffsetX/scrollViewW)  === \(floor(currentOffsetX/scrollViewW))")

            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
//            print("左sourceIndex ---  \(sourceIndex)  targetIndex --  \(targetIndex)")

            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
                progress = 1
                
                
            }
            

            if currentOffsetX - startOffsetX == scrollViewW{
                targetIndex = sourceIndex
                progress = 1
//                print("左边完全滑过去progress ---  \(progress)")
                
                
            }
            
        }else{ //右滑
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))

            
            targetIndex =  Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
//            print("右targetIndex --- 右count --  \(targetIndex) \(childVcs.count)")

            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
                progress = 1
                
            }
            //完全划过去
            if startOffsetX - currentOffsetX == scrollViewW {
                sourceIndex = targetIndex
                progress = 1
//                printLog("右侧边完全滑过去progress"+"----\(progress)")
                
                
            }
            
        }
        //将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentViewMethed(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    

}

// MARK:- 对外暴露的方法,用于接受PageTitleViewDelegate传给HomeViewController的index
extension PageContentView {
    func setCurrentIndex(_ currentIndex : Int) {
        //禁止执行代理方法
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
        
    
    }

}

