//
//  ProductOrExposureSelectView.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ProductOrExposureSelectView: UIView {

    public var valueDidChangeWithIndexBlock:((NSInteger)->Void)?
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScaleOfScreen*49))
        viewinit()
    }
    
    func viewinit(){
        
        let segment=UISegmentedControl.init(items: ["商品","发现","正品优选"])
        segment.selectedSegmentIndex = 0
        segment.tintColor = UIColor.clear
        segment.backgroundColor = JXMainColor
        
        segment.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 16),NSForegroundColorAttributeName:UIColor.white], for: UIControlState.selected)
        segment.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 16),NSForegroundColorAttributeName:UIColor.init(white: 1, alpha: 0.5)], for: UIControlState.normal)
        self.addSubview(segment)
        
        segment.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.edges.equalTo()(self)?.with().insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        segment.addTarget(self, action:#selector(self.segmentDidChangeEvent(segment:)), for: UIControlEvents.valueChanged)
        
    }
    
    func segmentDidChangeEvent(segment:UISegmentedControl)  {
        if self.valueDidChangeWithIndexBlock != nil {
            self.valueDidChangeWithIndexBlock!(segment.selectedSegmentIndex)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
