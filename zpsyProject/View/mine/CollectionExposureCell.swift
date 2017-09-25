//
//  CollectionExposureCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class CollectionExposureCell: UITableViewCell {

    
    private lazy var ImageView:UIImageView = {
        var image = UIImageView()
        image.image = UIImage.init(named:PlaceHoldeImageStr)
        image.contentMode = UIViewContentMode.scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var textlab:UILabel = {
        var lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.numberOfLines=2
        lab.text = ""
        return lab
    }()
    
    private lazy var detaillab:UILabel = {
        var lab = UILabel()
        lab.numberOfLines = 1
        lab.textColor = UIColor.gray
        lab.font = UIFont.systemFont(ofSize: 11)
        lab.text = ""
        return lab
    }()
    
    private lazy var levelImageView:UIImageView = {
        var image = UIImageView()
        image.image = UIImage.init(named: PlaceHoldeImageStr)
        image.contentMode = UIViewContentMode.scaleAspectFit
        return image
    }()
    
    private lazy var leveltextlab:UILabel = {
        var lab = UILabel()
        lab.numberOfLines = 1
        lab.font = UIFont.systemFont(ofSize: 11)
        lab.textColor = UIColor.gray
        lab.text = "危害等级"
        return lab
    }()
    
    private lazy var salerLab : UILabel = {
    
        let lab = UILabel()
        lab.numberOfLines = 1
        lab.font = UIFont.systemFont(ofSize: 11)
        lab.textColor = UIColor.gray
        lab.text = ""
        return lab
        
    }()

    public var model:exposureModel?{
    
        didSet{
            self.ImageView.sd_setImage(with: URL.init(string: (model?.thumbnail)! as String), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            self.textlab.text = model?.title as String?
            self.detaillab.text = model?.summary as String?
            self.levelImageView.image = UIImage.init(named: "warning"+(model?.hazardClass)!)
            self.salerLab.text = model?.source as String?
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        self.selectionStyle=UITableViewCellSelectionStyle.none
        
        self.contentView.addSubview(self.ImageView)
        self.contentView.addSubview(self.textlab)
        self.contentView.addSubview(self.leveltextlab)
        self.contentView.addSubview(self.levelImageView)
        self.contentView.addSubview(self.detaillab)
        
        self.ImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(15)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.with().offset()(-10)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.with().offset()(15)
            let _ = make?.size.equalTo()(CGSize.init(width: 124, height: 124))
        }
        
        self.textlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.ImageView.mas_right)?.with().offset()(10)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.with().offset()(20)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
            let _ = make?.height.equalTo()(35)
        }
        
        self.detaillab.mas_makeConstraints { (make:MASConstraintMaker?) in
            
            let _ = make?.left.mas_equalTo()(self.ImageView.mas_right)?.with().offset()(10)
            let _ = make?.top.mas_equalTo()(self.textlab.mas_bottom)?.with().offset()(5)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
        }
        
        self.leveltextlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.ImageView.mas_right)?.with().offset()(10)
            let _ = make?.top.mas_equalTo()(self.detaillab.mas_bottom)?.with().offset()(15)
        }

        self.levelImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.leveltextlab.mas_right)?.with().offset()(10)
            let _ = make?.centerY.equalTo()(self.leveltextlab)
            let _ = make?.size.equalTo()(CGSize.init(width: 15, height: 15))
        }
        
        let saLab = UILabel()
        saLab.text = ""
        saLab.textColor = UIColor.gray
        saLab.font = UIFont.systemFont(ofSize: 11)
        self.contentView.addSubview(saLab)
        saLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.ImageView.mas_right)?.with().offset()(10)
            let _ = make?.top.mas_equalTo()(self.leveltextlab.mas_bottom)?.with().offset()(15)
        }
        
        self.contentView.addSubview(self.salerLab)
        self.salerLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(saLab.mas_right)?.offset()(0)
            let _ = make?.centerY.mas_equalTo()(saLab)
        }
        
        
        let shapeBtn = UIButton()
        shapeBtn.setImage(UIImage.init(named: "shapegreen"), for: UIControlState.normal)
        self.contentView.addSubview(shapeBtn)
        shapeBtn.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
            let _ = make?.centerY.mas_equalTo()(saLab)
            let _ = make?.size.equalTo()(CGSize.init(width: 44, height: 44))
        }
        
        shapeBtn.addTarget(self, action: #selector(self.hotRemark), for: UIControlEvents.touchUpInside)
    }

    public var mycommentType:String? = "0"
    
    @objc private func hotRemark(){
        let remarkvc=HotRemarkVC();
        remarkvc.mycommenttype = commentType.commentProduct
        if mycommentType == "1" {
            remarkvc.mycommenttype = commentType.commentExpouse
        }else if mycommentType == "2"{
            remarkvc.mycommenttype = commentType.commentPrefrence
        }
        
        remarkvc.hidesBottomBarWhenPushed=true
        if model?.ID != nil {
            remarkvc.resourcesId = model?.ID
        }else if model?.ID != nil {
            remarkvc.resourcesId = model?.ID
        }else{
            remarkvc.resourcesId = model?.ID
        }
        CTUtility.findViewController(self).navigationController?.pushViewController(remarkvc, animated: true)
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
