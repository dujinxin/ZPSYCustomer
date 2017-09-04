//
//  feedbackinfoCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/16.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class feedbackinfoCell: UITableViewCell {
    
    var contentPlaceholderString: String = "请留下您宝贵的建议···"{
        didSet{
            self.contentPlaceHolderLabel.text = contentPlaceholderString
            self.contentPlaceHolderLabel.frame = CGRect(x: 5, y: 6, width: kScreenWidth - 30 - 12, height: 170 * kScaleOfScreen - 10)
            self.contentPlaceHolderLabel.sizeToFit()
        }
    }
    private var contentPlaceHolderLabel : UILabel!
    

    var suggestresult:((String)->Void)?
    var phoneresult:((String)->Void)?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        viewinit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func viewinit(){
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        let bgView=UIView.init(frame: CGRect.init(x: 15, y: 0, width: kScreenWidth - 30, height: 212*kScaleOfScreen))
        bgView.backgroundColor = UIColor.white
        self.contentView.addSubview(bgView)
        
        let w = bgView.frame.size.width
        let h = 170 * kScaleOfScreen
        let textView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: w, height: h))
        textView.font = UIFont.systemFont(ofSize: 13*kPercent)
        textView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        textView.layer.borderWidth = 0.5
        bgView.addSubview(textView)
        
        contentPlaceHolderLabel = UILabel.init(frame: CGRect.init(x: 5, y: 6, width: w - 12, height: h - 10))
        contentPlaceHolderLabel.text = contentPlaceholderString
        contentPlaceHolderLabel.font=UIFont.systemFont(ofSize: 13*kPercent)
        contentPlaceHolderLabel.textColor=UIColor.gray
        contentPlaceHolderLabel.numberOfLines = 0
        contentPlaceHolderLabel.sizeToFit()
        textView.addSubview(contentPlaceHolderLabel)
        
        
        
        let numLab:UILabel=UILabel.init(frame: CGRect.init(x: w-80+15, y: bgView.frame.maxY, width: 80, height: 15*kScaleOfScreen))
        numLab.font=UIFont.systemFont(ofSize: 11)
        numLab.textAlignment=NSTextAlignment.right
        numLab.textColor=UIColor.gray
        self.contentView.addSubview(numLab)

        textView.rac_textSignal().subscribeNext { (x) in
            let str:NSString=x as! NSString
            let num:NSInteger = str.length;
            if (num==0) {
                self.contentPlaceHolderLabel.isHidden=false;
            }else{
                self.contentPlaceHolderLabel.isHidden=true;
                if (num>=150) {
                    textView.text=str.substring(to: 149);
                }
            }
            numLab.text="\(num)/150"
            if (self.suggestresult != nil){
                self.suggestresult!(str as String)
            }
        }
        
        let iphonetext = UITextField.init(frame: CGRect.init(x: 0, y: textView.frame.maxY, width: w, height: 42*kScaleOfScreen))
        iphonetext.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        iphonetext.layer.borderWidth = 0.5
        iphonetext.placeholder = "请输入您的手机号码"
        iphonetext.font = UIFont.systemFont(ofSize: 15)
        iphonetext.keyboardType = UIKeyboardType.numberPad
        iphonetext.leftViewMode = UITextFieldViewMode.always
        bgView.addSubview(iphonetext);
        
        iphonetext.rac_textSignal().subscribeNext { (x) in
            let str:String=x as! String
            if self.phoneresult != nil{
                self.phoneresult!(str)
            }
        }
        
        let phonetitle = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 42*kScaleOfScreen))
        phonetitle.text = "手机号码"
        phonetitle.font = UIFont.systemFont(ofSize: 15)
        phonetitle.textAlignment = NSTextAlignment.center
        let rightview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 42*kScaleOfScreen))
        let speretview = UIView.init(frame: CGRect.init(x: 73, y: 10, width: 1, height: 42*kScaleOfScreen-20))
        speretview.backgroundColor = UIColor.gray
        
        rightview.addSubview(phonetitle)
        rightview.addSubview(speretview)
        iphonetext.leftView = rightview
    
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
