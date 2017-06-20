//
//  HotRemarkCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/20.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class HotRemarkCell: UITableViewCell {

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.MyImageView)
        self.selectionStyle=UITableViewCellSelectionStyle.none
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        InitSubviews()

        self.MyImageView.image=UIImage.init(named: "tabbar_2")
        self.myTitleLab.text="[北京]了解爱尔"
        self.myTimeLab.text="2017年2月20日 18:28"
        self.myLikeLab.text="20"
        self.myDetLab.text="就按偶尔否欧诶爱唯欧否微幅"
        
    }
    
    func InitSubviews() -> Void {
        
        self.contentView.addSubview(self.MyImageView)
        self.contentView.addSubview(self.myTitleLab)
        self.contentView.addSubview(self.myTimeLab)
        self.contentView.addSubview(self.myDetLab)
        self.contentView.addSubview(self.myLikeLab)

        self.MyImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(15)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.with().offset()(10)
            let _ = make?.size.equalTo()(CGSize.init(width: 44, height: 44))
        }
        
        self.myTitleLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.MyImageView.mas_right)?.with().offset()(10)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.with().offset()(15)
        }
        
        self.myTimeLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.MyImageView.mas_right)?.with().offset()(10)
            let _ = make?.top.mas_equalTo()(self.myTitleLab.mas_bottom)?.with().offset()(0)
        }
        
        self.myDetLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.MyImageView.mas_right)?.with().offset()(10)
            let _ = make?.top.mas_equalTo()(self.myTimeLab.mas_bottom)?.with().offset()(10)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.with().offset()(-5)
        }
        
        self.myLikeLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.with().offset()(15)
        }
        
        
        let likeBtn = UIButton()
        likeBtn.setImage(UIImage.init(named: "redlike"), for: UIControlState.normal)
        self.contentView.addSubview(likeBtn)
        likeBtn.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.myLikeLab.mas_left)?.with().offset()(-2)
            let _ = make?.centerY.mas_equalTo()(self.myLikeLab.mas_centerY)
            let _ = make?.size.equalTo()(CGSize.init(width: 20, height: 20))
        }
        likeBtn.addTarget(self, action: #selector(self.praiseClickEvent), for: UIControlEvents.touchUpInside)
    }
    
    public lazy var MyImageView:UIImageView={
        let image=UIImageView()
        image.layer.cornerRadius=22;
        return image;
    }()
    
    public lazy var myTitleLab:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    public lazy var myTimeLab:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFont(ofSize: 10)
        lab.textColor=UIColor.gray
        return lab
    }()
    
    public lazy var myDetLab:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFont(ofSize: 13)
        return lab
    }()
    
    public lazy var myLikeLab:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFont(ofSize: 10)
        lab.textColor=UIColor.red
        return lab
    }()
    
    public var praiseClickBlock:(()->Void)?
    
    @objc private func praiseClickEvent(){
        if (self.praiseClickBlock != nil) {
            self.praiseClickBlock!()
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
