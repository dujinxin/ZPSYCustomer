//
//  priceCompareView.swift
//  ZPSY
//
//  Created by zhouhao on 2017/4/8.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class priceCompareView: UIView,UITableViewDelegate,UITableViewDataSource{

    weak public var VC : UINavigationController? = UINavigationController()
    private lazy var nonedataLab:UILabel = {
        let lab = UILabel()
        lab.text = "暂无数据"
        lab.textColor = UIColor.init(white: 0.5, alpha: 0.5)
        return lab
    }()
    public var showStr : String?
    public var show : Bool = false{
        didSet{
            var trans = CATransform3DIdentity
            if show {
                self.y = kScreenHeight
                trans = CATransform3DMakeScale(0.85, 0.85, 0.5)
                UIView.animate(withDuration: 0.25, animations: {
                    self.y = 0
                    self.VC?.view.layer.transform = trans
                })
            }else{
                UIView.animate(withDuration: 0.25, animations: {
                    self.y = kScreenHeight
                    self.VC?.view.layer.transform = trans
                })
            }
        }
    }
    
    private lazy var mytableview:UITableView={
        let table = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        table.delegate = self
        table.dataSource = self
        table.separatorColor = UIColor.init(white: 0.7, alpha: 0.6)
        table.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 0.1))
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 40
        table.sectionHeaderHeight = 0.1
        table.sectionFooterHeight = 0.1
        return table
    }()
    private lazy var Arraylist:NSMutableArray = []
    public var keyName:String? {
    
        didSet{
        
            MBProgressHUD.showAnimationtoView(self)
            BaseSeverHttp.zpsyGet(withPath: Api_productComparePrices, withParams: ["keyword":(keyName ?? "")], withSuccessBlock: { (result:Any?) in
                MBProgressHUD.hide(for: self)
                
                self.Arraylist = priceModel.mj_objectArray(withKeyValuesArray: result)
                self.mytableview.reloadData()
                
            }) { (err:Error?) in
                MBProgressHUD.hide(for: self)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.backgroundColor = UIColor.init(white: 0.3, alpha: 0.7).cgColor
        self.y = kScreenHeight
        self.mytableview.addSubview(self.nonedataLab)
        self.addSubview(self.mytableview)
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        let titleLab = UILabel.init()
        titleLab.font = UIFont.systemFont(ofSize: 15)
        titleLab.textColor = UIColor.init(white: 0.3, alpha: 1)
        titleLab.text = "比价"
        titleLab.textAlignment = NSTextAlignment.center
        view.addSubview(titleLab)
        self.addSubview(view)
        
        self.mytableview.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.edges.equalTo()(UIEdgeInsetsMake(kScreenHeight*0.55, 0, 0, 0))
        }
        self.nonedataLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.center.equalTo()(self.mytableview)
        }
        view.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.mas_left)
            let _ = make?.right.mas_equalTo()(self.mas_right)
            let _ = make?.bottom.mas_equalTo()(self.mytableview.mas_top)
            let _ = make?.height.equalTo()(40)
        }
        titleLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.center.equalTo()(view)
        }
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.Arraylist.count>0 {
            self.nonedataLab.isHidden = true
        }else{
            self.nonedataLab.isHidden = false
        }
        return self.Arraylist.count
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "tableviewCellDetailId")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "tableviewCellDetailId")
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
            cell?.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
            cell?.detailTextLabel?.textColor=kColor_red
            cell?.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        }
        
        let model:priceModel = self.Arraylist[indexPath.row] as! priceModel
        cell?.textLabel?.text = model.siteName
        cell?.detailTextLabel?.text="¥ " + model.spprice!
        return cell!
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.show = false
        let webVC=WKwebVC()
        let model:priceModel = self.Arraylist[indexPath.row] as! priceModel
        webVC.urLstr = model.spurl
        self.VC?.pushViewController(webVC, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.show = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
