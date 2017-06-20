//
//  scanProductHeader.swift
//  ZPSY
//
//  Created by zhouhao on 2017/4/8.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class scanProductHeader: UITableViewHeaderFooterView {

    public var changeValueBlock:(()->Void)?
    
    public var isExpend:Bool?{
    
        didSet{
            UIView.beginAnimations("rotate", context: nil)
            UIView.setAnimationDuration(0.2)
            if isExpend! {
                if CGAffineTransform.identity == self.scrowBtn.transform {
                    self.scrowBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                }
            }else{
                if CGAffineTransform.identity != self.scrowBtn.transform {
                    self.scrowBtn.transform = CGAffineTransform.identity
                }
            }
            UIView.commitAnimations()
        }
    }
    
    public lazy var titleLab:UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        lab.textAlignment = NSTextAlignment.center
        lab.text = "商品信息"
        return lab
    }()
    
    private lazy var scrowBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "scrowdown"), for: UIControlState.normal)
        btn.size = CGSize.init(width: 40, height: 40)
        return btn
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleLab)
        self.contentView.addSubview(self.scrowBtn)
        self.contentView.backgroundColor = UIColor.white
        
        self.scrowBtn.rac_signal(for: UIControlEvents.touchUpInside).subscribeNext({[weak self] (x:Any?) in
            self?.isExpend = !(self?.isExpend)!
            if self?.changeValueBlock != nil {
                self?.changeValueBlock!()
            }
        })

        
        self.scrowBtn.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-15)
            let _ = make?.centerY.mas_equalTo()(self.contentView)
        }
        self.titleLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(10)
            //let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(15)
            //let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-50)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
            let _ = make?.centerX.equalTo()(self.contentView)
        }

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
