//
//  HistoryCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/23.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    
    private lazy var ImgView:UIImageView={
    
        let img=UIImageView.init(image: UIImage.init(named:PlaceHoldeImageStr))
        img.contentMode=UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    private lazy var TitleLab:UILabel={
        let lab=UILabel()
        lab.text="鸡娃儿foe我境外福军"
        return lab
    }()
    private lazy var detailLab:UILabel={
        let lab=UILabel()
        lab.textColor=UIColor.gray
        lab.font=UIFont.systemFont(ofSize: 14)
        lab.text="2017-2-23"
        return lab
    }()

    public var  model:productModel?{
    
        didSet{
            self.detailLab.text = CTUtility.string(from: model?.createDateStr as String!, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
            self.TitleLab.text = model?.goodsName as String?
            self.ImgView.sd_setImage(with: URL.init(string: (model?.getfirstGoodImg())!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
        }
    
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        self.selectionStyle=UITableViewCellSelectionStyle.none
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        viewinit()
    }
    
    func viewinit() {
        
        self.contentView.addSubview(self.ImgView)
        self.contentView.addSubview(self.TitleLab)
        self.contentView.addSubview(self.detailLab)
        
        ImgView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(15)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.with().offset()(10)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.with().offset()(-10)
            let _ = make?.size.equalTo()(CGSize.init(width: 60, height: 60))
        }
        
        TitleLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.with().offset()(15)
            let _ = make?.left.mas_equalTo()(self.ImgView.mas_right)?.with().offset()(10)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
        }
        
        detailLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.TitleLab.mas_bottom)?.with().offset()(10)
            let _ = make?.left.mas_equalTo()(self.ImgView.mas_right)?.with().offset()(10)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
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
