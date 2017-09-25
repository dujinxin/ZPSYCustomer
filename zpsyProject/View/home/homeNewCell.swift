//
//  homeNewCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class homeNewCell: UITableViewCell {
    lazy var mainImageView: HomeQualityImageView = {
        let view = HomeQualityImageView()
        //view.lineView.isHidden = true
        view.shadowView.cornerRadius = 5.0
        view.shadowView.rectCorner = [.topRight,.topLeft]
        return view
    }()
    lazy var titleLabel: UILabel = {
        let titlelab = UILabel()
        titlelab.font = UIFont.systemFont(ofSize: 13)
        titlelab.numberOfLines = 0
        titlelab.textAlignment = .left
        titlelab.textColor = JXFfffffColor
        titlelab.sizeToFit()
 
        return titlelab
    }()
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var userLabel: UILabel = {
        let titlelab = UILabel()
        titlelab.font = UIFont.systemFont(ofSize: 13)
        titlelab.textAlignment = .left
        titlelab.textColor = JX333333Color
        return titlelab
    }()
    lazy var timeLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = JX666666Color
        lab.textAlignment = .right
        lab.font = UIFont.systemFont(ofSize: 11*kPercent)
        lab.sizeToFit()
        return lab
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.contentView.addSubview(self.mainImageView)
        self.contentView.addSubview(self.userImageView)
        self.contentView.addSubview(self.userLabel)
        self.contentView.addSubview(self.timeLabel)
        
        self.mainImageView.addSubview(self.titleLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainImageView.mas_remakeConstraints { (make) in
            make?.left.equalTo()(self.contentView.mas_left)?.offset()(15*kPercent)
            make?.right.equalTo()(self.contentView.mas_right)?.offset()(-15*kPercent)
            make?.top.equalTo()(self.contentView.mas_top)?.offset()(10)
            make?.height.mas_equalTo()(524.0/3*kPercent)
        }
        self.userImageView.mas_remakeConstraints { (make) in
            make?.left.equalTo()(self.mainImageView.mas_left)
            make?.top.equalTo()(self.mainImageView.mas_bottom)?.offset()(7)
            make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-7)
            let _ = make?.size.mas_equalTo()(CGSize(width: 30, height: 30))?.priorityHigh()
        }
        self.timeLabel.mas_remakeConstraints { (make) in
            make?.right.equalTo()(self.mainImageView.mas_right)
            make?.top.equalTo()(self.mainImageView.mas_bottom)?.offset()(7)
            make?.bottom.equalTo()(self.userImageView.mas_bottom)
            make?.width.mas_equalTo()(120)
        }
        self.userLabel.mas_remakeConstraints { (make) in
            make?.left.equalTo()(self.userImageView.mas_right)?.offset()(7)
            make?.top.equalTo()(self.mainImageView.mas_bottom)?.offset()(7)
            make?.bottom.equalTo()(self.userImageView.mas_bottom)
            make?.right.equalTo()(self.timeLabel.mas_left)?.offset()(-7)
        }
        
        self.titleLabel.mas_remakeConstraints({ (make) in
            make?.left.equalTo()(self.mainImageView.mas_left)?.offset()(15)
            make?.top.equalTo()(self.mainImageView.mas_top)?.offset()(10)
            make?.right.equalTo()(self.mainImageView.mas_right)?.offset()(-15)
        })
    }

    public var model: ExposureEntity? {
    
        didSet{
            if let array = model?.img.components(separatedBy: ","){
                self.mainImageView.backImageView.jx_setImage(with: array[0], placeholderImage: UIImage(named:"placeHoldeImage"), radius: 5, roundingCorners: [.topLeft,.topRight])
            }
            if let thumbnail = model?.thumbnail {
                self.userImageView.jx_setImage(with: thumbnail, placeholderImage: UIImage(named:"placeHoldeImage"), radius: 15, roundingCorners: .allCorners)
            }
            
            self.userLabel.text = model?.source
            self.timeLabel.text = model?.updateDateStr
            self.titleLabel.text = model?.title
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
