//
//  XMPopupListView.swift
//  XMPopupListView_Swift
//
//  Created by TwtMac on 17/1/10.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class XMPopupListView: UIControl {
    
    var boundView1: UIView?
    var dataSource1: Any?
    var delegate1: Any?

    init(boundView: UIView,datasource:Any,delegate:Any) {
        
        super.init(frame: CGRect.zero)
        
        boundView1 = boundView
        dataSource1 = datasource
        delegate1 = delegate
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
