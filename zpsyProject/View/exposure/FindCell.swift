//
//  FindCell.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/9/21.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class FindCell: UITableViewCell {
    
    
    private lazy var bigImageView:UIImageView = {
        var image = UIImageView()
        image.image = UIImage.init(named:PlaceHoldeImageStr)
        image.contentMode = UIViewContentMode.scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel:UILabel = {
        var lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.numberOfLines = 2
        lab.lineBreakMode = .byClipping
        return lab
    }()
    
    private lazy var goodsNameLabel:UILabel = {
        var lab = UILabel()
        lab.numberOfLines = 1
        lab.textColor = UIColor.gray
        //lab.lineBreakMode = .byClipping
        lab.font = UIFont.systemFont(ofSize: 11)
        return lab
    }()
    
    private lazy var levelImageView:UIImageView = {
        var image = UIImageView()
        image.image = UIImage.init(named: PlaceHoldeImageStr)
        image.contentMode = UIViewContentMode.scaleAspectFit
        return image
    }()
    
    private lazy var levelLabel:UILabel = {
        var lab = UILabel()
        lab.numberOfLines = 1
        lab.font = UIFont.systemFont(ofSize: 11)
        lab.textColor = UIColor.gray
        lab.lineBreakMode = .byClipping
        lab.text = "危害等级"
        return lab
    }()
    
    private lazy var sourceLabel:UILabel = {
        var lab = UILabel()
        lab.numberOfLines = 1
        lab.font = UIFont.systemFont(ofSize: 11)
        lab.textColor = UIColor.gray
        lab.lineBreakMode = .byClipping
        return lab
    }()
    
    private lazy var commentButton:UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named:"shapegreen"), for: .normal)
        button.addTarget(self, action: #selector(commentClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var salerLab : UILabel = {
        
        let lab = UILabel()
        lab.numberOfLines = 1
        lab.font = UIFont.systemFont(ofSize: 11)
        lab.textColor = UIColor.gray
        lab.lineBreakMode = .byClipping
        lab.text = ""
        return lab
        
    }()
    
    public var entity:FindEntity?{
        
        didSet{
            self.bigImageView.sd_setImage(with: URL.init(string: (entity?.thumbnail)! as String), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            self.titleLabel.text = entity?.title as String?
            self.goodsNameLabel.text = entity?.summary as String?
            if
                let hazardClass = entity?.hazardClass,
                hazardClass != "0" {
                self.levelImageView.image = UIImage(named: "warning"+hazardClass)
            }else{
                self.levelImageView.isHidden = true
                self.levelLabel.isHidden = true
            }
            
            self.sourceLabel.text = entity?.source as String?
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.contentView.addSubview(self.bigImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.goodsNameLabel)
        self.contentView.addSubview(self.levelLabel)
        self.contentView.addSubview(self.levelImageView)
        self.contentView.addSubview(self.sourceLabel)
        self.contentView.addSubview(self.commentButton)
    }
    
    public var mycommentType:String? = "0"
    
    @objc private func commentClick(){
        let remarkvc = HotRemarkVC();
        remarkvc.mycommenttype = commentType.commentProduct
        if mycommentType == "1" {
            remarkvc.mycommenttype = commentType.commentExpouse
        }else if mycommentType == "2"{
            remarkvc.mycommenttype = commentType.commentPrefrence
        }
        
        remarkvc.hidesBottomBarWhenPushed=true
        if entity?.ID != nil {
            remarkvc.resourcesId = entity?.ID
        }else if entity?.ID != nil {
            remarkvc.resourcesId = entity?.ID
        }else{
            remarkvc.resourcesId = entity?.ID
        }
        CTUtility.findViewController(self).navigationController?.pushViewController(remarkvc, animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leading : CGFloat = 15
        let textLeading : CGFloat = 10
        
        
        self.bigImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.equalTo()(self.contentView.mas_left)?.with().offset()(leading)
            //let _ = make?.bottom.equalTo()(self.contentView.mas_bottom)?.with().offset()(-10)
            let _ = make?.top.equalTo()(self.contentView.mas_top)?.with().offset()(10)
            let _ = make?.size.mas_equalTo()(CGSize(width: 124, height: 124))
        }
        self.titleLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.equalTo()(self.bigImageView.mas_right)?.with().offset()(textLeading)
            let _ = make?.top.equalTo()(self.contentView.mas_top)?.with().offset()(20)
            let _ = make?.right.equalTo()(self.contentView.mas_right)?.with().offset()(-leading)
            let _ = make?.height.mas_equalTo()(35)
        }
        self.goodsNameLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            
            let _ = make?.left.equalTo()(self.titleLabel)
            let _ = make?.top.equalTo()(self.titleLabel.mas_bottom)?.with().offset()(5)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-leading)
        }
        self.levelLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.equalTo()(self.titleLabel)
            let _ = make?.top.equalTo()(self.goodsNameLabel.mas_bottom)?.with().offset()(15)
        }
        self.levelImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.equalTo()(self.levelLabel.mas_right)?.with().offset()(10)
            let _ = make?.centerY.equalTo()(self.levelLabel)
            let _ = make?.size.equalTo()(CGSize(width: 15, height: 15))
        }
        self.commentButton.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.right.equalTo()(self.contentView.mas_right)?.with().offset()(-leading)
            let _ = make?.top.equalTo()(self.levelLabel.mas_bottom)
            let _ = make?.size.mas_equalTo()(CGSize(width: 44, height: 44))
        }
        self.sourceLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.titleLabel)
            let _ = make?.right.equalTo()(self.commentButton.mas_left)?.offset()(-textLeading)
            let _ = make?.top.mas_equalTo()(self.levelLabel.mas_bottom)?.with().offset()(15)
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
