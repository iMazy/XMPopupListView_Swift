//
//  ViewController.swift
//  XMPopupListView_Swift
//
//  Created by TwtMac on 17/1/10.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {

    
    @IBOutlet weak var provinceField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var areaField: UITextField!
    
    var popupListView:XMPopupListView?
    
    lazy var dataSource = {
       return Array<Any>()
    }()
    
    var currentField: UITextField?
    
    let sourceArray = [
    ["province":"湖北省",
                "cities":[["city":"武汉市","area":["武昌区","汉口区","汉阳区"]],
                          ["city":"襄阳市","area":["樊城区","襄城区"]]]],
    ["province":"北京市",
                "cities":[["city":"北京市","area":["朝阳区","海淀区","丰台区"]]]],
    ["province":"广东省",
                "cities":[["city":"广州市","area":["越秀区","海珠区","天河区","白云区","黄埔区","南沙区","荔湾区"]],
                          ["city":"深圳市","area":["福田区","龙岗区","罗湖区","宝安区","盐田区","龙华区"]],
                          ["city":"珠海市","area":["香洲区","金湾区","斗门区"]]]]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.currentField = textField
        
        self.dataSource.removeAll()
        
        if textField == provinceField {
            for dict in sourceArray {
                self.dataSource.append(dict["province"] ?? "")
            }
            
        } else if textField == cityField {
            
            for dict in sourceArray {
                if dict["province"] as? String == self.provinceField.text {
                    
                    let cityArray = dict["cities"] as? [AnyObject] ?? []
                    for dic in cityArray {
                        self.dataSource.append(dic["city"] as? String ?? "")
                    }
                }
            }
        } else if textField == areaField {
            for dict in sourceArray {
                if dict["province"] as? String == self.provinceField.text {
                    
                    let cityArray = dict["cities"] as? [[String: AnyObject]] ?? []
                    for dic in cityArray {
                        
                        if dic["city"] as? String == self.cityField.text {
                            
                            self.dataSource = dic["area"] as! [Any]
                        }
                    }
                }
            }
        }
        
        self.popupListView = XMPopupListView.init(boundView: textField, dataSource: self, delegate: self)
        self.view.addSubview(self.popupListView!)
        popupListView?.show()
        return false
    }
}

extension ViewController: XMPopupListViewDelegate {
    
    func clickedListViewAtIndexPath(indexPath: IndexPath) {
        print(dataSource[indexPath.row])
        currentField?.text = dataSource[indexPath.row] as? String ?? ""
        
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
        cell.textLabel?.text = dataSource[indexPath.row] as? String ?? ""
        return cell
    }

}

