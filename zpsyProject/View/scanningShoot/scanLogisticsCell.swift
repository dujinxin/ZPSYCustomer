//
//  scanLogisticsCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/4/8.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class scanLogisticsCell: UITableViewCell {

    
    public var Model:GoodsLotBatchModel?{
    
        didSet{
            self.textlab.text = Model?.event
            self.timerlab.text = CTUtility.string(from: Model?.date, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
        }
    
    }
    
    
    private lazy var textlab:UILabel = {
        let lab = UILabel()
        lab.numberOfLines=0
        lab.textColor = UIColor.gray
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.text="奥胡二娃回复IE回复安慰奥"
        return lab
    }()
    
    private lazy var timerlab:UILabel = {
        let lab = UILabel()
        lab.numberOfLines=1
        lab.textColor = UIColor.gray
        lab.font = UIFont.systemFont(ofSize:12)
        lab.text="2017-10-16"
        return lab
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle=UITableViewCellSelectionStyle.none
        self.separatorInset=UIEdgeInsetsMake(0, kScreenWidth, 0, 0)
        
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.3, alpha: 0.8)
        let img = UIImageView.init(image: UIImage.init(named: "circal"))
        self.contentView.addSubview(view)
        self.contentView.addSubview(img)
        self.contentView.addSubview(self.textlab)
        self.contentView.addSubview(self.timerlab)
        
        
        
        view.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerX.equalTo()(img)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(0)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(0)
            let _ = make?.width.equalTo()(0.5)
        }
        
        img.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(25)
            let _ = make?.centerY.equalTo()(self.timerlab)
            let _ = make?.size.equalTo()(CGSize.init(width: 7, height: 7))
        }
        
        self.timerlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(img.mas_right)?.offset()(10)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(5)
            let _ = make?.width.equalTo()(70)
        }
        
        self.textlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.timerlab.mas_right)?.offset()(15)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-15)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(5)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-5)
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
