//
//  hotProductCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/24.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class hotProductCell: UICollectionViewCell {
    
    
    private lazy var MyImg:UIImageView = {
        let img = UIImageView()
        img.contentMode = UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 5
        img.sd_setImage(with: URL.init(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490368459507&di=3b481f86e5bf872c548dbebf1a0da8d5&imgtype=0&src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F201282413335761587.jpg"))
        return img
    }()
    private lazy var textLab:UILabel = {
        
        let lab = UILabel()
        lab.isHidden = true
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.textAlignment = NSTextAlignment.center
        lab.text = "新西兰"
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        lab.addSubview(lineView)
        
        lineView.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.bottom.mas_equalTo()(lab.mas_bottom)
            let _ = make?.centerX.mas_equalTo()
            let _ = make?.height.equalTo()(1)
            let _ = make?.width.equalTo()(40)
        })
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.MyImg.addSubview(self.textLab)
        self.contentView.addSubview(self.MyImg)
        self.MyImg.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.edges.equalTo()(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.textLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)
            let _ = make?.centerY.equalTo()(self.contentView)
        }
        
        
    }
    
    public var model:youxuanModel?{
    
        didSet{
        
            self.textLab.text = model?.shortTitle
            self.MyImg.sd_setImage(with: URL.init(string: (model?.thumbnail)!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
        }
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
