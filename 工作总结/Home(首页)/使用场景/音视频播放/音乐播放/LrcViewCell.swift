//
//  LrcViewCell.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/8/12.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class LrcViewCell: UITableViewCell {
    lazy var lrcLabel: LrcLabel = LrcLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
extension LrcViewCell {
    fileprivate func setupUI() {
        contentView.addSubview(lrcLabel)
        
        backgroundColor = UIColor.clear
        lrcLabel.font = UIFont.systemFont(ofSize: 14)
        lrcLabel.textAlignment = .center
        lrcLabel.textColor = UIColor.white
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lrcLabel.sizeToFit()
        lrcLabel.center = contentView.center
    }
}
