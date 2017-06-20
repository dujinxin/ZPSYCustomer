//
//  CollectionVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class CollectionVC: UITableViewController {

    
    private struct modelStruct {
        var page:NSInteger = 1
        var ListArray:NSMutableArray? = NSMutableArray.init()
    }
    
    private var productModelStruct:modelStruct = modelStruct()
    private var exposureModelStruct:modelStruct = modelStruct()
    private var PrefomersModelStruct:modelStruct = modelStruct()
    
    private var selectIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="收藏"
        viewinit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        daterequest()
    }
    func viewinit() {
        let segment = ProductOrExposureSelectView.init()
        self.tableView.tableHeaderView=segment
        segment.valueDidChangeWithIndexBlock={[weak self] (index:NSInteger) ->Void in
            self?.selectIndex=index;
            
            if self?.selectIndex==1 && self?.exposureModelStruct.ListArray?.count == 0 {
                self?.daterequest()
            }else if self?.selectIndex==0 && self?.productModelStruct.ListArray?.count == 0 {
                self?.daterequest()
            }else if self?.selectIndex==2 && self?.PrefomersModelStruct.ListArray?.count == 0{
                self?.daterequest()
            }
            
            self?.tableView.reloadData()
        }
        
        self.tableView.rowHeight=UITableViewAutomaticDimension
        self.tableView.sectionFooterHeight=UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight=UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight=10
        self.tableView.estimatedSectionHeaderHeight=5;
        self.tableView.estimatedSectionFooterHeight=5;
        
        self.tableView.register(ReportCell.self, forCellReuseIdentifier: "productCellId")
        self.tableView.register(CollectionExposureCell.self, forCellReuseIdentifier: "CollectionExposureCellID")
    
        self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: { 
            if self.selectIndex == 1{
                self.exposureModelStruct.page+=1
            }else if self.selectIndex == 2{
                self.PrefomersModelStruct.page+=1
            }
            else{
                self.productModelStruct.page+=1
            }
            self.daterequest()
        })
        
        
    }
    
   private func daterequest() {
        MBProgressHUD.showAnimationtoView(self.view)
        if self.selectIndex == 1 {
            
            BaseSeverHttp.zpsyGet(withPath: Api_GetFavoritesExposureBarList, withParams: ["pageNo":self.exposureModelStruct.page], withSuccessBlock: {[unowned self] (result:Any?) in
                MBProgressHUD.hide(for: self.view)
                
                let arr:Array = exposureModel.mj_objectArray(withKeyValuesArray: result) as Array
                
                if self.exposureModelStruct.page == 1{
                    self.exposureModelStruct.ListArray = NSMutableArray.init(array: arr)
                }
                else{
                self.exposureModelStruct.ListArray?.addObjects(from: arr)
                }
                self.tableView.reloadData()
                
            }, withFailurBlock: { (error:Error?) in
                MBProgressHUD.hide(for: self.view)
            })
            
        }else if self.selectIndex == 2 {
            
            BaseSeverHttp.zpsyGet(withPath: Api_getfavoritesPreferenceList, withParams: ["pageNo":self.exposureModelStruct.page], withSuccessBlock: {[unowned self] (result:Any?) in
                MBProgressHUD.hide(for: self.view)
                
                let arr:Array = exposureModel.mj_objectArray(withKeyValuesArray: result) as Array
                
                if self.PrefomersModelStruct.page == 1{
                    self.PrefomersModelStruct.ListArray = NSMutableArray.init(array: arr)
                }
                else{
                    self.PrefomersModelStruct.ListArray?.addObjects(from: arr)
                }
                self.tableView.reloadData()
                
                }, withFailurBlock: { (error:Error?) in
                    MBProgressHUD.hide(for: self.view)
            })
            
        }
        else{
        
            BaseSeverHttp.zpsyGet(withPath: Api_GetFavoritesGoodsList, withParams: ["pageNo":self.productModelStruct.page], withSuccessBlock: {[unowned self] (result:Any?) in
                MBProgressHUD.hide(for: self.view)
                let arr:Array = productModel.mj_objectArray(withKeyValuesArray: result) as Array
                
                if self.productModelStruct.page == 1{
                    self.productModelStruct.ListArray = NSMutableArray.init(array: arr)
                }
                else{
                    self.productModelStruct.ListArray?.addObjects(from: arr)
                }
                self.tableView.reloadData()
            }, withFailurBlock: { (error:Error?) in
                MBProgressHUD.hide(for: self.view)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var listcount = 0
        if self.selectIndex == 0 {
            listcount = (self.productModelStruct.ListArray?.count)!
        }else if self.selectIndex == 1{
            listcount = (self.exposureModelStruct.ListArray?.count)!
        }else if self.selectIndex == 2{
            listcount = (self.PrefomersModelStruct.ListArray?.count)!
        }
        return listcount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.selectIndex==0 {
            let cell:ReportCell = tableView.dequeueReusableCell(withIdentifier: "productCellId", for: indexPath)as! ReportCell
            let model:productModel = self.productModelStruct.ListArray?.object(at: indexPath.row) as! productModel
            cell.ImageView.sd_setImage(with: URL.init(string: model.getfirstGoodImg() ), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            cell.textlab.text = model.name as String?
            cell.timerlab.text = CTUtility.string(from: model.createDateStr as String!, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
            cell.LogoImg.sd_setImage(with: URL.init(string: model.thumbnail! as String), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            return cell
        }else{
            let cell:CollectionExposureCell = tableView.dequeueReusableCell(withIdentifier: "CollectionExposureCellID", for: indexPath)as! CollectionExposureCell
            if self.selectIndex==1 {
                cell.model = self.exposureModelStruct.ListArray?.object(at: indexPath.row) as! exposureModel?
                cell.mycommentType = "1";
            }else if self.selectIndex==2{
                cell.model = self.PrefomersModelStruct.ListArray?.object(at: indexPath.row) as! exposureModel?
                cell.mycommentType = "2";
            }
            
            return cell
        
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.selectIndex == 0{
            
            let model:productModel = self.productModelStruct.ListArray?.object(at: indexPath.row) as! productModel
            let detailVC:ProductDetailVC = ProductDetailVC()
            detailVC.ProductID = model.ID as String?
            self.navigationController?.pushViewController(detailVC, animated: true)
        
        }else{
            let expoDetailVC = ExposureDetailVC()
            if self.selectIndex == 2{
                let model:exposureModel = self.PrefomersModelStruct.ListArray?.object(at: indexPath.row) as! exposureModel
                expoDetailVC.urlStr = model.jumpUrl
                expoDetailVC.thatID = model.ID
                expoDetailVC.webtype = model.field3
                expoDetailVC.detilStr = model.detail
            }else{
                let model:exposureModel = self.exposureModelStruct.ListArray?.object(at: indexPath.row) as! exposureModel
                expoDetailVC.urlStr = model.jumpUrl
                expoDetailVC.thatID = model.ID
                expoDetailVC.webtype = model.field3
                expoDetailVC.detilStr = model.detail
            }
            
            self.navigationController?.pushViewController(expoDetailVC, animated: true)
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

}
