//
//  feedbackselectCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/15.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class feedbackselectCell: UITableViewCell {

    //var titleArray : NSArray = ["产品问题","扫码问题","意见建议","其他"]
    var selectresult:((NSInteger)->Void)?
    
    var buttonArray = [UIButton]()
    
    var titleArray: Array<String> = ["产品问题","扫码问题","意见建议","其他"]{
        didSet{
            for i in 0..<titleArray.count{
                let button = buttonArray[i]
                button.setTitle(titleArray[i], for: .normal)
            }
        }
    }
    var titleName: String = "请您选择要反馈的问题" {
        didSet{
            self.titleLabel.text = titleName
        }
    }
    private var titleLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        viewinit()
    }
    
    private func viewinit() {
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        titleLabel = UILabel.init(frame:CGRect.init(x: 15, y: 0, width: kScreenWidth - 15*2, height: 35))
        titleLabel.text = "请您选择要反馈的问题"
        titleLabel.textColor = JX333333Color
        self.contentView.addSubview(titleLabel)
        
        let bgView = UIView.init(frame: CGRect.init(x: 15, y: 35, width: kScreenWidth-30, height: 88*kScaleOfScreen))
        bgView.backgroundColor = UIColor.white
        self.contentView.addSubview(bgView)
 
        let w:CGFloat = bgView.frame.size.width/2.0
        let h:CGFloat = bgView.frame.size.height/2.0
        
        for (index,item) in titleArray.enumerated() {
            let x:NSInteger = index%2;
            let y:NSInteger = index/2;
            let btn = UIButton.init(frame: CGRect.init(x: (w*CGFloat(x)), y: h*CGFloat(y), width: w, height: h))
            btn.setTitle(String(describing: item), for: UIControlState.normal)
            btn.setTitleColor(JX333333Color, for: UIControlState.normal)
            btn.tag = index
            btn.addTarget(self, action: #selector(self.btnclickevent(btn:)), for: UIControlEvents.touchUpInside)
            btn.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            btn.layer.borderWidth = 0.5
            btn.layer.masksToBounds = true
            bgView.addSubview(btn)
            
            buttonArray.append(btn)
        }
    }
    private var selectbtn:UIButton?
    @objc private func btnclickevent(btn:UIButton) -> Void {
        if (self.selectbtn != nil) {
            self.selectbtn?.backgroundColor = UIColor.white
            self.selectbtn?.setTitleColor(JX333333Color, for: UIControlState.normal)
        }
        self.selectbtn=btn
        self.selectbtn?.backgroundColor=UIColor.gray
        self.selectbtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
        if self.selectresult != nil {
            self.selectresult!(btn.tag)
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
