//
//  HotProductVc.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/23.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class HotProductVc: UICollectionViewController {

    
    init() {
        let  flow = UICollectionViewFlowLayout.init()
        flow.minimumInteritemSpacing = 14
        flow.minimumLineSpacing = 14
        flow.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15)
        let wid = (kScreenWidth-45)/2.0
        flow.itemSize = CGSize.init(width: wid, height: wid)
        super.init(collectionViewLayout:flow)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "正品优选"
        viewinit()
    }

    private var pagNo = 1;
    private var ListArr:NSMutableArray = NSMutableArray.init();
    private func viewinit() {
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(hotProductCell.self, forCellWithReuseIdentifier: "hotProductCellId")
        
        self.collectionView?.mj_footer = MJRefreshAutoStateFooter.init(refreshingBlock: { 
            self.pagNo+=1
            self.datarequest()
        })
        datarequest()
    }
    
    
    
    private func datarequest(){
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_preferenceGetList, withParams: ["pageNo":pagNo], withSuccessBlock: { (result:Any?) in
            self.collectionView?.mj_footer.endRefreshing()
            MBProgressHUD.hide(for: self.view)
            let arr:NSArray = youxuanModel.mj_objectArray(withKeyValuesArray: result)
            if self.pagNo == 0{
                self.ListArr = NSMutableArray.init(array: arr)
            }else{
                self.ListArr.addObjects(from: arr as! [Any])
            }
            self.collectionView?.reloadData()
        }) { (err:Error?) in
            self.collectionView?.mj_footer.endRefreshing()
            MBProgressHUD.hide(for: self.view)
        }
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ListArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:hotProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotProductCellId", for: indexPath) as! hotProductCell
        cell.model = ListArr[indexPath.row]as? youxuanModel
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = ExposureDetailVC()
        let model:youxuanModel = (ListArr[indexPath.row]as? youxuanModel)!
        detailVc.urlStr = model.jumpUrl
        detailVc.thatID = model.id
        detailVc.webtype = model.field3
        detailVc.detilStr = model.detail
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
