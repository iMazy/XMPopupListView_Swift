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
    
    var isShowing: Bool?
    
    var tableView: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.clipsToBounds = true
        tb.layer.cornerRadius = 3
        tb.separatorStyle = .none
        tb.backgroundColor = UIColor.white
        return tb
    }()
    

    init(boundView: UIView,dataSource:XMPopupListViewDataSource,delegate:XMPopupListViewDelegate) {
        
        let screenBounds = UIScreen.main.bounds
        let  fm = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        
        super.init(frame: fm)
        
        backgroundColor = UIColor.init(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.3)
        
        frame = fm
        
        xm_dataSource = dataSource
        xm_delegate = delegate
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.boundView = boundView
       
        self.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        isShowing = false
        
    }
    
    @objc func dismiss() {
        
        guard let isShowing = isShowing,
            let boundViewframe = boundView?.frame
            else {
                return
        }
        
        if isShowing {
            return
        }
        
        guard let rect = self.boundView?.frame else {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: { 
        
        }) { (_) in
            self.tableView.frame = CGRect(x: rect.minX, y: rect.maxY + 5, width: boundViewframe.width, height: 0)
            self.tableView.removeFromSuperview()
            self.removeFromSuperview()
        }
        self.isShowing = false
    }
    
    func show(){
    
        
        guard let isShowing = isShowing,
         let boundViewframe = boundView?.frame
        else {
            return
        }
        
        if isShowing {
            return
        }
        
        guard let rect = boundView?.superview?.convert(boundViewframe, to: superview) else {
            return
        }
        
        self.tableView.frame = CGRect(x: rect.minX, y: rect.maxY + 5, width: boundViewframe.width, height: 0.0)
        
        superview?.addSubview(self)
        superview?.addSubview(tableView)
        
        let rows = (xm_dataSource?.numberOfRowsInSection(section: 0))! <= 5 ? xm_dataSource?.numberOfRowsInSection(section: 0) : 5
        
        UIView.animate(withDuration: 0.3) {
            self.tableView.frame = CGRect(x: rect.minX, y: rect.maxY + 5, width: boundViewframe.width, height: CGFloat(44 * (rows ?? 0)))
        }
        
        self.isShowing = true
        tableView.reloadData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol XMPopupListViewDelegate {
    
    func clickedListViewAtIndexPath(indexPath: IndexPath)
}

protocol XMPopupListViewDataSource {
    
    func itemCell(indexPath: IndexPath) -> UITableViewCell
    func numberOfRowsInSection(section: Int) -> Int
    
    func numberOfSections() -> NSInteger
    func itemCellHeight(indexPath: IndexPath) -> CGFloat
    func titleInSection(section: NSInteger) -> NSString
}


extension XMPopupListView: UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (self.xm_dataSource != nil) {
            return (self.xm_dataSource?.itemCellHeight(indexPath: indexPath))!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.xm_delegate != nil {
            self.xm_delegate?.clickedListViewAtIndexPath(indexPath: indexPath)
        }
        self.dismiss()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        if self.xm_dataSource != nil {
            return (self.xm_dataSource?.numberOfSections())!
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.xm_dataSource != nil {
            return (self.xm_dataSource?.numberOfRowsInSection(section: section))!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.xm_dataSource != nil {
            return (self.xm_dataSource?.itemCell(indexPath: indexPath))!
        }
        return UITableViewCell()
    }
}

