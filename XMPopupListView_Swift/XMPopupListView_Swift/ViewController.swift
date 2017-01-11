//
//  ViewController.swift
//  XMPopupListView_Swift
//
//  Created by TwtMac on 17/1/10.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {

    
    @IBOutlet weak var addressField: UITextField!
    
    var popupListView:XMPopupListView?
    
    let dataSource = ["男","女"]
    
    var currentField: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addressField.delegate = self
        
//        popupListView?.xm_dataSource = self
//        popupListView?.xm_delegate = self
        
//        self.popupListView = XMPopupListView.init(boundView: addressField, dataSource: self, delegate: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.popupListView = XMPopupListView.init(boundView: textField, dataSource: self, delegate: self)
        self.view.addSubview(self.popupListView!)
        popupListView?.show()
        return false
    }
}

extension ViewController: XMPopupListViewDelegate {
    
    func clickedListViewAtIndexPath(indexPath: IndexPath) {
        print(dataSource[indexPath.row])
    }
}

extension ViewController: XMPopupListViewDataSource {
    
    internal func titleInSection(section: NSInteger) -> NSString {
        return ""
    }
    
    internal func numberOfSections() -> NSInteger {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return self.dataSource.count
    }
    
    func itemCellHeight(indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func itemCell(indexPath: IndexPath) -> UITableViewCell {
        if dataSource.count == 0 {
            return UITableViewCell()
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }

}

