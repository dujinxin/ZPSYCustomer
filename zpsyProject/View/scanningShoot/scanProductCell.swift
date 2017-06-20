//
//  scanProductCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/16.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class scanProductCell: UITableViewCell {

    
    public var model:productDetailModel?{
        didSet{
        
            self.ImageView.sd_setImage(with: URL.init(string: (model?.getfirstGoodImg())!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            self.textlab.text = model?.name
            self.timerlab.text = CTUtility.string(from: model?.createDateStr, sourceformat: "yyyy-MM-dd HH:mm", toFormat: "yyyy-MM-dd")
            self.LogoImg.sd_setImage(with: URL.init(string: (model?.thumbnail ?? "")!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
        }
    }
    
    
    private lazy var ImageView:UIImageView = {
        let image = UIImageView()
        image.image=UIImage.init(named: PlaceHoldeImageStr)
        image.contentMode = UIViewContentMode.scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var LogoImg:UIImageView = {
        
        let image = UIImageView()
        image.image=UIImage.init(named: PlaceHoldeImageStr)
        image.contentMode = UIViewContentMode.scaleAspectFit
        image.clipsToBounds = true
        return image
        
    }()
    
    private lazy var textlab:UILabel = {
        let lab = UILabel()
        lab.numberOfLines=1
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.text="奥胡二娃回复IE回复安慰奥"
        return lab
    }()
    
    private lazy var timerlab:UILabel = {
        let lab = UILabel()
        lab.numberOfLines=1
        lab.textColor = UIColor.gray
        lab.font = UIFont.systemFont(ofSize: 9)
        lab.text="2017-3-16"
        return lab
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        self.selectionStyle=UITableViewCellSelectionStyle.none
        
        
        self.contentView.addSubview(self.ImageView)
        self.contentView.addSubview(self.textlab)
        self.contentView.addSubview(self.LogoImg)
        self.contentView.addSubview(self.timerlab)
        
        self.ImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)
            let _ = make?.height.equalTo()(174*kScaleOfScreen)
        }
        self.LogoImg.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(15)
            let _ = make?.top.mas_equalTo()(self.ImageView.mas_bottom)?.offset()(10)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
            let _ = make?.size.equalTo()(CGSize.init(width: 14, height: 25))
        }
        
        self.textlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.LogoImg.mas_right)?.with().offset()(10)
            let _ = make?.top.mas_equalTo()(self.LogoImg.mas_top)
            let _ = make?.height.equalTo()(15)
        }
        self.timerlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.LogoImg.mas_right)?.with().offset()(10)
            let _ = make?.top.mas_equalTo()(self.textlab.mas_bottom)
            let _ = make?.height.equalTo()(10)
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
