//
//  LocationViewController.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/9/19.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = JXFfffffColor

        self.title = "正品溯源"
        
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "location_default")
        self.view.addSubview(logoImageView)
        
        let noticeLabel = UILabel()
        noticeLabel.text = "为提高溯源位置的精度，请您打开位置信息"
        noticeLabel.textAlignment = .center
        //noticeLabel.font = UIFont.systemFont(ofSize: 14)
        noticeLabel.textColor = JX333333Color
        noticeLabel.numberOfLines = 0
        noticeLabel.sizeToFit()
        self.view.addSubview(noticeLabel)
        
        let button = UIButton()
        button.setTitle("立即打开", for: .normal)
        button.backgroundColor = JXMainColor
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(JXFfffffColor, for: .normal)
        button.addTarget(self, action: #selector(open), for: .touchUpInside)
        self.view.addSubview(button)
        
        noticeLabel.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.view)
            make?.centerY.equalTo()(self.view)?.offset()(32)
            make?.leftMargin.mas_equalTo()(30)
            make?.rightMargin.mas_equalTo()(30)
        }
        logoImageView.mas_makeConstraints { (make) in
            make?.bottom.equalTo()(noticeLabel.mas_top)?.offset()(-40)
            make?.centerX.equalTo()(self.view)
        }
        button.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.view)
            make?.top.equalTo()(noticeLabel.mas_bottom)?.offset()(65)
            make?.size.mas_equalTo()(CGSize(width: 260, height: 44))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func open() {
        if
            let url = URL.init(string: UIApplicationOpenSettingsURLString),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.openURL(url)
        }
        
        //NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES&path=com.zhengpinsuyuan.zpsy"];
        
    }

}
