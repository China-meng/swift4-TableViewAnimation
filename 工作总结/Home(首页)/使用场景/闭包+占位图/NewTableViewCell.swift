//
//  NewTableViewCell.swift
//  04-网易新闻的小demo
//
//  Created by mengxuanlong on 17/1/9.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import AlamofireImage

class NewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var replayLbl: UILabel!
    
    //定义模型属性
    /*
     因为 class 中 的成员变量需要初始化
     NewsModel?  在初始化的时候就是要有初始值， 因为不是Optional，不能为 nil
     而Optional可以为nil,所以Optional不用
     所以加个?
     */
    var newsModel :NewsModel? {
        //监听模型属性的变化
        didSet {
            titleLbl.text  = newsModel?.title
            sourceLbl.text = newsModel?.source
            replayLbl.text = "\(newsModel?.replyCount ?? 0)跟帖"

            let url = URL(string: newsModel?.imgsrc ?? "")

//            iconImg.kf.setImage(with: url)
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: iconImg.frame.size,
                radius: iconImg.frame.size.width / 2
            )

            iconImg.af_setImage(withURL: url!, placeholderImage: nil, filter:  filter, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: false) { (closureResponse) in
            }
 
            

 


        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
