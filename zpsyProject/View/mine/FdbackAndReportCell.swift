//
//  FdbackAndReportCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/17.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class FdbackAndReportCell: UITableViewCell {

    public lazy var mainlab:UILabel={
        var lab = UILabel()
        return lab
    }()
    public lazy var titleLab:UILabel={
        var lab = UILabel()
        return lab
    }()
    public lazy var timelab:UILabel={
        var lab = UILabel()
        lab.textAlignment=NSTextAlignment.right
        return lab
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.value1, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        self.selectionStyle=UITableViewCellSelectionStyle.none
        
        self.contentView.addSubview(self.titleLab)
        self.contentView.addSubview(self.timelab)
        self.contentView.addSubview(self.mainlab)
        
        
        self.titleLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(15)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.with().offset()(5)
            let _ = make?.height.equalTo()(20)
        }

        self.timelab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.with().offset()(5)
            let _ = make?.height.equalTo()(20)
        }
        
        self.mainlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(30)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
            let _ = make?.top.mas_equalTo()(self.titleLab.mas_bottom)?.with().offset()(5)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.with().offset()(-10)
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
