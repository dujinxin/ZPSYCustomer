//
//  homeNewCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class homeNewCell: UITableViewCell {

    private lazy var Tiltelab:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFont(ofSize: 14)
        lab.textColor=UIColor.white
        lab.text = "就阿尔法而恢复阿尔回复哦哈额"
        lab.textAlignment=NSTextAlignment.left
        lab.numberOfLines=2
        return lab
    }()
    
    private lazy var ImgView:UIImageView={
        let img=UIImageView()
        img.contentMode=UIViewContentMode.scaleAspectFill
        img.clipsToBounds=true
        return img
    }()
    
    private lazy var fromImgView:UIImageView={
        let img=UIImageView()
        img.layer.cornerRadius = 3;
        img.contentMode=UIViewContentMode.scaleAspectFill
        img.clipsToBounds=true
        return img
    }()
    
    private lazy var fromlab:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFont(ofSize: 14)
        lab.textColor=UIColor.black
        lab.text = "正品溯源"
        lab.textAlignment=NSTextAlignment.left
        return lab
    }()
    
    private lazy var detaillab:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFont(ofSize: 12)
        lab.textColor=UIColor.black
        lab.text = "奥尔夫偶尔发货安慰价额覅就爱唯欧if奥IE万佛我问佛我啊伍尔夫欧尼为富哦"
        lab.textAlignment=NSTextAlignment.left
        lab.numberOfLines = 3
        return lab
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize=true
        self.layer.rasterizationScale=UIScreen.main.scale
        self.selectionStyle=UITableViewCellSelectionStyle.none
        viewinit()
    }
    
    
    func viewinit() {
        
        self.contentView.addSubview(self.ImgView)
        
        let bgview = UIView()
        bgview.layer.backgroundColor=UIColor.init(white: 0, alpha: 0.2).cgColor
        bgview.layer.cornerRadius=4
        bgview.layer.masksToBounds=true
        
        self.ImgView.addSubview(bgview)
        bgview.addSubview(self.Tiltelab)
        
        self.ImgView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView)
            let _ = make?.top.mas_equalTo()(self.contentView)
            let _ = make?.right.mas_equalTo()(self.contentView)
            let _ = make?.height.equalTo()(156*kScaleOfScreen)
        }
        
        bgview.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.ImgView.mas_left)?.with().offset()(15)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-70*kScaleOfScreen)
            let _ = make?.bottom.mas_equalTo()(self.ImgView.mas_bottom)?.with().offset()(-10)
        }
        self.Tiltelab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.edges.equalTo()(UIEdgeInsetsMake(5, 15, 5, 5))
        }
        
        self.contentView.addSubview(self.fromImgView)
        self.fromImgView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(15)
            let _ = make?.top.mas_equalTo()(self.ImgView.mas_bottom)?.offset()(10)
            let _ = make?.size.equalTo()(CGSize.init(width: 31, height: 31))
        }
        
        self.contentView.addSubview(self.fromlab)
        self.fromlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.fromImgView.mas_right)?.offset()(10)
            let _ = make?.centerY.mas_equalTo()(self.fromImgView)
            
        }
        
        self.contentView.addSubview(self.detaillab)
        self.detaillab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(15)
            let _ = make?.top.mas_equalTo()(self.fromImgView.mas_bottom)?.offset()(10)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-15)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
        }
        
    }
    
    
    public var model: ExposureEntity? {
    
        didSet{
            
            self.ImgView.locoaSdImageCache(withURL: model?.img, placeholderImageName: PlaceHoldeImageStr)
            self.Tiltelab.text = model?.title
            self.fromImgView.locoaSdImageCache(withURL: model?.thumbnail, placeholderImageName: PlaceHoldeImageStr)
            self.fromlab.text = model?.source
            self.detaillab.text = model?.detail
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
