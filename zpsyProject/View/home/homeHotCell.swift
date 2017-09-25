//
//  homeHotCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class homeHotCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.selectionStyle = UITableViewCellSelectionStyle.none
        //viewinit()
        
        self.contentView.addSubview(self.titleView)
        self.contentView.addSubview(self.moreButton)
        self.contentView.addSubview(self.leftView)
        self.contentView.addSubview(self.centerView)
        self.contentView.addSubview(self.rightView)
    }
    lazy var titleView: UILabel = {
        let titlelab = UILabel()
        titlelab.text = "正品优选"
        titlelab.font = UIFont.systemFont(ofSize: 14);
        titlelab.textColor = JX333333Color
        return titlelab
    }()
    lazy var moreButton: UIButton = {
        let anymore = UIButton()
        anymore.setTitle("更多", for: UIControlState.normal)
        anymore.setTitleColor(JX666666Color, for: UIControlState.normal)
        anymore.titleLabel?.font=UIFont.systemFont(ofSize: 12)
        anymore.rac_signal(for: UIControlEvents.touchUpInside).subscribeNext { (x:Any?) in
            
            let hotVC = HotProductVc.init()
            hotVC.hidesBottomBarWhenPushed = true
            CTUtility.findViewController(self).navigationController?.pushViewController(hotVC, animated: true)
        }
        return anymore
    }()
    lazy var leftView: HomeQualityImageView = {
        let view = HomeQualityImageView()
        view.tag = 0
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(tap:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    lazy var centerView: HomeQualityImageView = {
        let view = HomeQualityImageView()
        view.tag = 1
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(tap:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    lazy var rightView: HomeQualityImageView = {
        let view = HomeQualityImageView()
        view.tag = 2
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(tap:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    override func layoutSubviews() {
        
        let width = (kScreenWidth - 15*2*kPercent - 5*2*kPercent)/3
        let height = width * (280 / 315)
        let imageSize = CGSize(width: width, height: height)
        
        self.titleView.mas_remakeConstraints { (make) in
            make?.left.equalTo()(self.contentView.mas_left)?.offset()(15*kPercent)
            make?.top.equalTo()(self.contentView.mas_top)
            let _ = make?.height.mas_equalTo()(44)?.priorityHigh()
        }
        self.moreButton.mas_remakeConstraints { (make) in
            make?.right.equalTo()(self.contentView.mas_right)?.offset()(-15*kPercent)
            make?.size.mas_equalTo()(CGSize(width: 44, height: 44))
            make?.top.mas_equalTo()(self.contentView.mas_top)
        }
        self.leftView.mas_remakeConstraints { (make) in
            make?.left.equalTo()(self.titleView.mas_left)
            make?.top.equalTo()(self.titleView.mas_bottom)?.offset()(0)
            let _ = make?.size.mas_equalTo()(imageSize)?.priorityHigh()
            //make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-15*kPercent)
        }
        self.centerView.mas_remakeConstraints { (make) in
            make?.left.equalTo()(self.leftView.mas_right)?.offset()(5*kPercent)
            make?.top.equalTo()(self.leftView.mas_top)
            make?.size.equalTo()(self.leftView)
        }
        self.rightView.mas_remakeConstraints { (make) in
            make?.left.equalTo()(self.centerView.mas_right)?.offset()(5*kPercent)
            make?.top.equalTo()(self.leftView.mas_top)
            make?.size.equalTo()(self.leftView)
        }
        
        super.layoutSubviews()
    }

    
    @objc private func tapEvent(tap:UIGestureRecognizer){
        let model:ExposureEntity = modelArr![tap.view!.tag]
        let urlStr = model.jumpUrl
        
        let detailVc = ExposureDetailVC()
        detailVc.urlStr = urlStr
        detailVc.thatID =  model.id
        detailVc.webtype = "2"
        detailVc.imgStr = model.img
        detailVc.detilStr = model.detail
        detailVc.hidesBottomBarWhenPushed = true
        CTUtility.findViewController(self).navigationController?.pushViewController(detailVc, animated: true)
    
    }
    
    public var modelArr:[ExposureEntity]? {
        didSet{
        
            guard let array = modelArr else {
                return
            }
//            var random = arc4random_uniform(4)
//            if array.count == 0 {
//                random = 0
//            }
            
            switch array.count {
            case 0:
                self.leftView.isHidden = true
                self.centerView.isHidden = true
                self.rightView.isHidden = true
                break
            case 1:
                self.leftView.isHidden = false
                self.centerView.isHidden = true
                self.rightView.isHidden = true
                
                self.leftView.backImageView.jx_setImage(with: array[0].img.components(separatedBy: ",")[0], placeholderImage: UIImage(named: "placeHoldeImage"), radius: 4)
                self.leftView.contentLabel.text = array[0].title
                break
            case 2:
                self.leftView.isHidden = false
                self.centerView.isHidden = false
                self.rightView.isHidden = true
                
                self.leftView.backImageView.jx_setImage(with: array[0].img.components(separatedBy: ",")[0], placeholderImage: UIImage(named: "placeHoldeImage"), radius: 4)
                self.centerView.backImageView.jx_setImage(with: array[1].img.components(separatedBy: ",")[0], placeholderImage: UIImage(named: "placeHoldeImage"), radius: 4)
                
                self.leftView.contentLabel.text = array[0].title
                self.centerView.contentLabel.text = array[1].title
                break
            default:
                self.leftView.isHidden = false
                self.centerView.isHidden = false
                self.rightView.isHidden = false
                
                self.leftView.backImageView.jx_setImage(with: array[0].img.components(separatedBy: ",")[0], placeholderImage: UIImage(named: "placeHoldeImage"), radius: 4)
                self.centerView.backImageView.jx_setImage(with: array[01].img.components(separatedBy: ",")[0], placeholderImage: UIImage(named: "placeHoldeImage"), radius: 4)
                self.rightView.backImageView.jx_setImage(with: array[2].img.components(separatedBy: ",")[0], placeholderImage: UIImage(named: "placeHoldeImage"), radius: 4)
                
                self.leftView.contentLabel.text = array[0].title
                self.centerView.contentLabel.text = array[1].title
                self.rightView.contentLabel.text = array[2].title
            }
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

class HomeQualityImageView: UIView {
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var contentLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = JXFfffffColor
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 14*kPercent)
        lab.sizeToFit()
        return lab
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    lazy var shadowView: HomeRoundView = {
        let view = HomeRoundView()
        view.backgroundColor = UIColor.clear
        view.alpha = 0.25
        view.cornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.addSubview(self.backImageView)
        self.addSubview(self.shadowView)
//        self.addSubview(self.contentLabel)
//        self.addSubview(self.lineView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backImageView.mas_makeConstraints { (make) in
            make?.left.and().right().top().bottom().equalTo()(self)
        }
//        self.contentLabel.mas_makeConstraints { (make) in
//            make?.center.equalTo()(self)
//            make?.width.mas_equalTo()(80)
//        }
//        self.lineView.mas_makeConstraints { (make) in
//            make?.top.equalTo()(self.contentLabel.mas_bottom)?.offset()(10)
//            make?.centerX.equalTo()(self)
//            make?.size.mas_equalTo()(CGSize(width: 60, height: 0.5))
//        }
        self.shadowView.mas_makeConstraints { (make) in
            make?.left.right().top().bottom().equalTo()(self)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeRoundView: UIView {
    var cornerRadius: CGFloat = 5.0 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    var rectCorner: UIRectCorner = .allCorners {
        didSet{
            self.setNeedsLayout()
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //let path = UIBezierPath(roundedRect: rect, cornerRadius: self.cornerRadius)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: self.rectCorner, cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius))
        
        path.lineCapStyle = .butt
        path.lineJoinStyle = .miter
        UIColor.black.setFill()
        path.fill()
        
    }
}
extension UIImageView {
    func jx_setImage(with urlStr:String, placeholderImage: UIImage?,radius:CGFloat = 0,roundingCorners:UIRectCorner = .allCorners){
        
        guard let url = URL(string: urlStr) else {
            self.image = placeholderImage
            return
        }
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { (image, error, _, url) in
            if
                let image = image,
                radius > 0{
                
                self.image = UIImage.image(originalImage: image, rect: self.bounds, radius: radius,roundingCorners: roundingCorners)
            }
        }
    }
}
extension UIImage {
    static func image(originalImage:UIImage?,rect:CGRect,radius:CGFloat,roundingCorners:UIRectCorner = .allCorners) -> UIImage? {
        guard let image = originalImage else {
            return UIImage.init()
        }
        //opaque 是否透明 false透明 true不透明
        //scale 绘制分辨率，默认为1.0,会模糊，设置为0会自动根据屏幕分辨率来绘制
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        //let path = UIBezierPath(arcCenter: self.center, radius: radius, startAngle: pid_t * 0, endAngle: pid_t * 2, clockwise: true)
        //let path = UIBezierPath(ovalIn: rect)
        //let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius))
        
        //剪切
        path.addClip()
        
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        
        return newImage
    }
}
