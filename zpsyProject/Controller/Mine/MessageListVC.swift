//
//  MessageListVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class MessageListVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="消息"
        viewinit()
        dateRequest()
    }
    
    private var pageNo = 1
    private var ListArray:NSMutableArray = NSMutableArray.init()
    
    private func viewinit() {
        
        let view=UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 15))
        self.tableView.tableHeaderView=view
        self.tableView.sectionFooterHeight = 1
        self.tableView.rowHeight=UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight=10
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.register(ReportCell.self, forCellReuseIdentifier: "messageCellId")
        self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: {
            self.pageNo+=1
            self.dateRequest()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func dateRequest() {
        let dic = ["pageNo":pageNo]
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_GetMessageList, withParams: dic, withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            
            if self.pageNo == 1{
                self.ListArray = NSMutableArray.init(array: messageModel.mj_objectArray(withKeyValuesArray: result))
                if self.ListArray.count == 0 {
                    MBProgressHUD.showError("暂无数据")
                }
            }else{
                self.ListArray.addObjects(from: ((messageModel.mj_objectArray(withKeyValuesArray: result))as NSArray) as! [Any])
            }
            self.tableView.reloadData()
            
        }) { (error:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.ListArray.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model:messageModel = self.ListArray[indexPath.section] as! messageModel
        if indexPath.row == 0 {
            let cell:ReportCell = tableView.dequeueReusableCell(withIdentifier: "messageCellId", for: indexPath) as! ReportCell;
            cell.textlab.text = model.title as String?
            cell.timerlab.text = CTUtility.string(from: model.time, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
            cell.ImageView.sd_setImage(with: URL.init(string: model.field1!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            cell.LogoImg.sd_setImage(with: URL.init(string: model.imagethum!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            return cell
        }
        var cell = tableView .dequeueReusableCell(withIdentifier: "cellidentifier")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cellidentifier")
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.textColor = UIColor.gray
        }
        cell?.textLabel?.text = model.contents
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model:messageModel = self.ListArray[indexPath.section] as! messageModel
        
        if (model.field3 != nil) && (model.field3 == "1" || model.field3 == "2"){//曝光，正品优选详情
            let expoDetailVC = ExposureDetailVC()
            expoDetailVC.urlStr = model.url
            expoDetailVC.thatID = model.ID
            expoDetailVC.webtype = model.field3
            expoDetailVC.webtype = model.contents
            self.navigationController?.pushViewController(expoDetailVC, animated: true)
            return
        }
        
        if (model.field3 != nil) && (model.field3 == "0"){//商品详情
            let prodVC = ProductDetailVC()
            prodVC.ProductID = model.ID
            self.navigationController?.pushViewController(prodVC, animated: true)
            return
        }
        
        let webVc = WKwebVC()
        webVc.urLstr = model.url
        self.navigationController?.pushViewController(webVc, animated: true)
    }
}
