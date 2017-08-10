//
//  ViewControllerList.swift
//  EvaluationFinal_SoaresD
//
//  Created by eleves on 2017-08-10.
//  Copyright © 2017 Diana. All rights reserved.
//

import UIKit

class ViewControllerList: UIViewController{

    var obj = ChecklistData()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //-----------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return obj.keys.count
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        let a = obj.keys[indexPath.row]
        let b = obj.values[indexPath.row]
        let s = "\(a) : \(b) "
        cell.textLabel!.text = s
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
    }
    //------------------------------------------
    
    //------------------------------------------
    
    
}
