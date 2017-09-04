//
//  ReportViewCell.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/8/30.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ReportViewCell: UITableViewCell {
    
    public lazy var goodsImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage.init(named: PlaceHoldeImageStr)
        image.contentMode = UIViewContentMode.scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    public lazy var productLabel:UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 2
        lab.textColor = JX333333Color
        lab.font = UIFont.systemFont(ofSize: 15*kPercent)
        lab.text = "奥胡二娃回复IE回复安慰奥"
        return lab
    }()
    
    public lazy var timeLabel:UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 1
        lab.textColor = JX666666Color
        lab.font = UIFont.systemFont(ofSize: 13*kPercent)
        lab.text = "2017-3-16"
        return lab
    }()
    
    public lazy var codeLabel:UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 1
        lab.textColor = JX666666Color
        lab.font = UIFont.systemFont(ofSize: 12*kPercent)
        lab.text = "2017-3-16"
        return lab
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        self.selectionStyle=UITableViewCellSelectionStyle.none
        
        
        self.contentView.addSubview(self.goodsImageView)
        self.contentView.addSubview(self.productLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.codeLabel)
        
        
        self.goodsImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(10)
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(15)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
            let _ = make?.size.equalTo()(CGSize.init(width: 90, height: 90))
        }
        self.productLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.goodsImageView.mas_right)?.offset()(10)
            let _ = make?.top.mas_equalTo()(self.goodsImageView.mas_top)?.offset()(10)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-10)
        }
        self.timeLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.goodsImageView.mas_right)?.offset()(10)
            let _ = make?.top.mas_equalTo()(self.productLabel.mas_bottom)?.offset()(10)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-10)
        }
        self.codeLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.goodsImageView.mas_right)?.offset()(10)
            let _ = make?.top.mas_equalTo()(self.timeLabel.mas_bottom)?.offset()(10)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-10)
            let _ = make?.bottom.mas_equalTo()(self.goodsImageView.mas_bottom)?.offset()(-10)
        }
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
