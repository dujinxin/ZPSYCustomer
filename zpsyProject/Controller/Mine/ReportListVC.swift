//
//  ReportListVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/20.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ReportListVC: UITableViewController {

    
    private var pageNo = 1
    private var listArr : NSMutableArray = NSMutableArray.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="举报"
        
        self.tableView.register(FdbackAndReportCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.register(FdbackAndReportShowPicCell.self, forCellReuseIdentifier: "ShowPicreuseIdentifier")
        self.tableView.register(ReportCell.self, forCellReuseIdentifier: "ReportCellreuseIdentifier")
        
        self.tableView.estimatedRowHeight=10
        self.tableView.rowHeight=UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight=5
        self.tableView.sectionFooterHeight=5
        self.tableView.contentInset=UIEdgeInsetsMake(-20, 0, 0, 0)
        
        self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: {
            self.pageNo+=1
            self.datarequest()
        })
        
        self.datarequest()
    }

    
    private func datarequest() {
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_getReport, withParams: ["pageNo":pageNo], withSuccessBlock: { (result:Any?) in
            self.tableView.mj_footer.endRefreshing()
            MBProgressHUD.hide(for: self.view)
            if self.pageNo == 1{
                self.listArr = NSMutableArray.init(array: reportModel.mj_objectArray(withKeyValuesArray: result))
            }else{
                let arr:Array = reportModel.mj_objectArray(withKeyValuesArray: result) as Array
                self.listArr.addObjects(from: arr)
            }
            self.tableView.reloadData()
        }) { (err:Error?) in
            self.tableView.mj_footer.endRefreshing()
            MBProgressHUD.hide(for: self.view)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.listArr.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model:reportModel = listArr[section] as! reportModel
        return 2 + model.answerRowGet()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model:reportModel = listArr[indexPath.section] as! reportModel

        if indexPath.row==0 {
            let cell:ReportCell = tableView.dequeueReusableCell(withIdentifier: "ReportCellreuseIdentifier", for: indexPath) as! ReportCell;
            cell.textlab.text = model.proModel?.name as String?
            cell.timerlab.text = CTUtility.string(from: model.createDateStr, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
            cell.ImageView.sd_setImage(with: URL.init(string: (model.proModel?.getfirstGoodImg())!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            cell.LogoImg.sd_setImage(with: URL.init(string: (model.proModel?.thumbnail)! as String), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            return cell
        }
        else if indexPath.row==1 {
            
            var isHasPic=true  //是否包含图片
            let arr = model.imageArrGet()
            if arr.count == 0 {
                isHasPic=false
            }
            if isHasPic {
                let cell:FdbackAndReportShowPicCell = tableView.dequeueReusableCell(withIdentifier: "ShowPicreuseIdentifier", for: indexPath) as! FdbackAndReportShowPicCell;
                cell.titleLab.text="举报内容"
                //cell.timelab.text="2010-2-09"
                cell.mainlab.text=model.contents
                cell.picShowView.imageUrlArray=NSMutableArray.init(array: arr)
                return cell
            }else{
                let cell:FdbackAndReportCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FdbackAndReportCell;
                cell.titleLab.text="举报内容"
                //cell.timelab.text="2010-2-09"
                cell.mainlab.text=model.contents
                return cell
            }
            
        }
        else{
            let cell:FdbackAndReportCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FdbackAndReportCell;
            cell.titleLab.text="答复"
            //cell.timelab.text="2010-2-09"
            cell.mainlab.text=model.answer
            return cell
        }
        

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
