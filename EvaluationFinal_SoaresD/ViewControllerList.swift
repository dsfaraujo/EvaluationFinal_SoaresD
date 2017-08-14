//
//  ViewControllerList.swift
//  EvaluationFinal_SoaresD
//
//  Created by eleves on 2017-08-10.
//  Copyright © 2017 Diana. All rights reserved.
//

import UIKit

class ViewControllerList: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
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
        let s = "\(a) "
        cell.textLabel!.text = s
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
        if obj.lesNotes[obj.values[indexPath.row]]!{
            obj.lesNotes[obj.keys[indexPath.row]] = true
        } else {
            obj.lesNotes[obj.keys[indexPath.row]] = false
        }
        tableView.reloadData()
    }
    //------------------------------------------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            obj.lesNotes[obj.keys[indexPath.row]] = nil
            obj.saveUserDefaults()
            obj.parseDict()
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
}
