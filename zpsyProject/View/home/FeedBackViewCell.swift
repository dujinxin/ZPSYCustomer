//
//  FeedBackViewCell.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/8/30.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class FeedBackViewCell: UITableViewCell {
    
    var contentPlaceholderString: String = "请留下您宝贵的建议···"{
        didSet{
            self.contentPlaceHolderLabel.text = contentPlaceholderString
            self.contentPlaceHolderLabel.frame = CGRect(x: 5, y: 6, width: kScreenWidth - 30 - 12, height: 170 * kScaleOfScreen - 10)
            self.contentPlaceHolderLabel.sizeToFit()
        }
    }
    private var contentPlaceHolderLabel : UILabel!
    
    var suggestBlock:((String)->Void)?
    var nameBlock:((String)->Void)?
    var phoneBlock:((String)->Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        viewInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func viewInit(){
        
        let bgView=UIView.init(frame: CGRect.init(x: 15, y: 0, width: kScreenWidth - 30, height: 254*kScaleOfScreen))
        bgView.backgroundColor = UIColor.white
        self.contentView.addSubview(bgView)
        
        let w = bgView.frame.size.width
        let h = 170 * kScaleOfScreen
        let textView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: w, height: h))
        textView.font = UIFont.systemFont(ofSize: 13*kPercent)
        textView.delegate = self
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
        
        
        
        let numLab:UILabel = UILabel.init(frame: CGRect.init(x: w-80+15, y: bgView.frame.maxY, width: 80, height: 15*kScaleOfScreen))
        numLab.font=UIFont.systemFont(ofSize: 11)
        numLab.textAlignment=NSTextAlignment.right
        numLab.textColor=UIColor.gray
        self.contentView.addSubview(numLab)
        
        textView.rac_textSignal().subscribeNext { (x) in
            guard let str = x as? String else{
                return
            }
            if (str.characters.count == 0) {
                self.contentPlaceHolderLabel.isHidden = false;
            }else{
                self.contentPlaceHolderLabel.isHidden = true;
                if (str.characters.count >= 150) {
                    textView.text = str.substring(to: str.index(str.startIndex, offsetBy: 149))
                }
            }
            numLab.text = "\(str.characters.count)/150"
            guard let suggestBlock = self.suggestBlock else{
                return
            }
            suggestBlock(str)
        }
        
        let nameTextField : UITextField = {
            let textField = UITextField.init(frame: CGRect.init(x: 0, y: textView.frame.maxY, width: w, height: 42*kScaleOfScreen))
            textField.delegate = self
            textField.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            textField.layer.borderWidth = 0.5
            textField.placeholder = "请输入您的姓名"
            textField.font = UIFont.systemFont(ofSize: 15)
            textField.keyboardType = UIKeyboardType.default
            textField.leftViewMode = UITextFieldViewMode.always
            textField.leftView = {
                let contentView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 42*kScaleOfScreen))
                
                let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 42*kScaleOfScreen))
                titleLabel.text = "姓      名"
                titleLabel.font = UIFont.systemFont(ofSize: 15)
                titleLabel.textAlignment = NSTextAlignment.center
                
                let separateView = UIView.init(frame: CGRect.init(x: 73, y: 10, width: 1, height: 42*kScaleOfScreen-20))
                separateView.backgroundColor = UIColor.gray
                
                contentView.addSubview(titleLabel)
                contentView.addSubview(separateView)
                
                return contentView
            }()
            return textField
        }()
        nameTextField.rac_textSignal().subscribeNext { (x) in
            
            guard
                let str = x as? String,
                let nameBlock = self.nameBlock else{
                return
            }
            nameBlock(str)
        }
        bgView.addSubview(nameTextField)
        
        
        let phoneTextField : UITextField = {
            let textField = UITextField.init(frame: CGRect.init(x: 0, y: nameTextField.frame.maxY, width: w, height: 42*kScaleOfScreen))
            textField.delegate = self
            textField.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            textField.layer.borderWidth = 0.5
            textField.placeholder = "请输入您的手机号码"
            textField.font = UIFont.systemFont(ofSize: 15)
            textField.keyboardType = UIKeyboardType.numberPad
            textField.leftViewMode = UITextFieldViewMode.always
            textField.leftView = {
                let contentView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 42*kScaleOfScreen))
                
                let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 42*kScaleOfScreen))
                titleLabel.text = "手机号码"
                titleLabel.font = UIFont.systemFont(ofSize: 15)
                titleLabel.textAlignment = NSTextAlignment.center
                
                let separateView = UIView.init(frame: CGRect.init(x: 73, y: 10, width: 1, height: 42*kScaleOfScreen-20))
                separateView.backgroundColor = UIColor.gray
                
                contentView.addSubview(titleLabel)
                contentView.addSubview(separateView)
                
                return contentView
            }()
            return textField
        }()
        phoneTextField.rac_textSignal().subscribeNext { (x) in
            guard
                let str = x as? String,
                let phoneBlock = self.phoneBlock else{
                    return
            }
            phoneBlock(str)
        }
        bgView.addSubview(phoneTextField)
        
  
        
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
extension FeedBackViewCell: UITextFieldDelegate,UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
