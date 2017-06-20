//
//  circulateScrowCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class circulateScrowCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle=UITableViewCellSelectionStyle.none
        
        let Img=UIImageView.init(image: UIImage.init(named: "scrow"))
        let lingLab=UILabel.init()
        lingLab.backgroundColor=UIColor.init(red: 234/255.0, green: 105/255.0, blue: 72/255.0, alpha: 1)
        
        self.contentView.addSubview(lingLab)
        self.contentView.addSubview(Img)
        
        Img.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(lingLab.mas_bottom)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-5)
            let _ = make?.centerX.equalTo()(lingLab)
        })
        
        lingLab.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_centerX)?.offset()(-77-40*kScaleOfScreen)
            let _ = make?.height.equalTo()(5)
            let _ = make?.width.equalTo()(1)
        })
        Img.isHidden = true
        lingLab.isHidden = true
        
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
