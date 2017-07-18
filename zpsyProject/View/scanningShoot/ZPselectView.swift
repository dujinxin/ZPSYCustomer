//
//  ZPselectView.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/6/1.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

enum ZPselectViewPosition : Int {
    case top
    case middle
    case bottom
}

protocol ZPselectViewDelegate {
    
    func zpSelectView(_ selectView:ZPselectView,didSelectRow row:Int
    )
}

class ZPselectView: UIView ,UITableViewDelegate,UITableViewDataSource{
    
    static let systemPickerViewHeight = 216.0
    static let topBarHeight = 40.0
    
    public var deviceArray:NSMutableArray = []
    
    private var bgWindow : UIWindow = {
        let window = UIWindow()
        window.frame = UIScreen.main.bounds
        window.windowLevel = UIWindowLevelAlert + 1
        window.backgroundColor = UIColor.clear
        window.isHidden = false;
        
        return window
    }()
    
    private var bgView : UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor.black
        view.alpha = 0.0
        view.tag = 10
        
//        let tap = UITapGestureRecognizer()
//        tap.addTarget(self, action: #selector(dismissView))
//        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private var topBarView : UIView = {
        let view = UIView()
        view.frame = CGRect.init(x: 0.0, y: 0.0, width: 100.0, height: topBarHeight)
        view.backgroundColor = UIColor.lightText
    
        return view
    }()
    
    @objc private func dismissView(){
        
        self.dismiss(animate: true)
    }
    
    
    public var position = ZPselectViewPosition(rawValue: 0)
    
    public var customView : UIView?
    
    public func setCustomView(view: UIView) -> Void {
        
        customView = view
        
        self.frame = CGRect.init(origin: CGPoint.init(x: 0.0, y: 0.0), size: view.bounds.size)
        
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(dismissView))
        bgView.addGestureRecognizer(tap)

    }
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        
        //NSAssert(customView, "customView can not be nil!");
        //self.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        self.frame = CGRect.init(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
        self.backgroundColor = UIColor.clear
 
        self.position = ZPselectViewPosition.middle;
        
        //self.setCustomView(view: addCustomSubViews())
   
    }
    
    func show(inView view : UIView,animate animated:Bool = true) -> Void{
        //
        self.addSubview(self.customView!)
        //添加背景
//        var center = CGPoint.init()
//        if view != nil{
//            //动画
//            view.addSubview(self.bgView)
//            center = view.center
//            self.center = CGPoint.init(x: center.x, y: (center.y - 64/2))
//            view.addSubview(self)
//            
//        }else{
            if (self.position == ZPselectViewPosition.top) {
                var rect = self.frame
                rect.origin.y = 0.0 - self.frame.size.height;
                self.frame = rect
            }else if (self.position == ZPselectViewPosition.bottom){
                var rect = self.frame
                rect.origin.y = self.bgWindow.frame.size.height;
                self.frame = rect
            }else{
                self.center = self.bgWindow.center;
            }
            self.bgWindow.isHidden = false
            self.bgWindow.addSubview(self.bgView)
            self.bgWindow.addSubview(self)
        
        //print("customView.subViews == ",self.customView?.subviews ?? "空")
        
//        }
        if (animated) {
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.bgView.alpha = 0.5
                if (self.position == ZPselectViewPosition.top) {
                    var rect = self.frame
                    rect.origin.y = 0.0
                    self.frame = rect
                }else if (self.position == ZPselectViewPosition.bottom){
                    var rect = self.frame
                    rect.origin.y = self.bgWindow.frame.size.height - self.frame.size.height
                    self.frame = rect
                }else{
                    self.center = self.bgWindow.center
                }
            }, completion: { (finished:Bool) in
//                if (po == JXSelectViewStyleList) {
//                    [self.tableView reloadData];
//                }else if(_selectViewStyle == JXSelectViewStylePick){
//                    [self.pickView reloadAllComponents];
//                    if (_selectRow >=0) {
//                        [self.pickView selectRow:_selectRow inComponent:0 animated:YES];
//                    }
//                }
                let tableView : UITableView = self.customView?.viewWithTag(1001) as! UITableView
             
                tableView.reloadData()
                
            })
            
           
        }
    }
    
    func dismiss(animate animated:Bool = true){
        
//        let tempView = self.superview?.viewWithTag(10)
//        tempView?.removeFromSuperview()
        
        if (animated) {
            UIView .animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { 
                if (self.position == ZPselectViewPosition.top) {
                    var rect = self.frame
                    rect.origin.y = 0.0 - self.frame.size.height
                    self.frame = rect
                }else if (self.position == ZPselectViewPosition.bottom){
                    var rect = self.frame
                    rect.origin.y = self.bgWindow.frame.size.height
                    self.frame = rect
                }else{
                    self.center = self.bgWindow.center
                    
                }
                self.bgView.alpha = 0.0;
            }, completion: { (finished:Bool) in
                self.clearInfo()
            })
            
        }else{
            self.clearInfo()
        }
    }
    
    func clearInfo(){
//        if (_bgView) {
//            [_bgView removeFromSuperview];
//        }
//        if (_topBarView) {
//            [_topBarView removeAllSubviews];
//            [_topBarView removeFromSuperview];
//        }
//        [self removeFromSuperview];
//        if (_bgWindow) {
//            _bgWindow.hidden = YES;
//            _bgWindow = nil;
//        }
        self.customView?.removeFromSuperview()
        self.bgView.removeFromSuperview()
        self.topBarView.removeFromSuperview()
        self.removeFromSuperview()
        self.bgWindow.isHidden = true
    }
    
    
    
    func addCustomSubViews() -> (
        UIView) {
            //
            
            let contentView = UIView()
            
            contentView.frame = CGRect.init(x: 0, y: 0, width: Double(kScreenWidth - 40.0), height: Double(kScreenWidth - 40.0))
            contentView.backgroundColor = UIColor.white
            contentView.layer.masksToBounds = true
            contentView.layer.cornerRadius = 5
            
            let blueBgView = UIView()
            blueBgView.backgroundColor = Utility.jxColor(fromRGB: 0x00b9de)
            contentView.addSubview(blueBgView)
            
            let logoImageView = UIImageView()
            
            logoImageView.backgroundColor = Utility.jxDebugColor()
            logoImageView.image = UIImage.init(named: "company")
            contentView.addSubview(logoImageView)
            
            let closeButton = UIButton()
            closeButton.setImage(UIImage.init(named: ""), for: UIControlState.normal)
            closeButton.setTitle("ⅹ", for: UIControlState.normal)
            closeButton.backgroundColor = Utility.jxDebugColor()
            closeButton.addTarget(self, action: #selector(dismissView), for: UIControlEvents.touchUpInside)
            contentView.addSubview(closeButton)
            
            let titleLabel = UILabel()
            titleLabel.text = "企业介绍"
            titleLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
            titleLabel.textAlignment = NSTextAlignment.center
            titleLabel.font = UIFont.systemFont(ofSize: 20)
            contentView.addSubview(titleLabel)
            
            let nameLabel = UILabel()
            nameLabel.text = "企业名称：正品溯源"
            nameLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
            nameLabel.textAlignment = NSTextAlignment.center
            nameLabel.font = UIFont.systemFont(ofSize: 15)
            contentView.addSubview(nameLabel)
            
            
            let numLabel = UILabel()
            numLabel.text = "营业执照注册号：1234567656432425364"
            numLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
            numLabel.textAlignment = NSTextAlignment.center
            numLabel.font = UIFont.systemFont(ofSize: 15)
            contentView.addSubview(numLabel)
            
            let bottomButton = UIButton()
            
            bottomButton.setImage(UIImage.init(named: "auth"), for: UIControlState.normal)
            bottomButton.setTitle("企业信息已认证", for: UIControlState.normal)
            bottomButton.setTitleColor(Utility.jxColor(fromRGB: 0xaf0808), for: UIControlState.normal)
            bottomButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10)
            bottomButton.titleLabel?.backgroundColor = Utility.jxDebugColor()
            
            bottomButton.imageView?.backgroundColor = Utility.jxDebugColor()
            contentView.addSubview(bottomButton)
            
            blueBgView.mas_makeConstraints { (make:MASConstraintMaker?) in
                let _ = make?.top.left().equalTo()(contentView)?.offset()(5)
                let _ = make?.right.equalTo()(contentView.mas_right)?.offset()(-5)
                let _ = make?.height.mas_equalTo()(100)
            }
            logoImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
                let _ = make?.center.equalTo()(blueBgView)
                let _ = make?.size.mas_equalTo()(CGSize.init(width: 70, height: 70))
            }
            closeButton.mas_makeConstraints { (make:MASConstraintMaker?) in
                make?.top.equalTo()(contentView.mas_top)?.offset()(5)
                make?.right.equalTo()(contentView.mas_right)?.offset()(-5)
                make?.size.mas_equalTo()(CGSize.init(width: 30, height: 30))
            }
            titleLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
                make?.top.equalTo()(blueBgView.mas_bottom)?.offset()(20)
                make?.left.right().equalTo()(contentView)
                make?.height.mas_equalTo()(20)
            }
            nameLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
                make?.top.equalTo()(titleLabel.mas_bottom)?.offset()(35)
                make?.left.right().equalTo()(contentView)
                make?.height.mas_equalTo()(20)
            }
            numLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
                make?.top.equalTo()(nameLabel.mas_bottom)?.offset()(30)
                make?.left.right().equalTo()(contentView)
                make?.height.mas_equalTo()(20)
            }
            bottomButton.mas_makeConstraints { (make:MASConstraintMaker?) in
                make?.top.equalTo()(numLabel.mas_bottom)?.offset()(30)
                make?.left.right().equalTo()(contentView)
                make?.height.mas_equalTo()(20)
            }
            
            return contentView
    }
    
    
    func addDeviceTableView() -> (UIView){
        //
        
        let contentView = UIView()
        
        contentView.frame = CGRect.init(x: 0, y: 0, width: Double(kScreenWidth - 40.0), height: Double(kScreenWidth - 40.0))
        contentView.backgroundColor = UIColor.white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 5
        
        let blueBgView = UIView()
        blueBgView.backgroundColor = Utility.jxColor(fromRGB: 0x00b9de)
        contentView.addSubview(blueBgView)
        
        let titleLabel = UILabel()
        titleLabel.text = "扫码详情"
        titleLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(titleLabel)
        
        
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage.init(named: ""), for: UIControlState.normal)
        closeButton.setTitle("ⅹ", for: UIControlState.normal)
        closeButton.backgroundColor = Utility.jxDebugColor()
        closeButton.addTarget(self, action: #selector(dismissView), for: UIControlEvents.touchUpInside)
        contentView.addSubview(closeButton)
        
        
        let tableView = UITableView(frame: CGRect.init(), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0)
        tableView.rowHeight = 44
        tableView.tag = 1001
        tableView.backgroundColor = Utility.jxDebugColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.contentOffset = CGPoint.init(x: 0, y: 0)
        tableView.register(DeviceCell.self, forCellReuseIdentifier: "cellId")
        
        contentView.addSubview(tableView)
        
        let infoStr = "此正品溯源码已在不同设备、不同地点总共扫了\(self.deviceArray.count)次！请仔细核对以下扫码记录，如果有确认不是您本人掌握的扫码记录，则此商品可能有疑问。"
        
        let infoLabel = UILabel()
        infoLabel.text = infoStr
        infoLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
        infoLabel.textAlignment = NSTextAlignment.center
        infoLabel.font = UIFont.systemFont(ofSize: 15)
        infoLabel.backgroundColor = Utility.jxDebugColor()
        infoLabel.numberOfLines = 0
        tableView.addSubview(infoLabel)
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let attributeString = NSMutableAttributedString.init(string: infoStr)
        attributeString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, infoStr.characters.count))
        
        infoLabel.attributedText = attributeString
        
        let ocStr = infoStr as NSString
    
        //let option = NSStringDrawingOptions.init(rawValue: 1)
        
        let rect = ocStr.boundingRect(with: CGSize.init(width: contentView.size.width - 40, height: 1000), options: [NSStringDrawingOptions(rawValue: 0),NSStringDrawingOptions(rawValue: 1),NSStringDrawingOptions(rawValue: 2),NSStringDrawingOptions(rawValue: 3)], attributes: [NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:infoLabel.font], context: nil)
        
        
        
        print("rect = \(rect)")
        tableView.contentInset = UIEdgeInsetsMake(rect.size.height + 12, 0, 0, 0)
        
        blueBgView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.left().equalTo()(contentView)?.offset()(5)
            let _ = make?.right.equalTo()(contentView.mas_right)?.offset()(-5)
            let _ = make?.height.mas_equalTo()(100)
        }
        titleLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.center.equalTo()(blueBgView)
            make?.size.mas_equalTo()(CGSize.init(width: 100, height: 30))
        }
        closeButton.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(contentView.mas_top)?.offset()(5)
            make?.right.equalTo()(contentView.mas_right)?.offset()(-5)
            make?.size.mas_equalTo()(CGSize.init(width: 30, height: 30))
        }
        tableView.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(blueBgView.mas_bottom)
            make?.left.right().equalTo()(contentView)
            make?.bottom.equalTo()(contentView.mas_bottom)
        }
        infoLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(tableView.mas_top)?.offset()(-rect.size.height - 12)
            make?.left.equalTo()(tableView.mas_left)?.offset()(20)
            make?.size.mas_equalTo()(CGSize.init(width: rect.size.width, height: rect.size.height + 12))
        }
        
        return contentView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deviceArray.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DeviceCell
        
        if indexPath.row == 0 {
            cell.timeLabel.text = "扫码时间"
            cell.deviceLabel.text = "机型"
            cell.addressLabel.text = "扫码地点"
        } else {
            cell.deviceModel = self.deviceArray[indexPath.row - 1] as? ScanrecordForSuspectProductModel
        }
        
        
        return cell
    }
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DeviceCell: UITableViewCell {
    
    public var deviceModel:ScanrecordForSuspectProductModel? {
        didSet{
//            if let str = deviceModel?.scanTime {
//                self.timeLabel.text = str.substring(to: str.index(str.startIndex, offsetBy: 10))
//            }
            self.timeLabel.text = deviceModel?.scanTime
            self.deviceLabel.text = deviceModel?.model
            self.addressLabel.text = deviceModel?.city
        }
    }
    
    lazy var timeLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "企业介绍"
        titleLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    lazy var deviceLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "企业名称：正品溯源"
        nameLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
        nameLabel.backgroundColor = UIColor.white
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    lazy var addressLabel : UILabel = {
        let numLabel = UILabel()
        numLabel.text = "营业执照注册号：1234567656432425364"
        numLabel.backgroundColor = UIColor.white
        numLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
        numLabel.textAlignment = NSTextAlignment.center
        numLabel.font = UIFont.systemFont(ofSize: 13)
        return numLabel
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.groupTableViewBackground
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(deviceLabel)
        self.contentView.addSubview(addressLabel)
    
        
    }
    override func layoutSubviews() {
        let size = CGSize.init(width: ((self.bounds.size.width - 4.0) / 3.0), height: (self.bounds.size.height - 1))
        
        print(self.size)
        print(size)
        
        timeLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.contentView)?.offset()(0.5)
            make?.left.equalTo()(self.contentView.mas_left)?.offset()(1)
            make?.size.mas_equalTo()(size)
        }
        deviceLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.contentView)?.offset()(0.5)
            make?.left.equalTo()(self.timeLabel.mas_right)?.offset()(1)
            make?.size.mas_equalTo()(size)
        }
        addressLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.contentView)?.offset()(0.5)
            make?.left.equalTo()(self.deviceLabel.mas_right)?.offset()(1)
            make?.size.mas_equalTo()(size)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
