//
//  XMPopupListView.swift
//  XMPopupListView_Swift
//
//  Created by TwtMac on 17/1/10.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class XMPopupListView: UIControl {

    var boundView: UIView?
    var xm_dataSource: XMPopupListViewDataSource?
    var xm_delegate: XMPopupListViewDelegate?
    

    init(boundView: UIView,dataSource:XMPopupListViewDataSource,delegate:XMPopupListViewDelegate) {
        
        let screenBounds = UIScreen.main.bounds
        let  fm = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        
        super.init(frame: fm)
        
        backgroundColor = UIColor.init(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.3)
        
        frame = fm
        
        xm_dataSource = dataSource
        xm_delegate = delegate
        
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.clipsToBounds = true
        self.tableView?.layer.cornerRadius = 3
        self.tableView?.separatorStyle = .none
        self.tableView?.backgroundColor = UIColor.white
        
        self.boundView = boundView
       
        self.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        isShowing = false
        
    }
    
    @objc func dismiss() {
        
    }
    
    func show(){
        
    }
    
    var tableView: UITableView?
    
    var isShowing: Bool?
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol XMPopupListViewDelegate {
    
    func clickedListViewAtIndexPath(indexPath: IndexPath)
}

protocol XMPopupListViewDataSource {
    
    func itemCell(indexPath: IndexPath) -> UITableViewCell
    func numberOfRowsInSection(section: NSInteger) -> NSInteger
    
    func numberOfSections() -> NSInteger
    func itemCellHeight(indexPath: IndexPath) -> Float
    func titleInSection(section: NSInteger) -> String
}


extension XMPopupListView: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

