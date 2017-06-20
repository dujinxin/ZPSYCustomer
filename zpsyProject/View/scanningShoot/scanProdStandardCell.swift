//
//  scanProdStandardCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/16.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class scanProdStandardCell: UITableViewCell {

    public var model:productDetailModel?{
        didSet{
            self.textlab.text = model?.officeName
            self.standerLab.text = model?.packingSpec
        }
    }
    public lazy var textlab:UILabel = {
        let lab = UILabel()
        lab.numberOfLines=1
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.text="北京正品生产企业"
        return lab
    }()
    
    public lazy var standerLab:UILabel = {
        let lab = UILabel()
        lab.numberOfLines=1
        lab.textColor = kColor_red
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.text="瓶"
        return lab
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        self.selectionStyle=UITableViewCellSelectionStyle.none
        
        let lab_1 = getlab("生产企业：")
        let lab_2 = getlab("包装单位&规格：")
        self.contentView.addSubview(lab_1)
        self.contentView.addSubview(lab_2)
        self.contentView.addSubview(self.textlab)
        self.contentView.addSubview(self.standerLab)
        
        lab_1.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(15)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(5)
            let _ = make?.width.equalTo()(75)
        }
        lab_2.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(15)
            let _ = make?.top.mas_equalTo()(lab_1.mas_bottom)?.offset()(5)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-5)
            let _ = make?.width.equalTo()(115)
            
        }
        self.textlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(lab_1.mas_right)
            let _ = make?.centerY.equalTo()(lab_1)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-15)
        }
        self.standerLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(lab_2.mas_right)
            let _ = make?.centerY.equalTo()(lab_2)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-15)
        }
        
    }
    
    func getlab(_ textStr:String) -> UILabel {
        let lab = UILabel()
        lab.numberOfLines=1
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.text=textStr
        return lab
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
