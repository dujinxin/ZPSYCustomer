//
//  scanlikeCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/17.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class scanlikeCell: UITableViewCell {

    public var produModel:productDetailModel?{
    
        didSet{
            self.likeNumlab.text = (produModel?.praiseNum)! + " Like"
        }
        
    }
    
    public var  userPraiseArr:NSMutableArray?{
    
        didSet{
        
            var arry : [String] = []
            
            for item in userPraiseArr! {
                let model:UserPraiseModel = item as! UserPraiseModel
                arry.append(model.avatar!)
            }
            setHeaderWithArr(arr:arry)
        }
    
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0)
        viewinit()
        
//        setHeaderWithArr(arr: ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489920309176&di=c6fc76a15f7cdfb1753b35cf3661e97a&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fpic%2Fitem%2F908fa0ec08fa513dde11606e3d6d55fbb3fbd9c3.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489920309176&di=c6fc76a15f7cdfb1753b35cf3661e97a&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fpic%2Fitem%2F908fa0ec08fa513dde11606e3d6d55fbb3fbd9c3.jpg"])
        
    }
    
    
   @objc  private func likeBtnClickEvent(){

        let dict = ["id":self.produModel?.ID,"type":"0"]
        MBProgressHUD.showAnimationtoView(CTUtility.findViewController(self).view)
        BaseSeverHttp.zpsyGet(withPath: Api_praiseCommitPraise, withParams: dict, withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: CTUtility.findViewController(self).view)
        
            var num:NSInteger = NSInteger.init(self.produModel!.praiseNum!)!
            num+=1
            self.produModel?.praiseNum = NSString.init(format: "%zi",num) as String
            self.likeNumlab.text = (self.produModel?.praiseNum)! + " Like"
        }) { (err:Error?) in
            MBProgressHUD.hide(for: CTUtility.findViewController(self).view)
        }
    }

    private lazy var likeBtn : UIButton = {
    
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "like"), for: UIControlState.normal)
        return btn
    
    }()
    
    private lazy var likeNumlab : UILabel = {
        let lab = UILabel()
        lab.text = "0 Like"
        lab.textColor = UIColor.gray
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    
    private var img_Arr : [UIImageView]? = []
    
    
    private func setHeaderWithArr(arr:[String]){
        
        let max_count = arr.count > 5 ? 5 : arr.count
        
        for (index,item) in (img_Arr?.enumerated())! {
            let img:UIImageView = item 
            img.isHidden = false
            if index < max_count {
                img.sd_setImage(with: URL.init(string: arr[index]), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            }else if index == max_count {
                img.image = UIImage.init(named: "headermore")
            }else{
                img.isHidden = true
            }
        }
        
    }
    
    
    
    private func viewinit() {
        let viewOne = UIView()
        let middleView = UIView()
        let viewTwo = UIView()
        
        viewOne.backgroundColor = UIColor.white
        middleView.backgroundColor = UIColor.init(colorLiteralRed: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)
        viewTwo.backgroundColor = UIColor.white
        
        self.contentView.addSubview(viewOne)
        self.contentView.addSubview(middleView)
        self.contentView.addSubview(viewTwo)
        
        let messagelistbtn = self.messageListBtn()
        viewOne.addSubview(messagelistbtn)
        viewOne.addSubview(self.likeBtn)
        
        viewOne.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            let _ = make?.height.equalTo()(40)
        }
        middleView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)
            let _ = make?.top.mas_equalTo()(viewOne.mas_bottom)
            let _ = make?.height.equalTo()(10)
        }
        viewTwo.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)
            let _ = make?.top.mas_equalTo()(middleView.mas_bottom)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)
            let _ = make?.height.equalTo()(58)
        }
        self.likeBtn.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(viewOne.mas_left)?.offset()(15)
            let _ = make?.centerY.mas_equalTo()(viewOne)
        }
        messagelistbtn.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.likeBtn.mas_right)?.offset()(10)
            let _ = make?.centerY.mas_equalTo()(viewOne)
        }
        
        
        viewTwo.addSubview(self.likeNumlab)
        
        self.likeNumlab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(viewTwo.mas_left)?.offset()(15)
            let _ = make?.centerY.mas_equalTo()(viewTwo)
        }
        
        var img_pre:UIView = self.likeNumlab
        for item in 0...5 {
            let img = self.imgGet()
            viewTwo.insertSubview(img, at: 0)
            self.img_Arr?.append(img)
            if item == 0{
                img.mas_makeConstraints({ (make:MASConstraintMaker?) in
                let _ = make?.left.mas_equalTo()(img_pre.mas_right)?.offset()(15)
                let _ = make?.centerY.mas_equalTo()(viewTwo)
                let _ = make?.size.equalTo()(CGSize.init(width: 30, height: 30))
            })
            }else{
                img.mas_makeConstraints({ (make:MASConstraintMaker?) in
                    let _ = make?.left.mas_equalTo()(img_pre.mas_right)?.offset()(-6)
                    let _ = make?.centerY.mas_equalTo()(viewTwo)
                    let _ = make?.size.equalTo()(CGSize.init(width: 30, height: 30))
                })
            
            }
            img_pre = img
        }
        
        self.likeBtn.addTarget(self, action: #selector(self.likeBtnClickEvent), for: UIControlEvents.touchUpInside)
    }
    
    
    private func messageListBtn() -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "shape"), for: UIControlState.normal)
        btn.rac_signal(for: UIControlEvents.touchUpInside).subscribeNext {[weak self] (obj:Any?) in
            let remarkvc=HotRemarkVC();
            remarkvc.resourcesId = self?.produModel?.ID
            remarkvc.mycommenttype = commentType.commentProduct
            remarkvc.hidesBottomBarWhenPushed=true
            CTUtility.findViewController(self).navigationController?.pushViewController(remarkvc, animated: true)
        }
        return btn
    }
    
    
    private func imgGet() -> UIImageView {
        let img = UIImageView()
        img.image = UIImage.init(named: "headermore")
        img.layer.cornerRadius = 15
        img.contentMode = UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = UIColor.white
        return img
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
