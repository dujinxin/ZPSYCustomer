//
//  newScanProductCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/4/8.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class newScanProductCell: UITableViewCell {

    public var comparePriceBlock:(()->Void)?
    
    public lazy var goodsImage:UIImageView = {
        let image = UIImageView()
        image.image=UIImage.init(named: PlaceHoldeImageStr)
        image.contentMode = UIViewContentMode.scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    public lazy var goodsName:UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.text="奥胡二娃回复IE回复安慰奥"
        return lab
    }()
    public lazy var productCanpanyName:UILabel = {
        let lab = UILabel()
        
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.text="奥胡二娃回复IE回复安慰奥"
        return lab
    }()
    public lazy var productCode:UILabel = {
        let lab = UILabel()
        lab.text = "code:12345654"
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 13)
        return lab
    }()
    public lazy var comparePriseButton:UIButton = {
        let button = UIButton()
        button.setTitle("比价", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 2;
        button.layer.masksToBounds = true
        button.backgroundColor = kColor_red
        
        button.rac_signal(for: UIControlEvents.touchUpInside).subscribeNext { (x:Any?) in
            if (self.comparePriceBlock != nil){
                self.comparePriceBlock!()
            }
        }
        return button
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        self.selectionStyle=UITableViewCellSelectionStyle.none
        //self.accessoryType = .disclosureIndicator
        
        self.contentView.addSubview(self.goodsImage)
        self.contentView.addSubview(self.goodsName)
        self.contentView.addSubview(self.productCanpanyName)
        self.contentView.addSubview(self.productCode)
        self.contentView.addSubview(self.comparePriseButton)
        
        self.goodsImage.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(15)
            let _ = make?.left.equalTo()(self.contentView.mas_left)?.offset()(20)
            let _ = make?.height.and().width().mas_equalTo()(100)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-15)
        }
        self.goodsName.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.equalTo()(self.goodsImage.mas_top)
            let _ = make?.left.equalTo()(self.goodsImage.mas_right)?.offset()(15)
            let _ = make?.right.equalTo()(self.mas_right)?.offset()(-20)
            let _ = make?.height.mas_equalTo()(20)
        }
        self.productCanpanyName.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.equalTo()(self.goodsName.mas_bottom)?.offset()(10)
            let _ = make?.left.equalTo()(self.goodsName.mas_left)
            let _ = make?.right.equalTo()(self.goodsName.mas_right)
            let _ = make?.height.mas_equalTo()(15)
        }
        self.productCode.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.equalTo()(self.productCanpanyName.mas_bottom)?.offset()(10)
            let _ = make?.left.equalTo()(self.goodsName.mas_left)
            let _ = make?.right.equalTo()(self.goodsName.mas_right)
            let _ = make?.height.mas_equalTo()(15)
        }
        self.comparePriseButton.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.equalTo()(self.productCode.mas_bottom)?.offset()(5)
            let _ = make?.right.equalTo()(self.contentView.mas_right)?.offset()(-20)
            let _ = make?.height.mas_equalTo()(25)
            let _ = make?.width.mas_equalTo()(60)
        }
        
        
//        self.goodsImage.mas_makeConstraints { (make:MASConstraintMaker?) in
//            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(15)
//            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(10)
//            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
//            let _ = make?.size.mas_equalTo()(CGSize.init(width: 95, height: 95))
//        }
//        
//        self.textlab.mas_makeConstraints { (make:MASConstraintMaker?) in
//            let _ = make?.left.mas_equalTo()(self.ImageView.mas_right)?.with().offset()(10)
//            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(10)
//            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)
//        }
//        self.dettextlab.mas_makeConstraints { (make:MASConstraintMaker?) in
//            let _ = make?.left.mas_equalTo()(self.ImageView.mas_right)?.with().offset()(10)
//            let _ = make?.top.mas_equalTo()(self.textlab.mas_bottom)?.offset()(10)
//            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)
//        }
//        
//        let btn = UIButton()
//        btn.setTitle("比价", for: UIControlState.normal)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
//        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
//        btn.layer.cornerRadius = 2
//        btn.layer.masksToBounds = true
//        btn.backgroundColor = kColor_red
//        self.contentView.addSubview(btn)
//        btn.mas_makeConstraints { (make:MASConstraintMaker?) in
//            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)
//            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
//            let _ = make?.size.equalTo()(CGSize.init(width: 61, height: 24))
//        }
//        
//        btn.rac_signal(for: UIControlEvents.touchUpInside).subscribeNext { (x:Any?) in
//            if (self.comparePriceBlock != nil){
//                self.comparePriceBlock!()
//            }
//        }
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
