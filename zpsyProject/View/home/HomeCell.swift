//
//  HomeCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/28.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    public lazy var Tiltelab:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFont(ofSize: 14)
        lab.textColor=UIColor.white
        lab.textAlignment=NSTextAlignment.center
        lab.layer.backgroundColor=UIColor.init(white: 0, alpha: 0.4).cgColor
        lab.layer.cornerRadius=4
        lab.numberOfLines=1
        lab.layer.masksToBounds=true
        return lab
    }()
    
    public lazy var ImgView:UIImageView={
        let img=UIImageView()
        img.contentMode=UIViewContentMode.scaleAspectFill
        img.clipsToBounds=true
        return img
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
        self.contentView.addSubview(self.Tiltelab)
        
        self.ImgView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.edges.equalTo()(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.Tiltelab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerY.mas_equalTo()(self.contentView)
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(44*kScaleOfScreen)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-44*kScaleOfScreen)
            let _ = make?.height.equalTo()(20)
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
